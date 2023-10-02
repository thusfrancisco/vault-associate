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

# Configuration

Disabling `mlock` is strongly recommended if using integrated storage,
because `mlock` does not interact well with memory-mapped files such as those created by BoltDB,
which is used by Raft to track state.
When using `mlock`, m-mapped files get loaded into resident memory which causes Vault's entire dataset to be loaded in-memory and cause out-of-memory issues if Vault's data becomes larger than the available RAM.
In this case, even though the data within BoltDB remains encrypted at rest, swap should be disabled to prevent Vault's other in-memory sensitive data from being dumped into disk.

On Linux, to give the Vault executable the ability to use the `mlock` syscall without running the process as root, run:
```sh
sudo setcap cap_ipc_lock=+ep $(readlink -f $(which vault))
```

In order to assess the correctness of a configuration file, consider running the command:

```bash
vault operator diagnose -config=/etc/vault.d/vault.hcl
```

# CLI

Set the environment variable `VAULT_FORMAT` to `json` before making CLI calls to make Vault produce all its outputs in the JSON format.

# Choosing an auth method

For:
- Credentials that need to be frequently rotated, use a dynamic credential:
    - AWS, LDAP, Azure, GCP, K8s.
    - NOT Userpass, TLS, AppRole.
- Secrets that must be removed from a process or build pipeline:
    - AWS, Azure, GCP, K8s.
    - NOT Userpass, LDAP.
- Existing user credentials, integrate with an existing IdP (without creating new credentials):
    - OIDC, LDAP, Okta, GitHub.
    - NOT Userpass, AWS, Azure, GCP.

# Policies

## Pathing wildcards

The `*` glob works in the traditional way.

The `+` character supports wildcard matching for a single directory in the path, e.g. ``kv/data/apps/+/webapp`` supports:
- `kv/data/apps/dev/webapp`
- `kv/data/apps/qa/webapp`
- `kv/data/apps/prod/webapp`
