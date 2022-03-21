variable "aws_profile" {
  description = "terraform を実行する AWS ユーザーの profile 指定"
  type        = string
  default     = null
}

variable "assume_role_arn" {
  description = "terraform 実行時に AssumeRole させたいロールの ARN"
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "新規作成する VPC CIDR"
  type        = string
  default     = "172.16.0.0/16"
}

locals {
  project_name    = "AWSTraining"
  app_name        = "SharedVPC"
  name_tag_prefix = "${local.project_name}-${local.app_name}"

  region = "ap-northeast-1"

  az_suffix = [
    "a", "c", "d",
  ]
  az = [
    "${local.region}${local.az_suffix[0]}",
    "${local.region}${local.az_suffix[1]}",
    "${local.region}${local.az_suffix[2]}",
  ]
}
