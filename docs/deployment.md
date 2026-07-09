# Deployment guide

## Bootstrap

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform apply
```

## Push first image

```bash
./scripts/bootstrap-image.sh
```

## Enable application stack

Change in `terraform/terraform.tfvars`:

```hcl
enable_app_stack = true
```

Then:

```bash
terraform apply
```

## Deploy updates

Push to `main`.
