# Prepare an Account for ABAP Trial

## Overview

This configuration prepares your existing Trial subaccount for ABAP Trial. The following configurations are applied:
- Assignement the `abab-trial` entitlement with plan `shared` to the existing subaccount
- Assignment of Cloud Foundry org and space roles
- Creation of an ABAP Trial service instance in the Cloud Foundry space
- Creation of a service key for the instance 

## Deploying the resources

To deploy the resources of this step execute the following commands:

1. Initialize your workspace:

   ```bash
   terraform init
   ```

1. Assign the variable values in a `*.tfvars` file e.g., the global account subdomain

1. You can check what Terraform plans to apply based on your configuration:

   ```bash
   terraform plan -var-file="<name of your tfvars file>.tfvars" 
   ```

1. Apply your configuration to provision the resources:

   ```bash
   terraform apply -var-file="<name of your tfvars file>.tfvars"
   ```

> **Note** - Some outputs of the first step are needed as input for the second step.