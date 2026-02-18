#!/usr/bin/env bash
set -euo pipefail

# Try to uninstall the release if it exists
helm uninstall kube-prometheus-stack -n monitoring || true

# Delete the namespace (and wait)
kubectl delete ns monitoring --ignore-not-found
kubectl wait ns/monitoring --for=delete --timeout=180s || true

echo "Monitoring release and namespace removed."
