ui = true

# HA parameters
api_addr = "https://vault-us-east-1.example.com:8200"
cluster_addr = " https://node-a-us-east-1.example.com:8201"
cluster_name = "vault-prod-us-east-1"

# Disabling mlock is strongly recommended if using integrated storage.
disable_mlock = true
log_level = "INFO"

# Usage
default_lease_ttl = 24h

storage "raft" {
  path    = "/opt/vault/data"
  node_id = "node-a-us-east-1.example.com"
  retry_join {
    auto_join = "provider=aws region=us-east-1 tag_key=vault tag_value=us-east-1"
  }
}

listener "tcp" {
 address = "0.0.0.0:8200"
 cluster_address = "0.0.0.0:8201"
 tls_disable = 0
 tls_cert_file = "/etc/vault.d/client.pem"
 tls_key_file = "/etc/vault.d/cert.key"
 tls_disable_client_certs = "true"
}

seal "transit" {
  address            = "https://vault:8200"
  token              = "s.Qf1s5zigZ4OX6akYjQXJC1jY"
  disable_renewal    = "false"

  // Key configuration
  key_name           = "transit_key_name"
  mount_path         = "transit/"
  namespace          = "ns1/"

  // TLS Configuration
  tls_ca_cert        = "/etc/vault/ca_cert.pem"
  tls_client_cert    = "/etc/vault/client_cert.pem"
  tls_client_key     = "/etc/vault/ca_cert.pem"
  tls_server_name    = "vault"
  tls_skip_verify    = "false"
}