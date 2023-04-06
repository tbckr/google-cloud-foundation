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

dependency "env" {
  config_path  = "${get_terragrunt_dir()}/../2-dev"
  skip_outputs = true
}

dependency "common" {
  config_path  = "${get_terragrunt_dir()}/../3-common"
  skip_outputs = true
}

terraform {
  source = "git::git@github.com/tbckr/google-cloud-foundation.git//modules/3-networks/base_shared_vpc"
}

locals {
  env                   = "development"
  environment_code      = substr(local.env, 0, 1)
  default_region1       = "us-west1"
  default_region2       = "us-central1"
  private_service_cidr  = "10.16.64.0/21"
  subnet_primary_ranges = {
    (local.default_region1) = "10.0.64.0/21"
  }
  subnet_secondary_ranges = {
    (local.default_region1) = []
  }
}


inputs = {
  remote_state_bucket = dependency.seed.outputs.gcs_bucket_tfstate

  domain = ""

  env              = local.env
  environment_code = substr(local.env, 0, 1)

  project_id         = ""
  dns_hub_project_id = ""

  default_region1 = local.default_region1
  default_region2 = local.default_region2

  nat_enabled = true
  subnets     = [
    {
      subnet_name           = "sb-${local.environment_code}-shared-base-${local.default_region1}"
      subnet_ip             = local.subnet_primary_ranges[local.default_region1]
      subnet_region         = local.default_region1
      subnet_private_access = "true"
      subnet_flow_logs      = true
      description           = "First ${local.env} subnet example."
    },
  ]
  secondary_ranges = {
    "sb-${local.environment_code}-shared-base-${local.default_region1}" = local.subnet_secondary_ranges[local.default_region1]
  }
  private_service_cidr       = local.private_service_cidr
  private_service_connect_ip = "10.2.64.5"
}