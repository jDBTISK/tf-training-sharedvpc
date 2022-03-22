terraform {
  backend "s3" {
    key     = "tf-training/shared_vpc.tfstate"
    region  = "ap-northeast-1"
    encrypt = true
  }
}
