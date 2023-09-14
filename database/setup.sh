#!/bin/bash

vault secrets enable database

# Write new database configuration for the plugin
vault write database/config/mysql01 \
    plugin_name=mysql-database-plugin \
    connection_url="{{username}}:{{password}}@tcp(localhost:3306)/" \
    allowed_roles="hcvop-role, kodekloud-role" \
    username="vault-admin" \
    password="Password123"

# Rotate the credentials. Only Vault and the database server will know the new credentials.
vault write -f database/rotate-root/mysql01
