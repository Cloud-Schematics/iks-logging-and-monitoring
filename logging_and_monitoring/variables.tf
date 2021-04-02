##############################################################################
# Variables
##############################################################################

variable ibm_region {
    description = "IBM Region where resource will be provisioned"
    type        = string
}

variable logdna_crn {
    description = "The unique identifier of the LogDNA instance"
    type        = string
}
variable sysdig_crn {
    description = "The unique identifier of the Sysdig instance"
    type        = string
}

variable cluster_name {
    description = "The name of the cluster where Sysdig agents will be installed"
    type        = string
}

##############################################################################