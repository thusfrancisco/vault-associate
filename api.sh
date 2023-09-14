#!/bin/bash

# Setup AppRole auth
curl \
    --header "X-Vault-Token: XXXXXXXXXXXXXXXXXXXX" \
    --request POST \
    --data @auth.json http://127.0.0.1:8200/v1/sys/auth/approle

# Create an AppRole role
curl \
    --header "X-Vault-Token: XXXXXXXXXXXXXXXXXXXX" \
    --request POST \
    --data @policies.json http://127.0.0.1:8200/v1/sys/auth/approle/role/myrole
