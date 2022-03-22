variable "line_of_business" {
  description = "HIDS LOB that owns the resource."
  type        = string
  default     = "HQR"

  validation {
    condition     = contains(["ASPEN", "CAADS", "DDST", "DEL", "EQRS", "ESRD QIP", "ESS", "HIDS", "HIVVS", "HQR", "iQIES", "MAT", "PAC GVO", "PM3", "QCOR", "QIES", "QMARS", "QPPAR", "QSEP", "QTSO", "SAS Viya"], var.line_of_business)
    error_message = "The line_of_business value must be one of \"ASPEN\", \"CAADS\", \"DDST\", \"DEL\", \"EQRS\", \"ESRD QIP\", \"ESS\", \"HIDS\", \"HIVVS\", \"HQR\", \"iQIES\", \"MAT\", \"PAC GVO\", \"PM3\", \"QCOR\", \"QIES\", \"QMARS\", \"QPPAR\", \"QSEP\", \"QTSO\", \"SAS Viya\"."
  }
}

variable "ado" {
  description = "HIDS ADO that owns the resource. The ServiceNow Contracts table is the system of record for the actual ADO names and LOB names."
  type        = string
  default     = "Kojitechs"

  validation {
    condition     = contains(["Arbor", "Aplus", "ATG", "Kojitechs", "CVP", "FEI", "Flexion", "GDIT", "Hendall", "Mantech", "Raven TEK", "SBD", "SemanticBits", "Tantus", "Telligen", "Tista", "Ventech", "Ventera"], var.ado)
    error_message = "The ado value must be one of \"Arbor\", \"Aplus\", \"ATG\", \"Kojitechs\", \"CVP\", \"FEI\", \"Flexion\", \"GDIT\", \"Hendall\", \"Mantech\", \"Raven TEK\", \"SBD\", \"SemanticBits\", \"Tantus\", \"Telligen\", \"Tista\", \"Ventech\", \"Ventera\"."
  }
}

variable "tier" {
  description = "Network tier or layer where the resource resides. These tiers are represented in every VPC regardless of single-tenant or multi-tenant. For most resources in the Infrastructure and Security VPC, the TIER will be Management. But in some cases,such as Atlassian, the other tiers are relevant."
  type        = string

  validation {
    condition     = contains(["WEB", "APP", "DATA", "MGT", "TRAN"], var.tier)
    error_message = "The tier value must be one of \"WEB\", \"APP\", \"DATA\", \"MGT\", \"TRAN\"."
  }
}

variable "operational_environment" {
  description = "Operational Environment the resource resides in. The operational environments are MANDATORY for an ADO and Ventech. We use the VPC tag to differentiate the overall type of VPC from the specific operational environment."
  type        = string

  validation {
    condition     = contains(["SBX", "DEV", "TEST", "IMPL", "ITF", "PROD"], var.operational_environment)
    error_message = "The operational_environment value must be one of \"SBX\", \"DEV\", \"TEST\", \"IMPL\", \"ITF\", \"PROD\"."
  }
}

variable "tech_poc_primary" {
  description = "Email Address of the Primary Technical Contact for the AWS resource."
  type        = string

  validation {
    condition     = can(regex("^.+@.+\\.[a-zA-Z]+$", var.tech_poc_primary))
    error_message = "The tech_poc_primary value must be a valid email address."
  }
}

variable "tech_poc_secondary" {
  description = "Email Address of the Secondary Technical Contact for the AWS resource."
  type        = string

  validation {
    condition     = can(regex("^.+@.+\\.[a-zA-Z]+$", var.tech_poc_secondary))
    error_message = "The tech_poc_secondary value must be a valid email address."
  }
}

variable "application" {
  description = "Logical name for the application. Mainly used for Ventech. For an ADO/LOB owned application default to the LOB name."
  type        = string
  default     = null
}

variable "builder" {
  description = "The name of the person who created the resource."
  type        = string
}

variable "application_owner" {
  description = "Email Address of the group who owns the application. This should be a distribution list and no an individual email if at all possible. Primarily used for Ventech-owned applications to indicate what group/department is responsible for the application using this resource. For an ADO/LOB owned application default to the LOB name."

  validation {
    condition     = can(regex("^.+@.+\\.[a-zA-Z]+$", var.application_owner))
    error_message = "The application_owner value must be a valid email address."
  }
}

variable "vpc" {
  description = "The VPC the resource resides in. We need this to differentiate from Lifecycle Environment due to INFRA and SEC. One of \"APP\", \"INFRA\", \"SEC\", \"ROUTING\"."
  type        = string

  validation {
    condition     = contains(["APP", "INFRA", "SEC", "ROUTING"], var.vpc)
    error_message = "The vpc value must be one of \"APP\", \"INFRA\", \"SEC\", \"ROUTING\"."
  }
}

variable "cell_name" {
  description = "The name of the cell."
  type        = string
}

variable "component_name" {
  description = "The name of the component, if applicable."
  type        = string
  default     = null
}
