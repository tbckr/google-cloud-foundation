// Copyright (c) 2023 Tim <tbckr>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//
// SPDX-License-Identifier: MIT

terraform {
  source = "../../../modules/0-bootstrap/base"
}

inputs = {
  org_id          = "REPLACE_ME" # format "000000000000"
  billing_account = "REPLACE_ME" # format "000000-000000-000000"

  # Example of values for the groups
  # group_org_admins = "gcp-organization-admins@example.com"
  # group_billing_admins = "gcp-billing-admins@example.com"
  group_org_admins     = "REPLACE_ME"
  group_billing_admins = "REPLACE_ME"

  company_prefix = "REPLACE_ME" # format "abc"
  default_region = "europe-west3"

  project_labels = {
    environment       = "bootstrap"
    application_name  = "seed-bootstrap"
    billing_code      = "1234"
    primary_contact   = "REPLACE_ME"
    secondary_contact = "REPLACE_ME"
    business_code     = "abcd"
    env_code          = "b"
  }

  // Optional - for an organization with existing projects or for development/validation.
  // Uncomment this variable to place all the example foundation resources under
  // the provided folder instead of the root organization.
  // The variable value is the numeric folder ID
  // The folder must already exist.
  //parent_folder = "01234567890"

  // Optional - for enabling the automatic groups creation, uncoment the groups
  // variable and update the values with the desired group names
  //groups = {
  //  create_groups = true,
  //  billing_project = "billing-project",
  //  required_groups = {
  //    group_org_admins           = "group_org_admins_local_test@example.com"
  //    group_billing_admins       = "group_billing_admins_local_test@example.com"
  //    billing_data_users         = "billing_data_users_local_test@example.com"
  //    audit_data_users           = "audit_data_users_local_test@example.com"
  //    monitoring_workspace_users = "monitoring_workspace_users_local_test@example.com"
  //  },
  //  optional_groups = {
  //    gcp_platform_viewer      = "gcp_platform_viewer_local_test@example.com"
  //    gcp_security_reviewer    = "gcp_security_reviewer_local_test@example.com"
  //    gcp_network_viewer       = "gcp_network_viewer_local_test@example.com"
  //    gcp_scc_admin            = "gcp_scc_admin_local_test@example.com"
  //    gcp_global_secrets_admin = "gcp_global_secrets_admin_local_test@example.com"
  //    gcp_audit_viewer         = "gcp_audit_viewer_local_test@example.com"
  //  }
  //}
  //
}