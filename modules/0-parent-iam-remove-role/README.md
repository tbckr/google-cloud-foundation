# Parent IAM Remove Role

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| parent\_id | ID of the parent resource. | `string` | n/a | yes |
| parent\_type | Type of the parent resource. valid values are `organization`, `folder`, and `project`. | `string` | n/a | yes |
| roles | Roles to remove all members in the parent resource. | `list(string)` | n/a | yes |
<!-- END_TF_DOCS -->