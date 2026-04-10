#!/bin/bash
# solve-module2.sh — runs ON the bastion as lab-user (system:admin)
# Copied from the runner to the bastion by ansible.builtin.script

oc create configmap app-config \
  --from-literal=environment=production \
  --from-literal=app=my-app \
  -n demo-project \
  --dry-run=client -o yaml | oc apply -f -

echo "ConfigMap app-config applied in demo-project"
