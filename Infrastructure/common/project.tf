module "project" {
  source                      = "terraform-google-modules/project-factory/google"
  version                     = "17.0.0"
  random_project_id           = false
  name                        = var.project_name
  org_id                      = var.org_id
  billing_account             = var.billing_account
  activate_apis               = local.gcp_services
  disable_services_on_destroy = false
  disable_dependent_services  = false
  auto_create_network         = true
  default_service_account     = "keep"
}
