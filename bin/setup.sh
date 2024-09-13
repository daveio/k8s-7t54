#!/usr/bin/env bash
set -eux -o pipefail

SCRIPTPATH=$(dirname $0)

${SCRIPTPATH}/001-linkerd.sh
${SCRIPTPATH}/002-helm.sh
${SCRIPTPATH}/003-cert-manager.sh
${SCRIPTPATH}/004-gloo.sh
