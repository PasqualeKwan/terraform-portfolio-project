# main.tf

# ===================================================================
#  Providers and Variables
# ===================================================================

# AWS Provider Configuration
provider "aws" {
  region = var.aws_region
}

# Input Variables
variable "aws_region" {
  description = "The AWS region to deploy resources into (eu-west-2 is required for CloudFront certs)"
  type        = string
  default     = "eu-west-2"
}

variable "bucket_name" {
  description = "Globally unique name for the S3 bucket"
  type        = string
  default     = "pkwan-portfolio-project-nextjs-website-v2"
}
