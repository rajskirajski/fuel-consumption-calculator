# Terraform deployment

## Bootstrap flow

Lambda Container Image cannot be created before an image exists in ECR.  
This repository solves that with a clean two-step bootstrap.

### 1. Create base infrastructure

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

This creates:

- ECR
- GitHub OIDC provider
- IAM roles and policies

### 2. Push bootstrap image

From repository root:

```bash
chmod +x scripts/bootstrap-image.sh
./scripts/bootstrap-image.sh
```

### 3. Enable Lambda and API Gateway

Edit `terraform/terraform.tfvars`:

```hcl
enable_app_stack = true
image_tag = "bootstrap"
```

Then:

```bash
cd terraform
terraform apply
```

### 4. Future deploys

Push to `main`. GitHub Actions will build a new image, push it to ECR and update Lambda.
