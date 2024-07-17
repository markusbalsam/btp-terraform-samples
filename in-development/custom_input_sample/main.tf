###############################################################################################
# Setup subaccount domain and the CF org (to ensure uniqueness in BTP global account)
###############################################################################################
resource "random_uuid" "uuid" {}

locals {
  subdomain   = join("-", ["dc-mission-3585", random_uuid.uuid.result])
  cf_org_name = substr(replace(local.subdomain, "-", ""), 0, 32)
  qas_labels  = split(",", var.qas_labels)
}

###############################################################################################
# Creation of subaccount
###############################################################################################
resource "btp_subaccount" "dc_mission" {
  name      = var.subaccount_name
  subdomain = join("-", ["test", "labels", random_uuid.uuid.result])
  region    = lower(var.region)
  usage     = "USED_FOR_PRODUCTION"
  labels    = {
    "qas_labels": toset(local.qas_labels)
  }
}

###############################################################################################
# Assignment of users to the sub account as sub account administrators
###############################################################################################
resource "btp_subaccount_role_collection_assignment" "subaccount_admins" {
  for_each             = toset("${var.subaccount_admins}")
  subaccount_id        = btp_subaccount.dc_mission.id
  role_collection_name = "Subaccount Administrator"
  user_name            = each.value
}

###############################################################################################
# Creation of Cloud Foundry environment
###############################################################################################

# Fetch all available environments for the subaccount
data "btp_subaccount_environments" "all" {
  subaccount_id = btp_subaccount.dc_mission.id
}

# Take the landscape label from the first CF environment if no environment label is provided
resource "null_resource" "cache_target_environment" {
  triggers = {
    label = length(var.cf_landscape_label) > 0 ? var.cf_landscape_label : [for env in data.btp_subaccount_environments.all.values : env if env.service_name == "cloudfoundry" && env.environment_type == "cloudfoundry"][0].landscape_label
  }

  lifecycle {
    ignore_changes = all
  }
}

# Create the Cloud Foundry environment instance
resource "btp_subaccount_environment_instance" "cloudfoundry" {
  subaccount_id    = btp_subaccount.dc_mission.id
  name             = local.cf_org_name
  environment_type = "cloudfoundry"
  service_name     = "cloudfoundry"
  plan_name        = "standard"
  landscape_label  = null_resource.cache_target_environment.triggers.label

  parameters = jsonencode({
    instance_name = local.cf_org_name
  })
}
