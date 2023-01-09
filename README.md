# terraform-s3-cdn-route53-hosting
Terraform script to create infrastructure for static site hosting using S3 + Cloudfront + Route 53 Records

## Steps to use the script

1. update Provider with AWS REGION and AWS PROFILE ```versions.tf``` file

```
provider "aws" {
  region  = "us-east-1"
  profile = "default"
}
```

2. Update Variables default values in ```variables.tf``` file

```
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

variable "aws_route53_zone_id" {
  type        = string
  description = "Route53 Zone ID"
  default     = ""
}
```

3. Plan and Apply terraform 
4. Upload your artifacts to the newly created S3 bucket root folder

```aws s3 sync /build .```
