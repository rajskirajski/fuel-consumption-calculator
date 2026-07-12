variable "project_name" {
  description = "Project name used for naming AWS resources."
  type        = string
  default     = "fuel-consumption-calculator"
}

variable "aws_region" {
  description = "AWS region."
  type        = string
  default     = "eu-central-1"
}

variable "aws_account_id" {
  description = "AWS account ID."
  type        = string
  default     = "207909166461"
}

variable "github_owner" {
  description = "GitHub repository owner."
  type        = string
  default     = "rajskirajski"
}

variable "github_repository" {
  description = "GitHub repository name."
  type        = string
  default     = "fuel-consumption-calculator"
}

variable "image_tag" {
  description = "Docker image tag deployed to Lambda."
  type        = string
  default     = "bootstrap"
}

variable "enable_app_stack" {
  description = "Create the Lambda, CloudWatch and API Gateway application stack."
  type        = bool
  default     = false
}

variable "lambda_memory_size" {
  description = "Lambda memory size in MB."
  type        = number
  default     = 512
}

variable "lambda_timeout" {
  description = "Lambda timeout in seconds."
  type        = number
  default     = 30
}
