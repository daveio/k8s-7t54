#!/usr/bin/env bash
set -eux -o pipefail

helm repo add grafana https://grafana.github.io/helm-charts --force-update

helm install grafana -n grafana --create-namespace grafana/grafana \
  --values $(dirname $0)/../helm/grafana/values.yaml

sleep 10

kubectl get deploy -n grafana -o yaml | linkerd inject - | kubectl apply -f-
