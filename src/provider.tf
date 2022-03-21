provider "aws" {
  region  = local.region
  profile = var.aws_profile

  assume_role {
    role_arn = var.assume_role_arn
  }

  default_tags {
    tags = {
      Project     = local.project_name
      Application = local.app_name
      CreatedBy   = "terraform"
    }
  }
}
