# Monitoring (kube-prometheus-stack)

This folder contains everything needed to install Prometheus + Grafana on EKS using the
`kube-prometheus-stack` Helm chart (Prometheus Operator + Prometheus + Alertmanager + Grafana).

## Why this design

- We keep everything versioned in Git: namespace, values, install/uninstall scripts.
- Grafana is exposed using a Kubernetes `Service` of type **LoadBalancer** (no Ingress controller required).
  This is the simplest way to get a public URL in Kubernetes. [K8s docs](https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/).  
- Chart docs and parameters: [`kube-prometheus-stack` README](https://github.com/prometheus-community/helm-charts/issues/1820).

## Install

```bash
bash platform/monitoring/install.sh
