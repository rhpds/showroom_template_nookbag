#!/bin/bash
# validate-module2.sh — runs ON the bastion
# Exit 0 = pass, non-zero = fail

if oc get configmap app-config -n demo-project &>/dev/null; then
  echo "✅ ConfigMap app-config exists in demo-project"
  exit 0
else
  echo "❌ ConfigMap app-config not found in demo-project"
  exit 1
fi
