# resources.tf - Defines all AWS infrastructure resources

# ===================================================================
#  1. S3 Bucket Resources
# ===================================================================

# S3 Bucket Resource
resource "aws_s3_bucket" "website" {
  bucket = var.bucket_name

  tags = {
    Name        = "Portfolio Static Website"
    Environment = "Production"
  }
}

# S3 Public Access Block (Blocks all public access)
resource "aws_s3_bucket_public_access_block" "website_access_block" {
  bucket = aws_s3_bucket.website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Policy Document (Grants read access ONLY to the specific CloudFront ARN via OAC)
data "aws_iam_policy_document" "s3_oac_access" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.website.arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.s3_distribution.arn]
    }
  }
}

# Apply the secure policy to the S3 bucket
resource "aws_s3_bucket_policy" "website_policy" {
  bucket = aws_s3_bucket.website.id
  policy = data.aws_iam_policy_document.s3_oac_access.json
}

# ===================================================================
# 2. CloudFront Resources (CDN and OAC)
# ===================================================================

# CloudFront Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = "${var.bucket_name}-oac"
  description                       = "OAC for secure access to S3 website bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}


# CloudFront Distribution
resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id                = "S3-OAC-Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3-OAC-Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = "Portfolio CloudFront"
    Environment = "Production"
  }
}
