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

// During first run, you will need to comment out the backend and provider blocks
// After that you can uncomment them and run terragrunt apply again
#generate "backend" {
#  path      = "backend.tf"
#  if_exists = "overwrite_terragrunt"
#  contents  = <<EOF
#terraform {
#  backend "gcs" {
#    bucket = "UPDATE_ME"
#    prefix = "terraform/bootstrap/seed/state"
#    impersonate_service_account = "UPDATE_ME"
#  }
#}
#EOF
#}

// During first run, you will need to comment out the backend and provider blocks
// After that you can uncomment them and run terragrunt apply again
#generate "provider" {
#  path      = "provider.tf"
#  if_exists = "overwrite_terragrunt"
#  contents  = <<EOF
#provider "google-beta" {
#  user_project_override = true
#  impersonate_service_account = "UPDATE_ME"
#}
#EOF
#}

terraform {
  source = "git::git@github.com/tbckr/google-cloud-foundation.git//modules/0-seed"
}

inputs = {
  org_id          = "REPLACE_ME" # format "000000000000"
  billing_account = "REPLACE_ME" # format "000000-000000-000000"

  group_org_admins     = "REPLACE_ME" # example gcp-organization-admins@example.com
  group_billing_admins = "REPLACE_ME" # example gcp-billing-admins@example.com

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
}