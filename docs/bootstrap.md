# Bootstrap and deployment guide

This project uses AWS Lambda with a container image. Lambda cannot be created from an ECR image tag until that image already exists. For that reason, the first deployment is split into two Terraform steps and one Docker push.

## 1. Initial Terraform bootstrap

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

At this stage, `enable_app_stack` should be:

```hcl
enable_app_stack = false
```

This creates:

- Amazon ECR repository
- GitHub OIDC provider
- IAM role for GitHub Actions
- IAM role for Lambda
- IAM policies

It does not create Lambda or API Gateway yet.

## 2. Push bootstrap image to ECR

```bash
cd ..
chmod +x scripts/bootstrap-image.sh
./scripts/bootstrap-image.sh
```

The script builds a Lambda-compatible image:

```bash
docker buildx build \
  --platform linux/amd64 \
  --provenance=false \
  --sbom=false \
  --output type=docker
```

Then it pushes:

```text
207909166461.dkr.ecr.eu-central-1.amazonaws.com/fuel-consumption-calculator:bootstrap
```

## 3. Enable application stack

Edit:

```text
terraform/terraform.tfvars
```

Set:

```hcl
enable_app_stack = true
image_tag = "bootstrap"
```

Apply again:

```bash
cd terraform
terraform apply
```

This creates:

- Lambda function
- API Gateway HTTP API
- routes
- Lambda permission for API Gateway
- CloudWatch log group

## 4. Test deployed API

```bash
curl https://YOUR_API_ID.execute-api.eu-central-1.amazonaws.com/health
```

Expected response:

```json
{
  "status": "healthy"
}
```

Swagger UI:

```text
https://YOUR_API_ID.execute-api.eu-central-1.amazonaws.com/docs
```

## 5. Future deployments

After bootstrap, push changes to `main`.

GitHub Actions CD will build, push and deploy automatically.
