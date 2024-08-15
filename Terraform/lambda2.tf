# lambda2.tf

module "lambda2" {
  source       = "./modules/lambda"
  project_name = "demo-terraform-juan-02-dev-lambda-v2"
  environment  = var.environment
  lambda_role_arn  = var.lambda_role_arn
  lambda_zip_file  = var.lambda_zip_file
  s3_bucket_id    = module.s3.bucket_id  
}