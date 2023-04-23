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

/******************************************
  Required variables
*******************************************/

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

variable "project_name" {
  description = "Name of the github actions cicd project"
  type        = string
  default     = "b-cicd"
}

variable "wif_pool_id" {
  type    = string
  default = "github-pool"
}

variable "wif_provider_id" {
  type    = string
  default = "github-provider"
}

variable "github_repos" {
  type = map(string)
}

/* ----------------------------------------
    Specific to Seed Project
   ---------------------------------------- */

variable "seed_project_id" {
  type = string
}

variable "terraform_sa_names" {
  description = "Fully-qualified name of the Terraform Service Accounts. It must be supplied by the Seed Project"
  type        = map(object({
    name      = string
    email     = string
    full_name = string
  }))
}

/******************************************
  Optional variables
*******************************************/

variable "folder_id" {
  description = "The ID of a folder to host this project"
  type        = string
  default     = ""
}

variable "project_labels" {
  description = "Labels to apply to the project."
  type        = map(string)
  default     = {}
}

variable "budget_alert_spent_percents" {
  type    = list(number)
  default = [
    0.5,
    0.7,
    1
  ]
}

variable "budget_amount" {
  type    = number
  default = 5
}

variable "activate_apis" {
  description = "List of APIs to enable in the CICD project."
  type        = list(string)

  default = [
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iamcredentials.googleapis.com",
    "sts.googleapis.com",
  ]
}
