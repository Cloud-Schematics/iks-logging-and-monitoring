##############################################################################
# LogDNA Outputs
##############################################################################

output logdna_guid {
    description = "GUID of LogDNA Instance"
    value       = ibm_resource_instance.logdna.guid
}

output logdna_crn {
    description = "ID of LogDNA Instance Key"
    value       = ibm_resource_instance.logdna.id
}

##############################################################################


##############################################################################
# Sysdig Outputs
##############################################################################

output sysdig_guid {
    description = "GUID of Sysdig Instance"
    value       = ibm_resource_instance.sysdig.guid
}

output sysdig_crn {
    description = "ID of Sysdig Instance"
    value       = ibm_resource_instance.sysdig.id
}

##############################################################################