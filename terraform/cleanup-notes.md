# Terraform cleanup notes

To remove all AWS infrastructure:

```bash
terraform destroy
```

The ECR repository is configured with:

```hcl
force_delete = true
```

so Terraform can remove it even when Docker images exist inside.
