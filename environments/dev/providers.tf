provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "renter"
      Environment = var.environment
      ManagedBy   = "terraform"
    }
  }
}
