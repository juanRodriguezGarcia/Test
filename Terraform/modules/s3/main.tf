# modules/s3/main.tf
locals {
  bucket_name = "${var.project_name}-${var.environment}-bucket"
}

resource "aws_s3_bucket" "bucket" {
  bucket = local.bucket_name
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}

output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}