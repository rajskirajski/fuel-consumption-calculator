variable "project_name" {
  type        = string
  description = "Project name."
}

variable "image_uri" {
  type        = string
  description = "Lambda container image URI."
}

variable "lambda_role_arn" {
  type        = string
  description = "Lambda IAM role ARN."
}

variable "memory_size" {
  type        = number
  description = "Lambda memory size."
}

variable "timeout" {
  type        = number
  description = "Lambda timeout."
}

variable "environment" {
  type        = string
  description = "Application environment."
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
}
