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

include "root" {
  path = find_in_parent_folders()
}

dependency "seed" {
  config_path  = "${get_terragrunt_dir()}/../0-bootstrap"
  mock_outputs = {
    gcs_bucket_tfstate                            = "REPLACE_ME"
    networks_step_terraform_service_account_email = "REPLACE_ME"
  }
}

#generate "backend" {
#  path      = "backend.tf"
#  if_exists = "overwrite_terragrunt"
#  contents  = <<EOF
#terraform {
#  backend "gcs" {
#    bucket = "${dependency.seed.outputs.gcs_bucket_tfstate}"
#    prefix = "terraform/${path_relative_to_include()}/state"
#    impersonate_service_account = "${dependency.seed.outputs.networks_step_terraform_service_account_email}"
#  }
#}
#EOF
#}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google-beta" {
  user_project_override = true
  impersonate_service_account = "${dependency.seed.outputs.networks_step_terraform_service_account_email}"
}
EOF
}

dependency "common_folder" {
  config_path = "${get_terragrunt_dir()}/../1-org/common"
}

dependency "development_folder" {
  config_path = "${get_terragrunt_dir()}/../1-org/development"
}

terraform {
  source = "git::git@github.com/tbckr/google-cloud-foundation.git//modules/3-networks/hierarchical_firewall_policy"
}

inputs = {
  remote_state_bucket = dependency.seed.outputs.gcs_bucket_tfstate

  parent       = "local.common_folder_name"
  name         = "common-firewall-rules"
  associations = [
    local.common_folder_name,
    local.bootstrap_folder_name,
    local.development_folder_name,
    local.production_folder_name,
    local.non_production_folder_name,
  ]
  rules = {
    delegate-rfc1918-ingress = {
      description = "Delegate RFC1918 ingress"
      direction   = "INGRESS"
      action      = "goto_next"
      priority    = 500
      ranges      = [
        "192.168.0.0/16",
        "10.0.0.0/8",
        "172.16.0.0/12"
      ]
      ports                   = { "all" = [] }
      target_service_accounts = null
      target_resources        = null
      logging                 = false
    }
    delegate-rfc1918-egress = {
      description = "Delegate RFC1918 egress"
      direction   = "EGRESS"
      action      = "goto_next"
      priority    = 510
      ranges      = [
        "192.168.0.0/16",
        "10.0.0.0/8",
        "172.16.0.0/12"
      ]
      ports                   = { "all" = [] }
      target_service_accounts = null
      target_resources        = null
      logging                 = false
    }
    allow-iap-ssh-rdp = {
      description = "Always allow SSH and RDP from IAP"
      direction   = "INGRESS"
      action      = "allow"
      priority    = 5000
      ranges      = ["35.235.240.0/20"]
      ports       = {
        tcp = ["22", "3389"]
      }
      target_service_accounts = null
      target_resources        = null
      logging                 = var.firewall_policies_enable_logging
    }
    allow-windows-activation = {
      description = "Always outgoing Windows KMS traffic (required to validate Windows licenses)"
      direction   = "EGRESS"
      action      = "allow"
      priority    = 5100
      ranges      = ["35.190.247.13/32"]
      ports       = {
        tcp = ["1688"]
      }
      target_service_accounts = null
      target_resources        = null
      logging                 = var.firewall_policies_enable_logging
    }
    allow-google-hbs-and-hcs = {
      description = "Always allow connections from Google load balancer and health check ranges"
      direction   = "INGRESS"
      action      = "allow"
      priority    = 5200
      ranges      = [
        "35.191.0.0/16",
        "130.211.0.0/22",
        "209.85.152.0/22",
        "209.85.204.0/22"
      ]
      ports = {
        tcp = ["80", "443"]
      }
      target_service_accounts = null
      target_resources        = null
      logging                 = var.firewall_policies_enable_logging
    }
  }
}