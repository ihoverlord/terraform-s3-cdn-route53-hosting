resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.s3_bucket_name_for_hosting
  tags = {
    Environment = "Dev"
  }
  prevent_destory = false
}
