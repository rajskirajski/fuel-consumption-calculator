variable "project_name" {
  type        = string
  description = "Project name."
}

variable "aws_region" {
  type        = string
  description = "AWS region."
}

variable "aws_account_id" {
  type        = string
  description = "AWS account ID."
}

variable "ecr_repository_arn" {
  type        = string
  description = "ECR repository ARN."
}

variable "oidc_provider_arn" {
  type        = string
  description = "GitHub OIDC provider ARN."
}

variable "github_owner" {
  type        = string
  description = "GitHub owner."
}

variable "github_repository" {
  type        = string
  description = "GitHub repository."
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
}
