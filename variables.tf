variable "line_of_business" {
  description = "HIDS LOB that owns the resource."
  type        = string
  default     = "TECH"

  validation {
    condition     = contains(["TECH", "GLOBAL", "QPPAR", "QSEP", "QTSO", "SAS Viya"], var.line_of_business)
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
    condition     = contains(["SBX", "PROD", "SHARED"], var.operational_environment)
    error_message = "The operational_environment value must be one of \"SBX\", \"PROD\", \"SHARED\"."
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
    error_message = "The vpc value must be one of \"APP\", \"DATA\", \"INFRA\", \"SEC\", \"ROUTING\"."
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




# variable "create_lb" {
#   description = "Controls if the Load Balancer should be created"
#   type        = bool
#   default     = true
# }

# variable "drop_invalid_header_fields" {
#   description = "Indicates whether invalid header fields are dropped in application load balancers. Defaults to false."
#   type        = bool
#   default     = false
# }

# variable "enable_deletion_protection" {
#   description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
#   type        = bool
#   default     = false
# }

# variable "enable_http2" {
#   description = "Indicates whether HTTP/2 is enabled in application load balancers."
#   type        = bool
#   default     = true
# }

# variable "enable_cross_zone_load_balancing" {
#   description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
#   type        = bool
#   default     = false
# }

# variable "extra_ssl_certs" {
#   description = "A list of maps describing any extra SSL certificates to apply to the HTTPS listeners. Required key/values: certificate_arn, https_listener_index (the index of the listener within https_listeners which the cert applies toward)."
#   type        = list(map(string))
#   default     = []
# }

# variable "https_listeners" {
#   description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate_arn. Optional key/values: ssl_policy (defaults to ELBSecurityPolicy-2016-08), target_group_index (defaults to https_listeners[count.index])"
#   type        = any
#   default     = []
# }

# variable "http_tcp_listeners" {
#   description = "A list of maps describing the HTTP listeners or TCP ports for this ALB. Required key/values: port, protocol. Optional key/values: target_group_index (defaults to http_tcp_listeners[count.index])"
#   type        = any
#   default     = []
# }

# variable "https_listener_rules" {
#   description = "A list of maps describing the Listener Rules for this ALB. Required key/values: actions, conditions. Optional key/values: priority, https_listener_index (default to https_listeners[count.index])"
#   type        = any
#   default     = []
# }

# variable "idle_timeout" {
#   description = "The time in seconds that the connection is allowed to be idle."
#   type        = number
#   default     = 60
# }

# variable "ip_address_type" {
#   description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack."
#   type        = string
#   default     = "ipv4"
# }

# variable "listener_ssl_policy_default" {
#   description = "The security policy if using HTTPS externally on the load balancer. [See](https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/elb-security-policy-table.html)."
#   type        = string
#   default     = "ELBSecurityPolicy-2016-08"
# }

# variable "internal" {
#   description = "Boolean determining if the load balancer is internal or externally facing."
#   type        = bool
#   default     = false
# }

# variable "load_balancer_create_timeout" {
#   description = "Timeout value when creating the ALB."
#   type        = string
#   default     = "10m"
# }

# variable "load_balancer_delete_timeout" {
#   description = "Timeout value when deleting the ALB."
#   type        = string
#   default     = "10m"
# }

# variable "name" {
#   description = "The resource name and Name tag of the load balancer."
#   type        = string
#   default     = null
# }

# variable "name_prefix" {
#   description = "The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters"
#   type        = string
#   default     = null
# }

# variable "load_balancer_type" {
#   description = "The type of load balancer to create. Possible values are application or network."
#   type        = string
#   default     = "application"
# }

# variable "load_balancer_update_timeout" {
#   description = "Timeout value when updating the ALB."
#   type        = string
#   default     = "10m"
# }

# variable "access_logs" {
#   description = "Map containing access logging configuration for load balancer."
#   type        = map(string)
#   default     = {}
# }

# variable "subnets" {
#   description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
#   type        = list(string)
#   default     = null
# }

# variable "subnet_mapping" {
#   description = "A list of subnet mapping blocks describing subnets to attach to network load balancer"
#   type        = list(map(string))
#   default     = []
# }

# variable "tags" {
#   description = "A map of tags to add to all resources"
#   type        = map(string)
#   default     = {}
# }

# variable "lb_tags" {
#   description = "A map of tags to add to load balancer"
#   type        = map(string)
#   default     = {}
# }

# variable "target_group_tags" {
#   description = "A map of tags to add to all target groups"
#   type        = map(string)
#   default     = {}
# }

# variable "security_groups" {
#   description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
#   type        = list(string)
#   default     = []
# }

# variable "target_groups" {
#   description = "A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port"
#   type        = any
#   default     = []
# }

# variable "vpc_id" {
#   description = "VPC id where the load balancer and other resources will be deployed."
#   type        = string
#   default     = null
# }
