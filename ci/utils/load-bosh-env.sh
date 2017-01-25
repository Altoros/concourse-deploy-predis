

if [[ -z $VAULT_ADDR || -z $VAULT_TOKEN ]]; then
  echo "ERROR: one of the following environment variables is not set: "
  echo ""
  echo "                 VAULT_ADDR"
  echo "                 VAULT_TOKEN"
  echo ""
  exit 1
fi

export VAULT_HASH_BOSH="secret/rabbitmq-$FOUNDATION_NAME-props"
export BOSH_URL=$(vault read -field=bosh-url   $VAULT_HASH_BOSH)
export BOSH_USER=$(vault read -field=bosh-user $VAULT_HASH_BOSH)
export BOSH_PASS=$(vault read -field=bosh-pass $VAULT_HASH_BOSH)
export BOSH_CLIENT=$(vault read -field=bosh-client-id $VAULT_HASH_BOSH)
export BOSH_CA_CERT=$(vault read -field=bosh-cacert $VAULT_HASH_BOSH)
export BOSH_CLIENT_SECRET=$(vault read -field=bosh-client-secret $VAULT_HASH_BOSH)
