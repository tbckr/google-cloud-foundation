# Environment Module

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| env | The environment to prepare (ex. development) | `string` | n/a | yes |
| environment\_code | A short form of the folder level resources (environment) within the Google Cloud organization (ex. d). | `string` | n/a | yes |
| remote\_state\_bucket | Backend bucket to load Terraform Remote State Data from previous steps. | `string` | n/a | yes |
| assured\_workload\_configuration | Assured Workload configuration.   enabled: If the assured workload should be created.   location: The location where the workload will be created.   display\_name: User-assigned resource display name.   compliance\_regime: Supported Compliance Regimes.   resource\_type: The type of resource. One of CONSUMER\_FOLDER, KEYRING, or ENCRYPTION\_KEYS\_PROJECT. | ```object({ enabled = optional(bool, false) location = optional(string, "us-central1") display_name = optional(string, "FEDRAMP-MODERATE") compliance_regime = optional(string, "FEDRAMP_MODERATE") resource_type = optional(string, "CONSUMER_FOLDER") })``` | `{}` | no |
| project\_budget | Budget configuration for projects.   budget\_amount: The amount to use as the budget.   alert\_spent\_percents: A list of percentages of the budget to alert on when threshold is exceeded.   alert\_pubsub\_topic: The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`. | ```object({ base_network_budget_amount = optional(number, 1000) base_network_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) base_network_alert_pubsub_topic = optional(string, null) })``` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| assured\_workload\_id | Assured Workload ID. |
| assured\_workload\_resources | Resources associated with the Assured Workload. |
| base\_shared\_vpc\_project\_id | Project for base shared VPC network. |
| env\_folder | Environment folder created under parent. |
<!-- END_TF_DOCS -->