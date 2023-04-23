# CI/CD Automation with GitHub Actions

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| billing\_account | The ID of the billing account to associate projects with. | `string` | n/a | yes |
| github\_repos | n/a | `map(string)` | n/a | yes |
| group\_org\_admins | Google Group for GCP Organization Administrators | `string` | n/a | yes |
| org\_id | GCP Organization ID | `string` | n/a | yes |
| seed\_project\_id | n/a | `string` | n/a | yes |
| terraform\_sa\_names | Fully-qualified name of the Terraform Service Accounts. It must be supplied by the Seed Project | ```map(object({ name = string email = string full_name = string }))``` | n/a | yes |
| activate\_apis | List of APIs to enable in the CICD project. | `list(string)` | ```[ "iam.googleapis.com", "cloudresourcemanager.googleapis.com", "iamcredentials.googleapis.com", "sts.googleapis.com" ]``` | no |
| budget\_alert\_spent\_percents | n/a | `list(number)` | ```[ 0.5, 0.7, 1 ]``` | no |
| budget\_amount | n/a | `number` | `5` | no |
| folder\_id | The ID of a folder to host this project | `string` | `""` | no |
| project\_labels | Labels to apply to the project. | `map(string)` | `{}` | no |
| project\_name | Name of the github actions cicd project | `string` | `"b-cicd"` | no |
| wif\_pool\_id | n/a | `string` | `"github-pool"` | no |
| wif\_provider\_id | n/a | `string` | `"github-provider"` | no |

## Outputs

| Name | Description |
|------|-------------|
| project\_id | n/a |
| wif\_provider\_name | n/a |
<!-- END_TF_DOCS -->