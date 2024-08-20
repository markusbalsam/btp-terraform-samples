
###
# Assignment of basic entitlements for an ABAP setup
###
resource "btp_subaccount_entitlement" "abap-trial" {
  subaccount_id = var.subaccount_id
  service_name  = "abap-trial"
  plan_name     = "shared"
  amount        = 1
}

###
# Retrieval of existing CF environment instance
###
data "btp_subaccount_environment_instances" "all" {
  subaccount_id = var.subaccount_id
}

locals {
  cf_instance = [for env in data.btp_subaccount_environment_instances.all.values : env if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"][0]
  cf_api_url = lookup(jsondecode(local.cf_instance.labels), "API Endpoint", "")
}

###
# Assignment of Cloud Foundry space roles 
###
resource "cloudfoundry_org_role" "org_managers" {
  for_each = toset(var.cf_org_managers)
  username = each.value
  type     = "organization_manager"
  org      = local.cf_instance.platform_id
}

###
# Fetch Cloud Foundry space "dev"
###
data "cloudfoundry_space" "dev" {
  name  = "dev"
  org   = local.cf_instance.platform_id
}

###
# Assignment of Cloud Foundry space roles 
###
resource "cloudfoundry_space_role" "space_managers" {
  for_each = toset(var.cf_space_managers)
  username = each.value
  type     = "space_manager"
  space    = data.cloudfoundry_space.dev.id
}

resource "cloudfoundry_space_role" "space_developers" {
  for_each = toset(var.cf_space_developers)
  username = each.value
  type     = "space_developer"
  space    = data.cloudfoundry_space.dev.id
}

###
# Retrieve the current user information
###
data "btp_whoami" "me" {}

data "cloudfoundry_users" "all" {
  org = local.cf_instance.platform_id
}

###
# Creation of service instance for ABAP
###
data "cloudfoundry_service" "abap_service_plans" {
  name = "abap-trial"
}

resource "cloudfoundry_service_instance" "abap_trial" {
  depends_on   = [cloudfoundry_space_role.space_managers, cloudfoundry_space_role.space_developers]
  name         = "abap-trial"
  space        = data.cloudfoundry_space.dev.id
  service_plan = data.cloudfoundry_service.abap_service_plans.service_plans["shared"]
  type         = "managed"
  parameters = jsonencode({
    email = "${length(var.abap_admin_email) > 0 ? var.abap_admin_email : data.btp_whoami.me.email}"
  })
  timeouts = {
    create = "30m"
    delete = "30m"
    update = "30m"
  }
}

###
# Creation of service key for ABAP Development Tools (ADT)
###
resource "cloudfoundry_service_credential_binding" "abap_trial_service_key" {
  type             = "key"
  name             = "abap_trial_adt_key"
  service_instance = cloudfoundry_service_instance.abap_trial.id
}
