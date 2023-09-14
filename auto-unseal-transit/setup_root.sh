#!/bin/bash
# Enable transit auto unseal at root vault
vault secrets enable transit

# Create an unseal key for the children
vault write -force transit/keys/unseal-key

# Create a policy that grants another cluster permissions to edit the unseal key
vault policy write unseal policy.hcl