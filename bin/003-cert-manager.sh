#!/usr/bin/env bash
set -eux -o pipefail

helm repo add jetstack https://charts.jetstack.io --force-update

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.15.3 \
  --values $(dirname $0)/../helm/cert-manager/values.yaml
