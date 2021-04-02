##############################################################################
# Terraform Providers
##############################################################################

terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.21.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0"
    }
  }
}

##############################################################################


##############################################################################
# Provider
##############################################################################

provider ibm {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.ibm_region
  ibmcloud_timeout = 60
  generation       = 2
}

##############################################################################


##############################################################################
# Await Cluster Data To Initialize Kubernetes Provider
##############################################################################

data ibm_container_cluster_config cluster {
  cluster_name_id   = var.cluster_name
  resource_group_id = data.ibm_resource_group.group.id
  config_dir        = path.root
  admin             = true
  network           = true
}

provider kubernetes {
  host                   = data.ibm_container_cluster_config.cluster.host
  client_certificate     = data.ibm_container_cluster_config.cluster.admin_certificate
  client_key             = data.ibm_container_cluster_config.cluster.admin_key
  cluster_ca_certificate = data.ibm_container_cluster_config.cluster.ca_certificate
}

##############################################################################