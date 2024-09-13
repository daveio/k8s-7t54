#!/usr/bin/env bash
set -eux -o pipefail

echo "Installing/reinstalling Gloo CLI"

curl -sL https://run.solo.io/gloo/install | sh

echo "Installing Gloo Gateway"

glooctl install gateway
