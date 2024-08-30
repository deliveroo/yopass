module "yopass_prod" {
  source = "../../modules/yopass"

  env_name  = var.env_name
  redirect_uri = "passwords.deliveroo.net"
}