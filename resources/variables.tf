##############################################################################
# Account Variables
##############################################################################

variable unique_id {
  description = "Unique ID for resources that will be provisioned"
  type        = string
}

variable ibm_region {
    description = "IBM Cloud region where all resources will be deployed"
    type        = string
}

variable resource_group_id {
    description = "ID for IBM Cloud Resource Group where resources will be deployed"
    type        = string
}

##############################################################################


##############################################################################
# Resource Variables
##############################################################################

variable service_endpoints {
  description = "Service endpoints for resource instances. Can be `public`, `private`, or `public-and-private`"
  type        = string
  default     = "private"
}

##############################################################################


##############################################################################
# Key Protect Variables
##############################################################################

variable kms_plan {
  description = "Plan for Key Protect"
  type        = string
  default     = "tiered-pricing"  
}

variable kms_root_key_name {
  description = "Name of the root key for Key Protect instance"
  type        = string
  default     = "root-key"
}

##############################################################################


##############################################################################
# Logging and Monitoring Variables
##############################################################################

variable logdna_plan {
  description = "Plan for Databases for PostgreSQL"
  type        = string
  default     = "7-day"
}

variable sysdig_plan {
  description = "Plan for Databases for PostgreSQL"
  type        = string
  default     = "graduated-tier"
}

##############################################################################