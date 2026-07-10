locals {
  common_tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
    Owner     = var.github_owner
  }

  image_uri = "${module.ecr.repository_url}:${var.image_tag}"
}

module "ecr" {
  source = "./modules/ecr"

  project_name = var.project_name
  tags         = local.common_tags
}

module "oidc" {
  source = "./modules/oidc"

  tags = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  project_name       = var.project_name
  aws_region         = var.aws_region
  aws_account_id     = var.aws_account_id
  ecr_repository_arn = module.ecr.repository_arn
  oidc_provider_arn  = module.oidc.provider_arn
  github_owner       = var.github_owner
  github_repository  = var.github_repository
  tags               = local.common_tags
}

module "cloudwatch" {
  source = "./modules/cloudwatch"

  count = var.enable_app_stack ? 1 : 0

  project_name = var.project_name
  tags         = local.common_tags
}

module "lambda" {
  source = "./modules/lambda"
  count  = var.enable_app_stack ? 1 : 0

  project_name    = var.project_name
  image_uri       = local.image_uri
  lambda_role_arn = module.iam.lambda_role_arn

  memory_size = var.lambda_memory_size
  timeout     = var.lambda_timeout
  environment = "production"

  tags = local.common_tags

  depends_on = [
    terraform_data.bootstrap_image,
    module.iam,
    module.cloudwatch,
  ]
}

module "apigateway" {
  source = "./modules/apigateway"

  count = var.enable_app_stack ? 1 : 0

  project_name         = var.project_name
  lambda_function_arn  = module.lambda[0].function_arn
  lambda_function_name = module.lambda[0].function_name
  lambda_invoke_arn    = module.lambda[0].invoke_arn
  tags                 = local.common_tags
}
