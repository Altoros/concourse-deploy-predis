
### Redis in a blink of eye

Command parts that all pipeline have:

Vault paths:

* `secret/<product-name>-<foundation-name>-ips` - stores all ip addresses for the 
* `secret/<product-name>-<foundation-name>-passwords` - stores all 
* `secret/<product-name>-<foundation-name>-props`


1. Generate manifest (with `omg-cli` or with `generate-manifest` script)
2. Convert manifest to BOSH v2 (if needed)
3. Split manifest to `core` and `satellite` services
4. read vault values for `core` and store them into `vars.yml` (from `*-password` vault path)
5. run bosh deploy `core` with `vars.yml` as a var store
6. update vault with values from `vars.yml` (`*-password` vault path)
7. extract ip bosh data from (`*-ip` vault path)