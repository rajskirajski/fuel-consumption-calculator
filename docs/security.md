# Security

The project uses several security controls across the source code, CI/CD pipelines and AWS infrastructure.

## Authentication and credentials

- GitHub Actions authenticate to AWS using OpenID Connect.
- No long-lived AWS access keys are stored in the repository.
- AWS credentials issued to GitHub Actions are temporary.
- IAM roles are used instead of IAM users for application and deployment access.
- Workflow permissions are declared explicitly.

## IAM access control

- The GitHub Actions role trust policy is restricted to this repository and the `main` branch.
- The deployment role is limited to the ECR repository and Lambda function used by this project.
- The Lambda execution role has only the CloudWatch Logs permissions required by the application.
- API Gateway is allowed to invoke only the project Lambda function.

## Source code and dependencies

- Python dependencies are pinned.
- Dependabot monitors pip, Docker and GitHub Actions dependencies.
- `pip-audit` scans Python dependencies in CI.
- Ruff and Black enforce code quality and formatting.
- Pytest verifies application behaviour and request validation.

## Container security

- Trivy scans the locally built Docker image before it is pushed to Amazon ECR.
- The CD workflow stops when Trivy detects fixed `HIGH` or `CRITICAL` vulnerabilities.
- Amazon ECR scan-on-push is enabled.
- The Lambda image is built for `linux/amd64` with provenance disabled for Lambda compatibility.

## Infrastructure security

- Terraform manages the AWS infrastructure and IAM configuration.
- Checkov scans Terraform configuration.
- CloudWatch log retention is limited to 14 days.
- The ECR lifecycle policy keeps only the most recent images.
- Local `.env`, `*.tfvars`, Terraform state and key files are excluded through `.gitignore`.

## Pipeline behaviour

`pip-audit` and Checkov are currently informational and use `continue-on-error: true`.

Trivy is blocking: fixed `HIGH` or `CRITICAL` vulnerabilities stop the CD workflow before the image is pushed and deployed.

## Recommended repository settings

For the `main` branch, enable:

- pull requests before merge,
- required CI and Terraform checks,
- blocked force pushes,
- blocked branch deletion,
- two-factor authentication for the repository owner.
