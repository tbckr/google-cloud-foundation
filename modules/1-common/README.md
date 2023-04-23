# Organization Foundation Module

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| audit\_data\_users | Google Workspace or Cloud Identity group that have access to audit logs. | `string` | n/a | yes |
| billing\_data\_users | Google Workspace or Cloud Identity group that have access to billing data set. | `string` | n/a | yes |
| domains\_to\_allow | The list of domains to allow users from in IAM. Used by Domain Restricted Sharing Organization Policy. Must include the domain of the organization you are deploying the foundation. Must be the Directory ID of the Organization. | `list(string)` | n/a | yes |
| essential\_contacts\_domains\_to\_allow | The list of domains that email addresses added to Essential Contacts can have. | `list(string)` | n/a | yes |
| remote\_state\_bucket | Backend bucket to load Terraform Remote State Data from previous steps. | `string` | n/a | yes |
| scc\_notification\_name | Name of the Security Command Center Notification. It must be unique in the organization. Run `gcloud scc notifications describe <scc_notification_name> --organization=org_id` to check if it already exists. | `string` | n/a | yes |
| audit\_logs\_table\_delete\_contents\_on\_destroy | (Optional) If set to true, delete all the tables in the dataset when destroying the resource; otherwise, destroying the resource will fail if tables are present. | `bool` | `false` | no |
| audit\_logs\_table\_expiration\_days | Period before tables expire for all audit logs in milliseconds. Default is 30 days. | `number` | `30` | no |
| billing\_export\_dataset\_location | The location of the dataset for billing data export. | `string` | `"US"` | no |
| create\_access\_context\_manager\_access\_policy | Whether to create access context manager access policy. | `bool` | `true` | no |
| create\_unique\_tag\_key | Creates unique organization-wide tag keys by adding a random suffix to each key. | `bool` | `false` | no |
| data\_access\_logs\_enabled | Enable Data Access logs of types DATA\_READ, DATA\_WRITE for all GCP services. Enabling Data Access logs might result in your organization being charged for the additional logs usage. See https://cloud.google.com/logging/docs/audit#data-access The ADMIN\_READ logs are enabled by default. | `bool` | `false` | no |
| essential\_contacts\_language | Essential Contacts preferred language for notifications, as a ISO 639-1 language code. See [Supported languages](https://cloud.google.com/resource-manager/docs/managing-notification-contacts#supported-languages) for a list of supported languages. | `string` | `"en"` | no |
| gcp\_groups | Groups to grant specific roles in the Organization.   platform\_viewer: Google Workspace or Cloud Identity group that have the ability to view resource information across the Google Cloud organization.   security\_reviewer: Google Workspace or Cloud Identity group that members are part of the security team responsible for reviewing cloud security   network\_viewer: Google Workspace or Cloud Identity group that members are part of the networking team and review network configurations.   scc\_admin: Google Workspace or Cloud Identity group that can administer Security Command Center.   audit\_viewer: Google Workspace or Cloud Identity group that members are part of an audit team and view audit logs in the logging project.   global\_secrets\_admin: Google Workspace or Cloud Identity group that members are responsible for putting secrets into Secrets Manage | ```object({ platform_viewer = optional(string, null) security_reviewer = optional(string, null) network_viewer = optional(string, null) scc_admin = optional(string, null) audit_viewer = optional(string, null) global_secrets_admin = optional(string, null) })``` | `{}` | no |
| gcp\_user | Users to grant specific roles in the Organization.   org\_admin: Identity that has organization administrator permissions.   billing\_creator: Identity that can create billing accounts.   billing\_admin: Identity that has billing administrator permissions. | ```object({ org_admin = optional(string, null) billing_creator = optional(string, null) billing_admin = optional(string, null) })``` | `{}` | no |
| log\_export\_storage\_force\_destroy | (Optional) If set to true, delete all contents when destroying the resource; otherwise, destroying the resource will fail if contents are present. | `bool` | `false` | no |
| log\_export\_storage\_location | The location of the storage bucket used to export logs. | `string` | `"US"` | no |
| log\_export\_storage\_retention\_policy | Configuration of the bucket's data retention policy for how long objects in the bucket should be retained. | ```object({ is_locked = bool retention_period_days = number })``` | `null` | no |
| log\_export\_storage\_versioning | (Optional) Toggles bucket versioning, ability to retain a non-current object version when the live object version gets replaced or deleted. | `bool` | `false` | no |
| project\_budget | Budget configuration for projects.   budget\_amount: The amount to use as the budget.   alert\_spent\_percents: A list of percentages of the budget to alert on when threshold is exceeded.   alert\_pubsub\_topic: The name of the Cloud Pub/Sub topic where budget related messages will be published, in the form of `projects/{project_id}/topics/{topic_id}`. | ```object({ dns_hub_budget_amount = optional(number, 1000) dns_hub_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) dns_hub_alert_pubsub_topic = optional(string, null) base_net_hub_budget_amount = optional(number, 1000) base_net_hub_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) base_net_hub_alert_pubsub_topic = optional(string, null) restricted_net_hub_budget_amount = optional(number, 1000) restricted_net_hub_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) restricted_net_hub_alert_pubsub_topic = optional(string, null) interconnect_budget_amount = optional(number, 1000) interconnect_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) interconnect_alert_pubsub_topic = optional(string, null) org_secrets_budget_amount = optional(number, 1000) org_secrets_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) org_secrets_alert_pubsub_topic = optional(string, null) org_billing_logs_budget_amount = optional(number, 1000) org_billing_logs_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) org_billing_logs_alert_pubsub_topic = optional(string, null) org_audit_logs_budget_amount = optional(number, 1000) org_audit_logs_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) org_audit_logs_alert_pubsub_topic = optional(string, null) scc_notifications_budget_amount = optional(number, 1000) scc_notifications_alert_spent_percents = optional(list(number), [0.5, 0.75, 0.9, 0.95]) scc_notifications_alert_pubsub_topic = optional(string, null) })``` | `{}` | no |
| scc\_notification\_filter | Filter used to create the Security Command Center Notification, you can see more details on how to create filters in https://cloud.google.com/security-command-center/docs/how-to-api-filter-notifications#create-filter | `string` | `"state = \"ACTIVE\""` | no |

## Outputs

| Name | Description |
|------|-------------|
| common\_folder\_name | The common folder name |
| dns\_hub\_project\_id | The DNS hub project ID |
| domains\_to\_allow | The list of domains to allow users from in IAM. |
| logs\_export\_bigquery\_dataset\_name | The log bucket for destination of log exports. See https://cloud.google.com/logging/docs/routing/overview#buckets |
| logs\_export\_logbucket\_name | The log bucket for destination of log exports. See https://cloud.google.com/logging/docs/routing/overview#buckets |
| logs\_export\_pubsub\_topic | The Pub/Sub topic for destination of log exports |
| logs\_export\_storage\_bucket\_name | The storage bucket for destination of log exports |
| org\_audit\_logs\_project\_id | The org audit logs project ID |
| org\_billing\_logs\_project\_id | The org billing logs project ID |
| org\_id | The organization id |
| parent\_resource\_id | The parent resource id |
| parent\_resource\_type | The parent resource type |
| scc\_notification\_name | Name of SCC Notification |
| scc\_notifications\_project\_id | The SCC notifications project ID |
| tags | Tag Values to be applied on next steps |
<!-- END_TF_DOCS -->