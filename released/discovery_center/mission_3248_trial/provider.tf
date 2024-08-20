
terraform {
  required_providers {
    btp = {
      source  = "sap/btp"
      version = "~> 1.5.0"
    }
    cloudfoundry = {
      source  = "sap/cloudfoundry"
      version = "1.0.0-rc1"
    }
  }

}

# Please checkout documentation on how best to authenticate against SAP BTP
# via the Terraform provider for SAP BTP
provider "btp" {
  globalaccount  = var.globalaccount
  cli_server_url = var.cli_server_url
}

# This will only work if we know the region in advance
provider "cloudfoundry" {
  api_url = local.cf_api_url
}
