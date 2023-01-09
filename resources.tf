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

resource "aws_s3_bucket_policy" "allow_access_from_cloudfront" {
  bucket = aws_s3_bucket.S3Bucket.id
  policy = <<EOF
            {
                "Version": "2012-10-17",
                "Statement": [
                    {
                        "Sid": "PolicyForCloudFront",
                        "Effect": "Allow",
                        "Principal": {
                            "Service": "cloudfront.amazonaws.com"
                        },
                        "Action": "s3:GetObject",
                        "Resource": "${aws_s3_bucket.example.arn}/*"
                    }
                ]
            }
            EOF
}
