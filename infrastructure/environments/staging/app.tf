locals {
  yopass_web_host = {
    staging = "passwords-staging.deliveroo.net"
  }
  owner_emails = {
    SECURITY_ENGINEERING = "security@deliveroo.co.uk"
  }
  rota_links = {
    SECURITY_ENGINEERING = "https://deliveroo.pagerduty.com/schedules#PLBV7XB"
  }
  slack_urls = {
    SECURITY_ENGINEERING = "https://deliveroo.slack.com/archives/CTY19E1DG"
  }
}

# Cryptonote replacement (SECENG-170)
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
}

module "yopass_web" {
  source  = "terraform-registry.deliveroo.net/deliveroo/roo-service/aws"
  version = "~> 2.0"

  service_type = "public_web"

  application    = module.yopass.config
  service_name   = "web"
  container_port = 80
}

module "yopass_web_identity" {
  source  = "terraform-registry.deliveroo.net/deliveroo/identity_auth/aws"
  version = "~> 6.0"

  ecs_service_name = module.yopass_web.service_name
  env_name         = var.env_name
  extra_scopes     = ["employee", "engineer.contractor"]
  lb_listener_arn  = module.yopass_web.lb_listener_arn
  redirect_uris    = ["https://${local.yopass_web_host[var.env_name]}/oauth2/idpresponse"]
  target_group_arn = module.yopass_web.target_group_arn
}
