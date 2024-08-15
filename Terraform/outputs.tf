# outputs.tf
output "lambda_arn" {
  value = module.lambda.lambda_arn
}
output "lambda_id" {
  value = module.lambda.lambda_id
}
output "s3_bucket_name" {
  value = module.s3.bucket_name
}
output "s3_bucket_id" {
  value = module.s3.bucket_id
}
