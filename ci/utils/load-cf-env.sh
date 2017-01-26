
if [[ -z $VAULT_ADDR || -z $VAULT_TOKEN || -z $FOUNDATION_NAME ]]; then
  echo "ERROR: one of the following environment variables is not set: "
  echo ""
  echo "                 VAULT_ADDR"
  echo "                 VAULT_TOKEN"
  echo "                 FOUNDATION_NAME"
  echo ""
  exit 1
fi

export VAULT_HASH_CF_PROPS="secret/cf-$FOUNDATION_NAME-props"
export VAULT_HASH_CF_PASSWORDS="secret/cf-$FOUNDATION_NAME-password"
export CF_API=https://api.$(vault read -field=system-domain $VAULT_HASH_CF_PROPS)
export CF_USERNAME=admin
export CF_PASSWORD=$(vault read -field=admin-password   $VAULT_HASH_CF_PASSWORDS)
export BOSH_USERNAME=$(vault read -field=bosh-user $VAULT_HASH_BOSH)
export BOSH_PASSWORD=$(vault read -field=bosh-pass $VAULT_HASH_BOSH)
export BOSH_CLIENT=$(vault read -field=bosh-client-id $VAULT_HASH_BOSH)
export BOSH_CA_CERT=$(vault read -field=bosh-cacert $VAULT_HASH_BOSH)
export BOSH_CLIENT_SECRET=$(vault read -field=bosh-client-secret $VAULT_HASH_BOSH)

cf api $CF_API --skip-ssl-validation
cf auth $CF_USERNAME $CF_PASSWORD
cf target -o system -s system
