# terraform-aws-internal-alb-acm

Terraform module to create an internal ALB with ACM (Certificate Manager)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| certificate\_body\_file | Path the PEM-formatted signed certificate for the avalon website, this will be loaded into ACM and used by the ALB. | `string` | n/a | yes |
| certificate\_chain\_file | Path to the PEM-formatted interim or chain certificate, some regions may require the chain cert be in 'reverse' format. | `string` | n/a | yes |
| private\_key\_file | Path to a the PEM-formatted private key for the avalon website. This will be loaded into AWS Certificate Manager(ACM) and used by the Application Load Balancer(ALB). Max supported RSA Key size is 2048 | `string` | n/a | yes |
| stack\_name | Name of the stack, helps delineate between different projects. | `string` | `"stack"` | no |
| subnet\_ids | List of subnet IDs, requires two in different availability zones | `list(string)` | n/a | yes |
| tags | Map of tags, will be added to the common tags local | `map(string)` | `{}` | no |
| vpc\_id | VPC that will be used by terraform, this VPC is called via data only, terraform will not attempt to manage the existence of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| alb\_listener\_arn | The 443 Listener ARN of the ALB |
| aws\_alb | The ID of the ALB |