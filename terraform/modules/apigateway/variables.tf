variable "project_name" {
  type        = string
  description = "Project name."
}

variable "lambda_function_arn" {
  type        = string
  description = "Lambda function ARN."
}

variable "lambda_function_name" {
  type        = string
  description = "Lambda function name."
}

variable "lambda_invoke_arn" {
  type        = string
  description = "Lambda invoke ARN."
}

variable "tags" {
  type        = map(string)
  description = "Common tags."
}
