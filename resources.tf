resource "aws_s3_bucket" "S3Bucket" {
  bucket = var.s3_bucket_name_for_hosting
  tags = {
    Environment = "Dev"
  }
  prevent_destory = false
}

resource "aws_s3_bucket_acl" "s3_bucket_private_acl" {
  bucket = aws_s3_bucket.S3Bucket.id
  acl    = "private"
}
