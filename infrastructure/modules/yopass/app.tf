module "yopass" {
  source  = "terraform-registry.deliveroo.net/deliveroo/roo_app_basic/aws"
  version = "~> 5.0"

  uses_feature_flags = "true"
  sentry_enabled     = "false"

  app_name  = "yopass"
  repo_name = "yopass"

  owner_email   = local.owner_emails["SECURITY_ENGINEERING"]
  rota_link     = local.rota_links["SECURITY_ENGINEERING"]
  slack_url     = local.slack_urls["SECURITY_ENGINEERING"]
  playbook_link = "https://github.com/deliveroo/yopass"
  description   = "Burn after reading password sharing. No logging and the server doesn't have the key"
  tier          = 4
  team_name     = local.supported_team_names["SECURITY_ENGINEERING"]

  tracked_branch = var.env_name == "production" ? "master" : var.env_name
  force_delete = var.env_name == "production" ? true : false
}

module "yopass_web" {
  source  = "terraform-registry.deliveroo.net/deliveroo/roo-service/aws"
  version = "~> 2.0"

  service_type = "public_web"

  application    = module.yopass.config
  service_name   = "web"
  container_port = 80

  health_check_codes       = "200"
  health_check_path        = "/"
  alb_anomaly_bounds       = 6
  alb_anomaly_should_alert = false
  health_check_interval    = 30

  force_delete = var.env_name == "production" ? true : false
}
