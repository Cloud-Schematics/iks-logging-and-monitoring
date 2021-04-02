##############################################################################
# LogDNA
##############################################################################

resource ibm_resource_instance logdna {
  name              = "${var.unique_id}-logdna"
  location          = var.ibm_region
  plan              = var.logdna_plan
  resource_group_id = var.resource_group_id
  service           = "logdna"
  service_endpoints = var.service_endpoints
}

##############################################################################


##############################################################################
# Sysdig
##############################################################################

resource ibm_resource_instance sysdig {
  name              = "${var.unique_id}-sysdig"
  location          = var.ibm_region
  plan              = var.sysdig_plan
  resource_group_id = var.resource_group_id
  service           = "sysdig-monitor"
  service_endpoints = var.service_endpoints
}

##############################################################################