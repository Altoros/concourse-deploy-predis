#!/bin/bash -e

# BOSH_CLIENT: {{bosh-user}}
# BOSH_CLIENT_SECRET: {{bosh-pass}}
# BOSH_CACERT: {{bosh-cacert}}
# DEPLOYMENT_NAME: {{deployment-name}}
# PRODUCT_PLUGIN: {{product-plugin}}
# STEMCELL_VERSION: {{stemcell-version}}
# VAULT_ADDR: {{vault_addr}}
# VAULT_HASH_ERT_IP: {{vault_hash_ert_ip}}
# VAULT_HASH_IP: {{vault_hash_ip}}
# VAULT_HASH_HOSTVARS: {{vault_hash_hostvars}}
# VAULT_HASH_MISC: {{vault_hash_misc}}
# VAULT_HASH_PASSWORD: {{vault_hash_password}}
# VAULT_TOKEN: {{vault_token}}
# OUTPUT_DIR: manifest

BOSH_URL=$(vault read -field=bosh-url  $VAULT_HASH_BOSH)
BOSH_USER=$(vault read -field=bosh-user $VAULT_HASH_BOSH)
BOSH_PASS=$(vault read -field=bosh-pass $VAULT_HASH_BOSH)

chmod +x omg-cli/omg-linux

omg-cli/omg-linux register-plugin \
  -type product \
  -pluginpath omg-product-bundle/$PRODUCT_PLUGIN

omg-cli/omg-linux deploy-product \
  --bosh-url  $BOSH_URL \
  --bosh-user $BOSH_USER \
  --bosh-pass $BOSH_PASS \
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
