output "subaccount_id" {
  value       = btp_subaccount.mission.id
  description = "The ID of the mission subaccount."
}

output "cf_org_id" {
  value       = btp_subaccount_environment_instance.cloudfoundry.platform_id
  description = "The ID of the Cloud Foundry Org."
}

output "qas_labels" {
  value = local.qas_labels
  description = "The label that was passed as an input variable"
}
