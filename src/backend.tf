terraform {
  backend "s3" {
    key     = "tf-training/vpc/terraform.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
