#!/usr/bin/env bash
set -eux -o pipefail

echo "Assuming linkerd CLI is installed in ~/.linkerd2/bin"

echo "Installing linkerd on cluster"

linkerd check --pre
linkerd install --crds | kubectl apply -f-
linkerd install | kubectl apply -f-
linkerd check
linkerd jaeger install | kubectl apply -f-
linkerd jaeger check
linkerd multicluster install | kubectl apply -f-
linkerd multicluster check
linkerd viz install --set grafana.url=grafana.grafana:3000 | kubectl apply -f-
linkerd viz check
linkerd check

echo "linkerd installed, installing tapshark"

(
  TMPDIR=$(mktemp -d)
  cd ${TMPDIR}
  git clone https://github.com/adleong/tapshark.git tapshark
  cd tapshark
  go build -o linkerd-tapshark ./main.go
  cp linkerd-tapshark $HOME/.linkerd2/bin/
  cd /tmp
  rm -rf ${TMPDIR}
)

echo "tapshark installed, granting self tap access"

kubectl create clusterrolebinding \
  $(whoami)-cluster-admin \
  --clusterrole=cluster-admin \
  --user=$(whoami)


echo "granting grafana authz to prometheus"

kubectl apply -f $(dirname $0)/../kubernetes/_script-support/authzpolicy-grafana.yaml

echo "good to go!"
