# modules/lambda/variables.tf
variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "lambda_role_arn" {
  description = "ARN of the IAM role for Lambda"
  type        = string
}

variable "lambda_zip_file" {
  description = "Path to the ZIP file containing the Lambda function code"
  type        = string
}

variable "s3_bucket_id" {
  description = "ID of the S3 bucket to be passed to the Lambda"
  type        = string
}