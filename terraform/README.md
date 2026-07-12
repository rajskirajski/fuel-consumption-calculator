# Terraform deployment

This directory contains the Infrastructure as Code configuration for the AWS deployment of the Fuel Consumption Calculator.

Terraform manages:

- Amazon ECR repository,
- AWS Lambda function,
- Amazon API Gateway HTTP API,
- Amazon CloudWatch Logs,
- IAM roles and policies,
- GitHub OIDC provider and deployment role.

## Prerequisites

Before running Terraform, make sure you have:

- Terraform installed,
- AWS CLI installed and authenticated to the target AWS account,
- Docker Desktop running,
- access to the repository root directory,
- permission to create IAM, Lambda, API Gateway, ECR and CloudWatch resources.

The first deployment uses local Docker and AWS CLI commands through `terraform_data` and `local-exec`.

## Configuration

Copy the example variables file:

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

Update the values in `terraform.tfvars`:

```hcl
project_name      = "fuel-consumption-calculator"
aws_region        = "eu-central-1"
aws_account_id    = "<AWS_ACCOUNT_ID>"
github_owner      = "<GITHUB_USERNAME>"
github_repository = "fuel-consumption-calculator"

enable_app_stack = true
image_tag         = "bootstrap"
```

The real `terraform.tfvars` file is ignored by Git and must not be committed.

## Initialize and validate

```bash
terraform init
terraform fmt -check -recursive
terraform validate
```

Review the planned changes:

```bash
terraform plan
```

## Deploy

```bash
terraform apply
```

During the initial deployment Terraform automatically:

1. creates the Amazon ECR repository,
2. authenticates Docker to Amazon ECR,
3. builds a Lambda-compatible `linux/amd64` container image,
4. pushes the image using the configured `image_tag`,
5. creates the Lambda function,
6. creates API Gateway routes and integration,
7. creates the CloudWatch log group,
8. returns deployment outputs.

No separate bootstrap script or second `terraform apply` is required.

## Outputs

After a successful deployment Terraform returns:

- `api_endpoint`,
- `ecr_repository_url`,
- `github_actions_role_arn`,
- `lambda_function_name`.

Display them with:

```bash
terraform output
```

## Verify the deployment

```bash
curl "$(terraform output -raw api_endpoint)/health"
```

```bash
curl "$(terraform output -raw api_endpoint)/version"
```

```bash
curl -X POST "$(terraform output -raw api_endpoint)/kalkulatorspalania"   -H "Content-Type: application/json"   -d '{"distance_km":500,"fuel_used_liters":40,"fuel_price":6.5}'
```

## Application updates

After the infrastructure has been created, application updates are deployed by the GitHub Actions CD workflow.

A push or merge to `main` triggers:

1. Docker image build,
2. Trivy security scan,
3. image push to Amazon ECR,
4. Lambda code update,
5. `/health` smoke test.

## Cleanup

Remove all Terraform-managed AWS resources:

```bash
terraform destroy
```

The ECR repository is configured for deletion together with stored images.

After cleanup, the next:

```bash
terraform apply
```

recreates the complete stack and automatically rebuilds and pushes the bootstrap image.
