# Security

Implemented controls:
- GitHub Actions use OIDC to authenticate to AWS.
- No static AWS keys are stored in GitHub.
- Workflow permissions are scoped explicitly.
- Python dependencies are pinned.
- Dependabot is configured for pip, Docker and GitHub Actions.
- pip-audit scans Python dependencies.
- Trivy scans the Docker image before deployment.
- Checkov scans Terraform configuration.
- ECR scan on push is enabled.
- IAM roles are used instead of IAM users.
- CloudWatch log retention is set to 14 days.

Note: scans use `continue-on-error: true` for academic usability. In production, critical findings should fail the pipeline.
