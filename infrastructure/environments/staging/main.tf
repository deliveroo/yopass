module "yopass_staging" {
  source = "../../modules/yopass"

  env_name  = var.env_name
  redirect_uri = "passwords-staging.deliveroo.net"
}