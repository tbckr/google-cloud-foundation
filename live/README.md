# Live

1. Go into `0-bootstrap/base` and run `terragrunt apply-all`.
2. Use tfstate bucket output to set backend config in root `terragrunt.hcl` file.
3. Run `terragrunt apply` with `0-bootstrap/base` module in root.
4. Migrate state to backend bucket
5. Run `terragrunt apply` with `0-bootstrap`.

```shell

```