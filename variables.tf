variable "s3_bucket_name_for_hosting" {
  type        = string
  description = "S3 bucket name for hosting code artifacts"
  default     = "s3_bucket_for_hosting_with_tf"
}
