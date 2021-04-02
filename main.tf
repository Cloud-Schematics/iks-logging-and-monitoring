##############################################################################
# Resource Group
##############################################################################

data ibm_resource_group group {
  name = var.resource_group
}

##############################################################################


##############################################################################
# Resources
##############################################################################

module resources {
  source            = "./resources"

  # Account Variables
  unique_id         = var.unique_id
  ibm_region        = var.ibm_region
  resource_group_id = data.ibm_resource_group.group.id

  # Resource Variables
  service_endpoints = var.service_endpoints
  logdna_plan       = var.logdna_plan
  sysdig_plan       = var.sysdig_plan
}

##############################################################################

##############################################################################
# Cluster Logging and Monitoring Setup
##############################################################################

module logging_and_monitoring {
    source        = "./logging_and_monitoring"
    logdna_crn    = module.resources.logdna_crn
    sysdig_crn    = module.resources.sysdig_crn
    ibm_region    = var.ibm_region
    cluster_name  = var.cluster_name
}

##############################################################################
