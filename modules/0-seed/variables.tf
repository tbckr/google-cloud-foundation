/**
 * Copyright 2021 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "group_org_admins" {
  description = "Google Group for GCP Organization Administrators"
  type        = string
}

variable "group_billing_admins" {
  description = "Google Group for GCP Billing Administrators"
  type        = string
}

variable "default_region" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "us-central1"
}

variable "parent_folder" {
  description = "Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist."
  type        = string
  default     = ""
}

variable "org_project_creators" {
  description = "Additional list of members to have project creator role across the organization. Prefix of group: user: or serviceAccount: is required."
  type        = list(string)
  default     = []
}

variable "org_policy_admin_role" {
  description = "Additional Org Policy Admin role for admin group. You can use this for testing purposes."
  type        = bool
  default     = false
}

variable "company_prefix" {
  description = "Name prefix to use for google ressources to make them unique. Max size is 3 characters."
  type        = string
}

variable "bucket_force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects."
  type        = bool
  default     = false
}

variable "project_labels" {
  description = "Labels to apply to the bootstrap project."
  type        = map(string)
  default     = {
    environment       = "bootstrap"
    application_name  = "seed-bootstrap"
    billing_code      = "1234"
    primary_contact   = "root_at_example_com"
    secondary_contact = "info_at_example_com"
    business_code     = "abcd"
    env_code          = "b"
  }
}

/* ----------------------------------------
    Specific to Groups creation
   ---------------------------------------- */
variable "groups" {
  description = "Contain the details of the Groups to be created."
  type        = object({
    create_groups   = bool
    billing_project = string
    required_groups = object({
      group_org_admins           = string
      group_billing_admins       = string
      billing_data_users         = string
      audit_data_users           = string
      monitoring_workspace_users = string
    })
    optional_groups = object({
      gcp_platform_viewer      = string
      gcp_security_reviewer    = string
      gcp_network_viewer       = string
      gcp_scc_admin            = string
      gcp_global_secrets_admin = string
      gcp_audit_viewer         = string
    })
  })
  default = {
    create_groups   = false
    billing_project = ""
    required_groups = {
      group_org_admins           = ""
      group_billing_admins       = ""
      billing_data_users         = ""
      audit_data_users           = ""
      monitoring_workspace_users = ""
    }
    optional_groups = {
      gcp_platform_viewer      = ""
      gcp_security_reviewer    = ""
      gcp_network_viewer       = ""
      gcp_scc_admin            = ""
      gcp_global_secrets_admin = ""
      gcp_audit_viewer         = ""
    }
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.billing_project != "" ? true : false) : true
    error_message = "A billing_project must be passed to use the automatic group creation."
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.required_groups.group_org_admins != "" ? true : false) : true
    error_message = "The group group_org_admins is invalid, it must be a valid email."
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.required_groups.group_billing_admins != "" ? true : false) : true
    error_message = "The group group_billing_admins is invalid, it must be a valid email."
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.required_groups.billing_data_users != "" ? true : false) : true
    error_message = "The group billing_data_users is invalid, it must be a valid email."
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.required_groups.audit_data_users != "" ? true : false) : true
    error_message = "The group audit_data_users is invalid, it must be a valid email."
  }

  validation {
    condition     = var.groups.create_groups == true ? (var.groups.required_groups.monitoring_workspace_users != "" ? true : false) : true
    error_message = "The group monitoring_workspace_users is invalid, it must be a valid email."
  }

}

variable "initial_group_config" {
  description = "Define the group configuration when it is initialized. Valid values are: WITH_INITIAL_OWNER, EMPTY and INITIAL_GROUP_CONFIG_UNSPECIFIED."
  type        = string
  default     = "WITH_INITIAL_OWNER"
}
