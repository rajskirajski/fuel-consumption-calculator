# Cleanup guide

Use this when you want to remove all AWS resources created by this project.

## Destroy infrastructure

```bash
cd terraform
terraform destroy
```

Confirm with:

```text
yes
```

Terraform should remove:

- API Gateway
- Lambda
- CloudWatch Log Group
- IAM policies
- IAM roles
- GitHub OIDC provider
- ECR repository

## Important ECR note

The ECR repository has:

```hcl
force_delete = true
```

This means Terraform can delete the repository even if it contains images.

## Optional local Docker cleanup

```bash
docker image prune -f
docker builder prune -f
```

## Optional local Terraform cleanup

Do not delete `terraform.tfstate` if you still manage existing AWS resources.

If the infrastructure has already been destroyed and you only want to clean local files:

```bash
rm -rf .terraform
rm -f .terraform.lock.hcl
```

## Verify in AWS Console

After destroy, check:

- Lambda
- API Gateway
- ECR
- CloudWatch Log Groups
- IAM roles

Resource names should start with:

```text
fuel-consumption-calculator
```
