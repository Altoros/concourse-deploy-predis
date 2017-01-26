#!/usr/bin/env bash
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/ci/utils/load-bosh-env.sh

VAULT_HASH_PROPS=secret/redis-$FOUNDATION_NAME-props
MASTER_IP=$(vault read --field=master-ip $VAULT_HASH_PROPS)
SLAVE_IP=$(vault read --field=slave-ip $VAULT_HASH_PROPS)
REDIS_PASSWORD=$(vault read --field=redis-pass $VAULT_HASH_PROPS)
NETWORK_NAME=$(vault read --field=network-name $VAULT_HASH_PROPS)
VM_SIZE=$(vault read --field=vm-size $VAULT_HASH_PROPS)

SLAVE_INSTANCES=$(($(grep -o "," <<< "$SLAVE_IP" | wc -l)+1))
MASTER_INSTANCES=$(($(grep -o "," <<< "$MASTER_IP" | wc -l)+1))
POOL_INSTANCES=$((MASTER_INSTANCES + SLAVE_INSTANCES))

bosh interpolate $project_dir/manifest/base.yml \
                 --vars-store secrets.yml \
                 --var="deployment-name=$DEPLOYMENT_NAME" \
                 --var="master-instances-count=$MASTER_INSTANCES" \
                 --var="master-ip=$MASTER_IP" \
                 --var="network=$NETWORK_NAME" \
                 --var="redis-password=$REDIS_PASSWORD" \
                 --var="slave-ip=$SLAVE_IP" \
                 --var="vm-size=$VM_SIZE" \
                 --var-errs > manifest/deployment.yml

bosh -n deploy -d $DEPLOYMENT_NAME manifest/deployment.yml

#eof
