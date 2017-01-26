#!/usr/bin/env bash
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/ci/utils/load-bosh-env.sh

LEADER_IP=$(vault read --field=leader-ip $VAULT_HASH_PROPS)
SLAVE_IP=$(vault read --field=slave-ip $VAULT_HASH_PROPS)
REDIS_PASS=$(vault read --field=redis-pass $VAULT_HASH_PROPS)
NETWORK_NAME=$(vault read --field=network-name $VAULT_HASH_PROPS)
VM_SIZE=$(vault read --field=vm-size $VAULT_HASH_PROPS)

SLAVE_INSTANCES=$(($(grep -o "," <<< "$SLAVE_IP" | wc -l)+1))
LEADER_INSTANCES=$(($(grep -o "," <<< "$LEADER_IP" | wc -l)+1))
POOL_INSTANCES=$((LEADER_INSTANCES + SLAVE_INSTANCES))

chmod +x omg-cli/omg-linux

omg-cli/omg-linux register-plugin \
  -type product \
  -pluginpath omg-product-bundle/$PRODUCT_PLUGIN

omg-cli/omg-linux deploy-product \
  --bosh-url  $BOSH_URL \
  --bosh-user $BOSH_USERNAME \
  --bosh-pass $BOSH_PASSWORD \
  --print-manifest \
  --ssl-ignore \
  $PRODUCT_PLUGIN \
  --leader-ip=$LEADER_IP \
  --slave-ip=$ \
  --redis-pass=$REDIS_PASS \
  --slave-instances=$SLAVE_INSTANCES \
  --errand-instances=1 \
  --pool-instances=$POOL_INSTANCES \
  --network-name=$NETWORK_NAME \
  --vm-size=$VM_SIZE \
  --stemcell-url=https://bosh.io/d/stemcells/bosh-vsphere-esxi-ubuntu-trusty-go_agent?v=3263.17 \
  --stemcell-ver=3263.17 \
  --stemcell-sha=70ca4e0f8a3602a53919cd4e8fd97770ed7da234 > manifest/deployment.yml

#eof
