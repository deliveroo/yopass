module "yopass" {
  source = "../../modules/yopass"

  env_name  = var.env_name
  team_name = var.team_name
}