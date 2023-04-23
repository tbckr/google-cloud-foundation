# Hierarchical Firewall Policy

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| associations | Resources to associate the policy to | `list(string)` | n/a | yes |
| name | Hierarchical policy name | `string` | n/a | yes |
| parent | Where the firewall policy will be created (can be organizations/{organization\_id} or folders/{folder\_id}) | `string` | n/a | yes |
| rules | Firewall rules to add to the policy | ```map(object({ description = string direction = string action = string priority = number ranges = list(string) ports = map(list(string)) target_service_accounts = list(string) target_resources = list(string) logging = bool }))``` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
<!-- END_TF_DOCS -->