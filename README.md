# Kojitechs-tf-aws-required-tags

This module takes in as variables the values to build the base set of required tags for AWS Resources.
For more information see [Architecture and DevOps - Resource Tagging](#) along with [HCT AWS Tagging Standard](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html).

## Usage

```terraform
module required_tags {
  source = "git::git@github.com:Bkoji1150/kojitechs-tf-aws-required-tags.git?ref=v1.0.0" 

  line_of_business        = var.line_of_business 
  ado                     = "Kojitechs"
  tier                    = var.tier 
  operational_environment = terraform.workspace
  tech_poc_primary        = "Analytics@Kojitechs.io"
  tech_poc_secondary      = "Analytics@Kojitechs.io"
  application             = "HQR"
  builder                 = "kojibello058@gmail.com"
  application_owner       = "Analytics@Kojitechs.io"
  vpc                     = "APP"
  cell_name               = var.cell_name 
  component_name          = var.component_name 
}
```

### As default tags

This automatically adds the tags to all resources. It's much easier than passing down the tags to each resource, so it is recommended in most cases.

However, are a few limitations to keep in mind:

- There can only be 10 tags on an S3 bucket object, so unfortunately we have to apply that limit to all resources since there is no easy way to cut the tags down just for S3 objects
- This gets complicated when a different AWS provider is used inside modules. The tags would still have to be passed so the nested provider can use them (e.g. git@github.com:Bkoji1150/kojitechs-tf-aws-required-tags.git#L3)

```terraform
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = module.required_tags.aws_default_tags
  }
}
```


# module "alb" {
#   source  = "terraform-aws-modules/alb/aws"
#   version = "~> 6.0.0" 

#   name = "${var.component}-web-alb"
#   load_balancer_type = "application"

#   vpc_id             = local.vpc_id
#   subnets            = aws_subnet.public_subnet.*.id
#   security_groups    = [aws_security_group.alb_sg.id]

#   http_tcp_listeners = [
#     {
#       port        = 80
#       protocol    = "HTTP" # redirect
#       action_type = "redirect"
#       redirect = {
#         port        = "443"
#         protocol    = "HTTPS" # forward
#         status_code = "HTTP_301"
#       }
#     }
#   ]
#   target_groups = [
#     {
#       name_prefix          = "app1-"
#       backend_protocol     = "HTTP"
#       backend_port         = 80
#       target_type          = "instance"
#       deregistration_delay = 10
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/app1/index.html"
#         port                = "traffic-port"
#         healthy_threshold   = 3
#         unhealthy_threshold = 3
#         timeout             = 6
#         protocol            = "HTTP"
#         matcher             = "200-399"
#       }
#       protocol_version = "HTTP1"
#       targets = {
#         my_app1_vm1 = {
#           target_id = aws_instance.app1.id
#           port      = 80
#         }
#       }

#     },
#     {
#       name_prefix          = "app2-"
#       backend_protocol     = "HTTP"
#       backend_port         = 80
#       target_type          = "instance"
#       deregistration_delay = 10
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/app2/index.html"
#         port                = "traffic-port"
#         healthy_threshold   = 3
#         unhealthy_threshold = 3
#         timeout             = 6
#         protocol            = "HTTP"
#         matcher             = "200-399"
#       }
#       protocol_version = "HTTP1"

#       targets = {
#         my_app2_vm1 = {
#           target_id = aws_instance.app2.id
#           port      = 80
#         }
#       }

#     },

#     {
#       name_prefix          = "regis-" 
#       backend_protocol     = "HTTP"
#       backend_port         = 8080
#       target_type          = "instance"
#       deregistration_delay = 10
#       health_check = {
#         enabled             = true
#         interval            = 30
#         path                = "/login" 
#         port                = "traffic-port"
#         healthy_threshold   = 3
#         unhealthy_threshold = 3
#         timeout             = 6
#         protocol            = "HTTP"
#         matcher             = "200-399"
#       }
#       stickiness = {
#         enabled         = true
#         cookie_duration = 86400
#         type            = "lb_cookie"
#       }
#       protocol_version = "HTTP1"
#       targets = {
#         registration_app_1 = {
#           target_id = aws_instance.registration_app[0].id
#           port      = 8080
#         },
#         my_app3_vm2 = {
#           target_id = aws_instance.registration_app[1].id
#           port      = 8080
#         }
#       }

#     }
#   ]

#   https_listeners = [
#     {
#       port            = 443
#       protocol        = "HTTPS"
#       certificate_arn = module.acm.acm_certificate_arn
#       action_type     = "fixed-response"
#       fixed_response = {
#         content_type = "text/plain"
#         message_body = "Fixed Static message - for Root Context"
#         status_code  = "200"
#       }
#     },
#   ]
#   https_listener_rules = [
#     {
#       https_listener_index = 0
#       priority             = 1
#       actions = [
#         {
#           type               = "forward"
#           target_group_index = 0
#         }
#       ]
#       conditions = [{
#         path_patterns = ["/app1*"]
#       }]
#     },
#     {
#       https_listener_index = 0
#       priority             = 2
#       actions = [
#         {
#           type               = "forward"
#           target_group_index = 1
#         }
#       ]
#       conditions = [{
#         path_patterns = ["/app2*"]
#       }]
#     },

#     {
#       https_listener_index = 0
#       priority             = 3
#       actions = [
#         {
#           type               = "forward"
#           target_group_index = 2
#         }
#       ]
#       conditions = [{
#         path_patterns = ["/*"]
#       }]
#     },
#   ]
# }


### As tags on each resource

```terraform
resource "aws_rds_cluster" "my_database" {
  ...
  tags = module.required_tags.tags
}
```

### Resource naming

```terraform

resource "aws_glue_catalog_database" "my_database" {
  # this will render as `example-foo-sbx`.
  name = module.required_tags.qualified_component_name
}

resource "aws_glue_catalog_database" "my_other_database" {
  # this will render as `example-foo-bar-sbx`.
   name = format(module.required_tags.qualified_component_name_template, "bar")
}
```

<!-- prettier-ignore-start -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.5 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ado"></a> [ado](#input\_ado) | HIDS ADO that owns the resource. The ServiceNow Contracts table is the system of record for the actual ADO names and LOB names. | `string` | `"Kojitechs"` | no |
| <a name="input_application"></a> [application](#input\_application) | Logical name for the application. Mainly used for Ventech. For an ADO/LOB owned application default to the LOB name. | `string` | `null` | no |
| <a name="input_application_owner"></a> [application\_owner](#input\_application\_owner) | Email Address of the group who owns the application. This should be a distribution list and no an individual email if at all possible. Primarily used for Ventech-owned applications to indicate what group/department is responsible for the application using this resource. For an ADO/LOB owned application default to the LOB name. | `any` | n/a | yes |
| <a name="input_builder"></a> [builder](#input\_builder) | The name of the person who created the resource. | `string` | n/a | yes |
| <a name="input_cell_name"></a> [cell\_name](#input\_cell\_name) | The name of the cell. | `string` | n/a | yes |
| <a name="input_component_name"></a> [component\_name](#input\_component\_name) | The name of the component, if applicable. | `string` | `null` | no |
| <a name="input_line_of_business"></a> [line\_of\_business](#input\_line\_of\_business) | HIDS LOB that owns the resource. | `string` | `"TECH"` | no |
| <a name="input_operational_environment"></a> [operational\_environment](#input\_operational\_environment) | Operational Environment the resource resides in. The operational environments are MANDATORY for an ADO and Ventech. We use the VPC tag to differentiate the overall type of VPC from the specific operational environment. | `string` | n/a | yes |
| <a name="input_tech_poc_primary"></a> [tech\_poc\_primary](#input\_tech\_poc\_primary) | Email Address of the Primary Technical Contact for the AWS resource. | `string` | n/a | yes |
| <a name="input_tech_poc_secondary"></a> [tech\_poc\_secondary](#input\_tech\_poc\_secondary) | Email Address of the Secondary Technical Contact for the AWS resource. | `string` | n/a | yes |
| <a name="input_tier"></a> [tier](#input\_tier) | Network tier or layer where the resource resides. These tiers are represented in every VPC regardless of single-tenant or multi-tenant. For most resources in the Infrastructure and Security VPC, the TIER will be Management. But in some cases,such as Atlassian, the other tiers are relevant. | `string` | n/a | yes |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | The VPC the resource resides in. We need this to differentiate from Lifecycle Environment due to INFRA and SEC. One of "APP", "INFRA", "SEC", "ROUTING". | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_default_tags"></a> [aws\_default\_tags](#output\_aws\_default\_tags) | Subset of `tags`. Limited to 10 values in order to be used as `default_tags` in an AWS provider block. |
| <a name="output_legacy_tags"></a> [legacy\_tags](#output\_legacy\_tags) | Tags formatted to adhere to "HCT AWS Tagging Standard" standards. |
| <a name="output_tags"></a> [tags](#output\_tags) | Tags formatted to adhere to "Architecture and DevOps - Resource Tagging" standards. |
| <a name="output_tags_string"></a> [tags\_string](#output\_tags\_string) | Returns a `;` delimited string of tags, e.g.: `tag1:value1;tag2:value2`. Only includes tags with non-null values. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- prettier-ignore-end -->
