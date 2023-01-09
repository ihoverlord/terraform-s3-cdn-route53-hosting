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

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.S3Bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.example.id
    origin_id                = aws_s3_bucket.S3Bucket.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  price_class = "PriceClass_100"
  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.S3Bucket.id

    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

  }
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB"]
    }
  }

  tags = {
    Environment = "development"
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
