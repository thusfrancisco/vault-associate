# Steps to run Vault in Production

- Download Vault from HashiCorp.
- Unpackage Vault.
- Set path to executable.
- Add configuration file& customize.
- Create Systemd service file.
- Download Consul from HashiCorp.
- Configure and join Consul cluster.
- Launch Vault service.

# Storage backends

Raft is the newer version to run Vault with HA (High Availability).
Not having to use Consul makes it considerably simpler, and removes another potential point of failure.

# Audit logs

Only string secrets are encrypted.
For this reason, HashiCorp recommends that all data sent to the Vault is first converted to a string.