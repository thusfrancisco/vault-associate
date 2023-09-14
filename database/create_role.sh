#!/bin/bash

# Create a new role that has SELECT permissions for the schema 'sampledb'
vault write database/roles/sampledb-role \
    db_name=mysql01 \
    creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY 
'{{password}}';GRANT SELECT ON sampledb.* TO '{{name}}'@'%';" \
    default_ttl="1h" \
    max_ttl="4h"
