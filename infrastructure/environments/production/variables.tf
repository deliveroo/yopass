variable "env_name" { default = "production" }
variable "shard" { default = "global" }
variable "region" { default = "eu-west-1" }
variable "team_name" { default = "security-engineering" }

variable "datadog_api_key" {}
variable "datadog_app_key" {}

data "roo_aws_account" "current" {}

data "roo_tags" "defaults" {}
