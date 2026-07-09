# Portfolio summary

## Project name

Fuel Consumption Calculator

## Short description

A containerized FastAPI application deployed to AWS Lambda with API Gateway. Infrastructure is managed by Terraform and deployments are automated through GitHub Actions using OIDC authentication.

## What this project demonstrates

- Python API development with FastAPI
- Automated tests with Pytest
- Code quality checks with Ruff and Black
- Docker image build for AWS Lambda
- ECR image registry usage
- AWS Lambda container deployment
- API Gateway HTTP API integration
- CloudWatch log configuration
- Terraform Infrastructure as Code
- GitHub Actions CI/CD
- OIDC-based authentication without static AWS keys
- Bootstrap flow for Lambda container images
- Basic smoke testing after deployment

## Talking points for interview

1. Why Lambda container images were used instead of ZIP deployment.
2. Why bootstrap is needed before creating Lambda.
3. How GitHub OIDC improves security compared with static AWS keys.
4. How Terraform modules organize AWS infrastructure.
5. How CI and CD are separated.
6. How Docker image compatibility with Lambda was fixed.
7. How cleanup is handled with Terraform destroy.
