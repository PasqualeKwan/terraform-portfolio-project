# output.tf

# ===================================================================
#  Outputs
# ===================================================================

output "bucket_id" {
  description = "The name (ID) of the S3 website bucket"
  value       = aws_s3_bucket.website.id
}

output "bucket_website_endpoint" {
  description = "The S3 bucket's regional domain name (used as origin in CloudFront)"
  value       = aws_s3_bucket.website.bucket_regional_domain_name
}

output "cloudfront_url" {
  description = "The domain name of the CloudFront distribution"
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "cloudfront_arn" {
  description = "The ARN of the CloudFront distribution for use in S3 bucket policy"
  value       = aws_cloudfront_distribution.s3_distribution.arn
}
