terraform {
  required_version = ">=1.1.5"
}

locals {
  tags = merge(local.additional_tags, local.aws_default_tags)

  # MUST be kept to 10 or less values because of S3 object tag limit: https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-tagging.html
  aws_default_tags = {
    "line-of-business"        = var.line_of_business
    ado                       = var.ado
    tier                      = var.tier
    "operational-environment" = var.operational_environment
    "tech-poc-primary"        = var.tech_poc_primary
    builder                   = var.builder
    vpc                       = var.vpc
    "cell-name"               = var.cell_name
    "component-name"          = var.component_name
  }

  additional_tags = {
    "tech-poc-secondary" = var.tech_poc_secondary
    application          = coalescelist([var.application, var.line_of_business])[0] # as of 9/22/2021, var.application is never actually used
    "application-owner"  = var.application_owner
  }

  legacy_tags = {
    LineOfBusiness   = var.line_of_business
    ADO              = var.ado
    TIER             = var.tier
    ENVIRONMENT      = var.operational_environment
    PrimaryTechPOC   = var.tech_poc_primary
    SecondaryTechPOC = var.tech_poc_secondary
    Application      = coalescelist([var.application, var.line_of_business])[0]
    Builder          = var.builder
    ApplicationOwner = var.application_owner
    VPC              = var.vpc
  }
}
