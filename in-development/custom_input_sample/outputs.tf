output "subaccount_id" {
  value       = data.btp_subaccount.project.id
  description = "The ID of the project subaccount."
}

output "cf_org_id" {
  value       = btp_subaccount_environment_instance.cloudfoundry.platform_id
  description = "The ID of the Cloud Foundry Org."
}

output "qas_labels" {
  value = var.qas_labels
  description = "The label that was passed as an input variable"
}
