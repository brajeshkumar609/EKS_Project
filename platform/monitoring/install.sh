#!/usr/bin/env bash
set -euo pipefail

# 0) Repo root safety (optional)
# cd "$(dirname "$0")"

# 1) Ensure Helm repos are available
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts 1>/dev/null
helm repo update 1>/dev/null

# 2) Create/replace namespace from Git-tracked manifest
kubectl apply -f platform/monitoring/ns-monitoring.yaml

# 3) Install or upgrade the stack using our values
helm upgrade --install kube-prometheus-stack \
  prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f platform/monitoring/values.kube-prom-stack.yaml \
  --wait --timeout 20m

echo ""
echo "Waiting for Grafana Service external address ..."
kubectl -n monitoring get svc -w prometheus-grafana
