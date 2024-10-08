variable "globalaccount" {
  type        = string
  description = "The globalaccount subdomain where the sub account shall be created."
}

variable "subaccount_name" {
  type        = string
  description = "The subaccount name."
  default     = "My SAP Build Apps subaccount"
}

variable "cli_server_url" {
  type        = string
  description = "The BTP CLI server URL."
  default     = "https://cli.btp.cloud.sap"
}

variable "custom_idp" {
  type        = string
  description = "Defines the custom IDP to be used for the subaccount"
  default     = ""
}

variable "region" {
  type        = string
  description = "The region where the sub account shall be created in."
  default     = "us10"
}

variable "qas_labels" {
  type        = string
  description = "The comma-separated list of labels to set for new resources."
}

variable "subaccount_admins" {
  type        = list(string)
  description = "Defines the colleagues who are added to the subaccount as administrators."
}

variable "cf_landscape_label" {
  type        = string
  description = "The Cloud Foundry landscape (format example eu10-004)."
  default     = ""
}

variable "user_email" {
  type        = string
  description = "The user eail."
  default     = ""
}

variable "user_first_name" {
  type        = string
  description = "The first name of the user."
  default     = ""
}

variable "user_last_name" {
  type        = string
  description = "The last name of the user."
  default     = ""
}