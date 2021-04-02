##############################################################################
# Variables
##############################################################################

variable ibmcloud_api_key {
    description = "The IBM Cloud platform API key needed to deploy IAM enabled resources"
    type        = string
}

variable ibm_region {
    description = "IBM Region where resource will be provisioned"
    type        = string
}

variable unique_id {
    description = "A unique identifier need to provision resources. Must begin with a letter"
    type        = string
}

variable resource_group {
    description = "Name for IBM Cloud Resource Group where resources will be deployed"
    type        = string
}

variable cluster_name {
    description = "The name of the cluster where Sysdig agents will be installed"
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