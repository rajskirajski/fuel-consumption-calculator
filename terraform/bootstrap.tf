# Automatyczny bootstrap obrazu ECR dla pierwszego wdrożenia po terraform destroy.
#
# Kolejność:
# 1. Terraform tworzy repozytorium ECR.
# 2. local-exec loguje Docker do ECR.
# 3. Obraz jest budowany i wysyłany z tagiem bootstrap.
# 4. Dopiero potem tworzona jest Lambda.

data "aws_caller_identity" "bootstrap" {}

locals {
  bootstrap_app_files = fileset("${path.module}/../app", "**")

  bootstrap_source_hash = sha256(join("", concat(
    [
      filesha256("${path.module}/../Dockerfile"),
      filesha256("${path.module}/../requirements.txt"),
    ],
    [
      for file_name in sort(tolist(local.bootstrap_app_files)) :
      filesha256("${path.module}/../app/${file_name}")
    ]
  )))

  bootstrap_ecr_registry = "${data.aws_caller_identity.bootstrap.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  bootstrap_image_uri    = "${module.ecr.repository_url}:${var.image_tag}"
}

resource "terraform_data" "bootstrap_image" {
  triggers_replace = [
    module.ecr.repository_url,
    local.bootstrap_source_hash,
  ]

  provisioner "local-exec" {
    working_dir = "${path.module}/.."

    interpreter = ["/bin/bash", "-c"]

    command = <<-EOT
      set -Eeuo pipefail

      echo "Sprawdzanie Docker daemon..."
      docker info >/dev/null

      echo "Logowanie Docker do Amazon ECR..."
      aws ecr get-login-password \
        --region "${var.aws_region}" \
        | docker login \
          --username AWS \
          --password-stdin \
          "${local.bootstrap_ecr_registry}"

      echo "Budowanie obrazu Lambda..."
      docker buildx build \
        --platform linux/amd64 \
        --provenance=false \
        --load \
        --tag "${local.bootstrap_image_uri}" \
        .

      echo "Wysyłanie obrazu bootstrap do ECR..."
      docker push "${local.bootstrap_image_uri}"

      echo "Weryfikacja obrazu w ECR..."
      aws ecr describe-images \
        --region "${var.aws_region}" \
        --repository-name "${var.project_name}" \
        --image-ids imageTag="${var.image_tag}" \
        >/dev/null

      echo "Obraz bootstrap jest dostępny: ${local.bootstrap_image_uri}"
    EOT
  }

  depends_on = [
    module.ecr,
  ]
}
