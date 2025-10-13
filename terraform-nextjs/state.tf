# state.tf

# ===================================================================
#  Backend Configuration
# ===================================================================

terraform {
  # Remote State Backend Configuration (from state.tf)
  backend "s3" {
    bucket         = "pk-nextjs-website-state"
    key            = "global/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "pk-nextjs-website-table"
  }

  # Required Providers (from main.tf)
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}