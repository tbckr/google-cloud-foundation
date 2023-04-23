# Common (to refactor)

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| domain | The DNS name of forwarding managed zone, for instance 'example.com'. Must end with a period. | `string` | n/a | yes |
| remote\_state\_bucket | Backend bucket to load Terraform Remote State Data from previous steps. | `string` | n/a | yes |
| target\_name\_server\_addresses | List of IPv4 address of target name servers for the forwarding zone configuration. See https://cloud.google.com/dns/docs/overview#dns-forwarding-zones for details on target name servers in the context of Cloud DNS forwarding zones. | `list(map(any))` | n/a | yes |
| bgp\_asn\_dns | BGP Autonomous System Number (ASN). | `number` | `64667` | no |
| dns\_enable\_logging | Toggle DNS logging for VPC DNS. | `bool` | `true` | no |
| firewall\_policies\_enable\_logging | Toggle hierarchical firewall logging. | `bool` | `true` | no |
| subnetworks\_enable\_logging | Toggle subnetworks flow logging for VPC Subnetworks. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns\_hub\_project\_id | The DNS hub project ID |
<!-- END_TF_DOCS -->