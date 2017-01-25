#!/usr/bin/env bash
set -e

project_dir=$(readlink -f "$(dirname $0)/../..")
source $project_dir/ci/utils/load-bosh-env.sh

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
  --deployment-name $DEPLOYMENT_NAME \
  --infer-from-cloud \
  --skip-ssl-verify \
  --stemcell-ver $STEMCELL_VERSION \
  --vault-domain $VAULT_ADDR \
  --vault-hash $VAULT_HASH_ERT_IP \
  --vault-hash $VAULT_HASH_IP \
  --vault-hash $VAULT_HASH_PASSWORD \
  --vault-hash $VAULT_HASH_HOSTVARS \
  --vault-hash $VAULT_HASH_MISC \
  --vault-token $VAULT_TOKEN > manifest/deployment.yml

#eof
