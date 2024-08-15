# modules/lambda/main.tf
locals {
  lambda_name = "${var.project_name}-${var.environment}-lambda"
}

resource "aws_lambda_function" "lambda" {
  function_name = local.lambda_name
  runtime       = "nodejs16.x"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  filename      = var.lambda_zip_file
  
  environment {
    variables = {
      S3_BUCKET_ID = var.s3_bucket_id  # Pasar el ID del bucket S3
    }
  }
  
}

output "lambda_arn" {
  value = aws_lambda_function.lambda.arn
}

output "lambda_id" {
  value = aws_lambda_function.lambda.id
}