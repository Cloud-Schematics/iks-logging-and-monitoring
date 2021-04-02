# Container Logging and Monitoring Setup

This module will automatically deploy Logging and Mornitoring agents onto your Kubernetes on VPC Cluster. In this example a LogDNA and Sysdig instance are created, but the [logging_and_monitoring](./logging_and_monitoring) module can be used on it's own if you already have an instance provisioned.

---

### Table of Contents
1. [About](##about)
2. [Module Variables](##Module-Variables)
3. [Outputs](##Outputs) (optional)
4. [As a Module in a Larger Architecture](##As-a-Module-in-a-Larger-Architecture)

---

## About

This module allows you to get detailed service logs from your kubernetes cluster using logging and monitoring services:

### Logging

From the moment you provision a cluster with IBM Cloud Kubernetes Service, you want to know what is happening inside the cluster. You need to access logs to troubleshoot problems and pre-empt issues. At any time, you want to have access to different types of logs such as worker logs, pod logs, app logs, or network logs. In addition, you want to monitor different sources of log data in your Kubernetes cluster. Therefore, your ability to manage and access log records from any of these sources is critical. Your success managing and monitoring logs depends on how you configure the logging capabilities for your Kubernetes platform.<sup>[[1]](https://cloud.ibm.com/docs/services/Log-Analysis-with-LogDNA/tutorials?topic=LogDNA-kube)</sup>

### Monitoring

IBM Cloud™ Monitoring with Sysdig is a third-party cloud-native, and container-intelligence management system that you can include as part of your IBM Cloud architecture. Use it to gain operational visibility into the performance and health of your applications, services, and platforms. It offers administrators, DevOps teams, and developers full stack telemetry with advanced features to monitor and troubleshoot, define alerts, and design custom dashboards. IBM Cloud Monitoring with Sysdig is operated by Sysdig in partnership with IBM.<sup>[[2]](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig/tutorials?topic=Sysdig-about)</sup>

### Additional Resources

- [More about Log Analysis](https://cloud.ibm.com/docs/services/Log-Analysis-with-LogDNA)
- [More about Monitoring with Sysdig](https://cloud.ibm.com/docs/services/Monitoring-with-Sysdig)

---
## Module Variables

Variable     | Type   | Description                                                     | Default
------------ | ------ | --------------------------------------------------------------- |--------
ibm_region   | string | IBM Region where resource will be provisioned                   | 
logdna_crn   | string | The unique identifier of the LogDNA instance                    | 
sysdig_crn   | string | The unique identifier of the Sysdig instance                    | 
cluster_name | string | The name of the cluster where Sysdig agents will be installed   | 