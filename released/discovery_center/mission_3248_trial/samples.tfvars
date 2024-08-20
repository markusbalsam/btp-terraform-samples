# ------------------------------------------------------------------------------------------------------
# Provider configuration
# ------------------------------------------------------------------------------------------------------
globalaccount = "subdomain of your trial globalaccount"

# ------------------------------------------------------------------------------------------------------
# Project specific configuration (please adapt)
# ------------------------------------------------------------------------------------------------------
subaccount_id = "id of your trial subaccount"

cf_org_managers = ["anotheruser@test.com"]

# If create_cf_space is true or Clouf Foundry is disabled for your trial subaccount, you must add
# yourself as a space manager and developer. DON'T add yourself if the space exists and you are
# already a space manager or developer of the space.
cf_space_developers = ["anotheruser@test.com", "you@test.com"]
cf_space_managers   = ["anotheruser@test.com", "you@test.com"]

# If not set the email of the user that applies the configuration will be used
abap_admin_email = "you@your.company.com"
