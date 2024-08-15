# lambda4.tf

resource "aws_lambda_function" "new_lambda" {
  function_name = "demo-terraform-juan-05-dev-lambda-v5"
  runtime       = "nodejs16.x"
  role          = var.lambda_role_arn
  handler       = "index.handler"
  filename      = "./lambda.zip"

  environment {
    variables = {
      S3_BUCKET_ID = module.s3.bucket_id
    }
  }
}
