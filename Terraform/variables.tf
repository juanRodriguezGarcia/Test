# variables.tf
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my_project"
}

variable "environment" {
  description = "Environment for deployment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "lambda_role_arn" {
  description = "rol de lambda"
  type        = string
  default     = "arn:xxx"
}

variable "lambda_zip_file" {
  description = "Ruta s3 del zip de la lambda"
  type        = string
  default     = "s3://xxx"
}