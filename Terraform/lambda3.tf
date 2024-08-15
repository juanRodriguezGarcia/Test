# lambda3.tf

module "lambda3" {
  source       = "./modules/lambda"
  project_name = "demo-terraform-juan-03-dev-lambda-v3"
  environment  = var.environment
  lambda_role_arn  = var.lambda_role_arn
  lambda_zip_file  = var.lambda_zip_file
  s3_bucket_id    = module.s3.bucket_id  
}