output "ecr_repository_url" {
  description = "ECR repository URL."
  value       = module.ecr.repository_url
}

output "github_actions_role_arn" {
  description = "IAM role ARN used by GitHub Actions OIDC."
  value       = module.iam.github_actions_role_arn
}

output "lambda_function_name" {
  description = "Lambda function name."
  value       = var.enable_app_stack ? module.lambda[0].function_name : null
}

output "api_endpoint" {
  description = "Public API Gateway endpoint."
  value       = var.enable_app_stack ? module.apigateway[0].api_endpoint : null
}
