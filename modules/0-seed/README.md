# Seed Project

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| company\_prefix | Name prefix to use for google ressources to make them unique. Max size is 3 characters. | `string` | n/a | yes |
| group\_billing\_admins | Google Group for GCP Billing Administrators | `string` | n/a | yes |
| group\_org\_admins | Google Group for GCP Organization Administrators | `string` | n/a | yes |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| bucket\_force\_destroy | When deleting a bucket, this boolean option will delete all contained objects. If false, Terraform will fail to delete buckets which contain objects. | `bool` | `false` | no |
| default\_region | Default region to create resources where applicable. | `string` | `"us-central1"` | no |
| groups | Contain the details of the Groups to be created. | ```object({ create_groups = bool billing_project = string required_groups = object({ group_org_admins = string group_billing_admins = string billing_data_users = string audit_data_users = string monitoring_workspace_users = string }) optional_groups = object({ gcp_platform_viewer = string gcp_security_reviewer = string gcp_network_viewer = string gcp_scc_admin = string gcp_global_secrets_admin = string gcp_audit_viewer = string }) })``` | ```{ "billing_project": "", "create_groups": false, "optional_groups": { "gcp_audit_viewer": "", "gcp_global_secrets_admin": "", "gcp_network_viewer": "", "gcp_platform_viewer": "", "gcp_scc_admin": "", "gcp_security_reviewer": "" }, "required_groups": { "audit_data_users": "", "billing_data_users": "", "group_billing_admins": "", "group_org_admins": "", "monitoring_workspace_users": "" } }``` | no |
| initial\_group\_config | Define the group configuration when it is initialized. Valid values are: WITH\_INITIAL\_OWNER, EMPTY and INITIAL\_GROUP\_CONFIG\_UNSPECIFIED. | `string` | `"WITH_INITIAL_OWNER"` | no |
| org\_policy\_admin\_role | Additional Org Policy Admin role for admin group. You can use this for testing purposes. | `bool` | `false` | no |
| org\_project\_creators | Additional list of members to have project creator role across the organization. Prefix of group: user: or serviceAccount: is required. | `list(string)` | `[]` | no |
| parent\_folder | Optional - for an organization with existing projects or for development/validation. It will place all the example foundation resources under the provided folder instead of the root organization. The value is the numeric folder ID. The folder must already exist. | `string` | `""` | no |
| project\_labels | Labels to apply to the bootstrap project. | `map(string)` | ```{ "application_name": "seed-bootstrap", "billing_code": "1234", "business_code": "abcd", "env_code": "b", "environment": "bootstrap", "primary_contact": "root_at_example_com", "secondary_contact": "info_at_example_com" }``` | no |

## Outputs

| Name | Description |
|------|-------------|
| bootstrap\_step\_terraform\_service\_account\_email | Bootstrap Step Terraform Account |
| common\_config | Common configuration data to be used in other steps. |
| company\_prefix | n/a |
| environment\_step\_terraform\_service\_account\_email | Environment Step Terraform Account |
| gcs\_bucket\_tfstate | Bucket used for storing terraform state for Foundations Pipelines in Seed Project. |
| group\_billing\_admins | Google Group for GCP Billing Administrators. |
| group\_org\_admins | Google Group for GCP Organization Administrators. |
| networks\_step\_terraform\_service\_account\_email | Networks Step Terraform Account |
| optional\_groups | List of Google Groups created that are optional to the Example Foundation steps. |
| organization\_step\_terraform\_service\_account\_email | Organization Step Terraform Account |
| projects\_step\_terraform\_service\_account\_email | Projects Step Terraform Account |
| required\_groups | List of Google Groups created that are required by the Example Foundation steps. |
| seed\_project\_id | Project where service accounts and core APIs will be enabled. |
| tfstate\_prefix\_seed | Prefix in state bucket used for storing terraform state for Foundations Pipelines in Seed Project. |
<!-- END_TF_DOCS -->