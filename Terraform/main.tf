# main.tf
provider "aws" {
  region = var.region
}

module "lambda" {
  source       = "./modules/lambda"
  project_name = var.project_name
  environment  = var.environment
  lambda_role_arn  = var.lambda_role_arn
  lambda_zip_file  = var.lambda_zip_file
  s3_bucket_id    = module.s3.bucket_id  # Pasar el ID del bucket S3 como variable
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}