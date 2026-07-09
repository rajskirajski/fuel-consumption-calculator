resource "aws_lambda_function" "this" {
  function_name = var.project_name
  role          = var.lambda_role_arn
  package_type  = "Image"
  image_uri     = var.image_uri

  memory_size = var.memory_size
  timeout     = var.timeout

  environment {
    variables = {
      ENVIRONMENT = var.environment
      APP_NAME    = "Fuel Consumption Calculator"
      VERSION     = "1.0.0"
    }
  }

  tags = var.tags
}
