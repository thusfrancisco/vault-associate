#!/bin/bash

export VAULT_ADDR="https://vault.example.com:8200"
export VAULT_FORMAT=json

OUTPUT=$(vault write auth/approle/login role_id="1234567" secret_id="123kga7ibm")

VAULT_TOKEN=$(echo $OUTPUT | jq '.auth.client_token' -j)

vault login $VAULT_TOKEN