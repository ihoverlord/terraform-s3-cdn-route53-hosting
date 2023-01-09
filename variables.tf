variable "s3_bucket_name_for_hosting" {
  type        = string
  description = "S3 bucket name for hosting code artifacts"
  default     = "s3_bucket_for_hosting_with_tf"
}

variable "aws_route53_record_name" {
  type        = string
  description = "Route53 record name"
  default     = "dev.example.com"
}
