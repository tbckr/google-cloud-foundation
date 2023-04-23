# Parent IAM Member

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| member | Member to have the given roles in the parent resource. Prefix of `group:`, `user:` or `serviceAccount:` is required. | `string` | n/a | yes |
| parent\_id | ID of the parent resource. | `string` | n/a | yes |
| parent\_type | Type of the parent resource. valid values are `organization`, `folder`, and `project`. | `string` | n/a | yes |
| roles | Roles to grant to the member in the parent resource. | `list(string)` | n/a | yes |
<!-- END_TF_DOCS -->