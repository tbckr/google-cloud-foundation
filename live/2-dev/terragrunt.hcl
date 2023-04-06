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
    gcs_bucket_tfstate                               = "REPLACE_ME"
    environment_step_terraform_service_account_email = "REPLACE_ME"
  }
}

# Uncomment this block to enable the backend and generate the backend.tf file.
#generate "backend" {
#  path      = "backend.tf"
#  if_exists = "overwrite_terragrunt"
#  contents  = <<EOF
#terraform {
#  backend "gcs" {
#    bucket = "${dependency.seed.outputs.gcs_bucket_tfstate}"
#    prefix = "terraform/${path_relative_to_include()}/state"
#    impersonate_service_account = "${dependency.seed.outputs.environment_step_terraform_service_account_email}"
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
  impersonate_service_account = "${dependency.seed.outputs.environment_step_terraform_service_account_email}"
}
EOF
}

terraform {
  source = "git::git@github.com/tbckr/google-cloud-foundation.git//modules/2-envs/env_baseline"
}

inputs = {
  remote_state_bucket = dependency.seed.outputs.gcs_bucket_tfstate

  env              = "development"
  environment_code = "d"

  project_budget = {
    base_network_budget_amount = 10
  }
}