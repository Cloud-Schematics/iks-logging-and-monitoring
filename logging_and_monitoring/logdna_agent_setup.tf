##############################################################################
# Create Namespace
##############################################################################

resource kubernetes_namespace ibm_observe {
  metadata {
    name = "ibm-observe"
  }
}

##############################################################################

##############################################################################
# Create LogDNA Ingestion Key
##############################################################################

resource ibm_resource_key logdna_secret {
  name                 = "logdna_key"
  role                 = "Manager"
  resource_instance_id = var.logdna_crn
}

##############################################################################


##############################################################################
# Create LogDNA Agent Key
##############################################################################

resource kubernetes_secret logdna_agent_key {
  metadata {
    name      = "logdna-agent-key"
    namespace = "ibm-observe"
  }
  data = {
    logdna-agent-key = ibm_resource_key.logdna_secret.credentials["ingestion_key"]
  }
  type = "Opaque"

  depends_on = [
    kubernetes_namespace.ibm_observe
  ]
}

##############################################################################


##############################################################################
# Create LogDNA Service Account
##############################################################################

resource kubernetes_service_account logdna_agent {
  metadata {
    name      = "logdna-agent"
    namespace = "ibm-observe"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  depends_on = [
    kubernetes_secret.logdna_agent_key
  ]

}

##############################################################################


##############################################################################
# LogDNA Agent Role
##############################################################################

resource kubernetes_role logdna_agent {
  metadata {
    name      = "logdna-agent"
    namespace = "ibm-observe"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  rule {
    verbs      = ["get", "list", "create", "watch"]
    api_groups = [""]
    resources  = ["configmaps"]
  }

  depends_on = [
    kubernetes_service_account.logdna_agent
  ]

}

##############################################################################


##############################################################################
# LogDNA Agent Role Binding
##############################################################################

resource kubernetes_role_binding logdna_agent {
  metadata {
    name      = "logdna-agent"
    namespace = "ibm-observe"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  subject {
    kind      = "ServiceAccount"
    name      = "logdna-agent"
    namespace = "ibm-observe"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "logdna-agent"
  }

  depends_on = [
    kubernetes_role.logdna_agent
  ]

}

##############################################################################


##############################################################################
# LogDNA Cluster Role 
##############################################################################

resource kubernetes_cluster_role logdna_agent {
  metadata {
    name = "logdna-agent"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  rule {
    verbs      = ["get", "list", "create", "watch"]
    api_groups = [""]
    resources  = ["events"]
  }

  rule {
    verbs      = ["get", "list", "watch"]
    api_groups = [""]
    resources  = ["pods"]
  }

  depends_on = [
    kubernetes_role_binding.logdna_agent
  ]

}

##############################################################################


##############################################################################
# LogDNA Cluster Role Binding
##############################################################################

resource kubernetes_cluster_role_binding logdna_agent {
  metadata {
    name = "logdna-agent"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  subject {
    kind      = "ServiceAccount"
    name      = "logdna-agent"
    namespace = "ibm-observe"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "logdna-agent"
  }

  depends_on = [
    kubernetes_cluster_role.logdna_agent
  ]
}

##############################################################################


##############################################################################
# LogDNA Daemonset
##############################################################################

resource kubernetes_daemonset logdna_agent {
  metadata {
    name      = "logdna-agent"
    namespace = "ibm-observe"

    labels = {
      "app.kubernetes.io/instance" = "logdna-agent"
      "app.kubernetes.io/name"     = "logdna-agent"
      "app.kubernetes.io/version"  = "2.2.4"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "logdna-agent"
      }
    }

    template {
      metadata {
        labels = {
          app = "logdna-agent"

          "app.kubernetes.io/instance" = "logdna-agent"
          "app.kubernetes.io/name"     = "logdna-agent"
          "app.kubernetes.io/version"  = "2.2.4"
        }
      }

      spec {
        volume {
          name = "varlog"

          host_path {
            path = "/var/log"
          }
        }

        volume {
          name = "vardata"

          host_path {
            path = "/var/data"
          }
        }

        volume {
          name = "varlibdockercontainers"

          host_path {
            path = "/var/lib/docker/containers"
          }
        }

        volume {
          name = "mnt"

          host_path {
            path = "/mnt"
          }
        }

        volume {
          name = "osrelease"

          host_path {
            path = "/etc/os-release"
          }
        }

        volume {
          name = "logdnahostname"

          host_path {
            path = "/etc/hostname"
          }
        }

        container {
          name  = "logdna-agent"
          image = "icr.io/ext/logdna-agent:2.2.4"

          env {
            name = "LOGDNA_AGENT_KEY"

            value_from {
              secret_key_ref {
                name = "logdna-agent-key"
                key  = "logdna-agent-key"
              }
            }
          }

          env {
            name  = "LOGDNA_HOST"
            value = "logs.private.eu-gb.logging.cloud.ibm.com"
          }

          env {
            name = "POD_APP_LABEL"

            value_from {
              field_ref {
                field_path = "metadata.labels['app.kubernetes.io/name']"
              }
            }
          }

          env {
            name = "POD_NAME"

            value_from {
              field_ref {
                field_path = "metadata.name"
              }
            }
          }

          env {
            name = "NODE_NAME"

            value_from {
              field_ref {
                field_path = "spec.nodeName"
              }
            }
          }

          env {
            name = "NAMESPACE"

            value_from {
              field_ref {
                field_path = "metadata.namespace"
              }
            }
          }

          resources {
            limits = {
              memory = "500Mi"
            }

            requests = {
              cpu = "20m"
            }
          }

          volume_mount {
            name       = "varlog"
            mount_path = "/var/log"
          }

          volume_mount {
            name       = "vardata"
            mount_path = "/var/data"
          }

          volume_mount {
            name       = "varlibdockercontainers"
            read_only  = true
            mount_path = "/var/lib/docker/containers"
          }

          volume_mount {
            name       = "mnt"
            read_only  = true
            mount_path = "/mnt"
          }

          volume_mount {
            name       = "osrelease"
            mount_path = "/etc/os-release"
          }

          volume_mount {
            name       = "logdnahostname"
            mount_path = "/etc/logdna-hostname"
          }

          image_pull_policy = "Always"

          security_context {
            capabilities {
              add  = ["DAC_READ_SEARCH"]
              drop = ["all"]
            }
          }
        }

        service_account_name = "logdna-agent"
      }
    }

    strategy {
      type = "RollingUpdate"

      rolling_update {
        max_unavailable = "100%"
      }
    }
  }

  depends_on = [
    kubernetes_cluster_role_binding.logdna_agent
  ]

}

##############################################################################