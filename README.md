# 🔐 HashiCorp Vault Setup (Production-Ready)
A Docker-based production setup of HashiCorp Vault for secure secrets management,supporting TLS, persistent storage, and LDAP integration.

## 📦 Features
- Production-ready Vault containerized via Docker
- TLS-enabled secure API access
- Persistent secrets backend
- Health checks and auto-restart
- Integration-ready for LDAP-authenticated
- Environment-configurable via .env
- Optional Vault Agent for auto-authentication

### Project Structure
```
vault-setup/
├── docker-compose.yml
├── vault-config/
│   ├── config.hcl            # Vault server configuration
│   ├── certs/                # TLS certificate and key
│   │   ├── vault.crt
│   │   └── vault.key
│   └── vault.env             # Env variables for Vault CLI use
```

## 🚀 Quick Start
1. Clone the Repo
```bash
git clone https://github.com/YOUR_ORG/vault-setup.git
cd vault-setup
```
2. Generate TLS Certificate (for dev/testing)
```bash
mkdir -p vault-config/certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout vault-config/certs/vault.key \
  -out vault-config/certs/vault.crt \
  -subj "/CN=vault.local"
```
Use a valid TLS cert in production (e.g., Let's Encrypt or internal CA).

3. Launch Vault
```bash
docker compose up -d
```

## 🔑 Initialize Vault (One-time)
```bash
docker exec -it vault-setup_vault_1 vault operator init -key-shares=1 -key-threshold=1

# -key-shares: Number of unseal keys to generate.
# -key-threshold: Number of keys required to unseal the Vault.
```
## 🔓 Unseal Vault (Each Restart)
```bash
docker exec -it vault-setup_vault_1 vault operator unseal <unseal_key>

# Replace <unseal_key> with one of the unseal keys generated during the initialization step.
# Example:
# docker exec -it vault-setup_vault_1 vault operator unseal s.1234567890abcdef
```
## 🔐 Login
```bash
docker exec -it vault-setup_vault_1 vault login <root_token>

export VAULT_ADDR=https://vault.local:8200
export VAULT_SKIP_VERIFY=true         # If using self-signed certs
export VAULT_TOKEN=<YOUR_ROOT_TOKEN>

vault status
vault secrets list
```
## 🛠️ Vault Agent (Optional)
```bash
docker exec -it vault-setup_vault_1 vault agent -config=/vault/config/agent.hcl
```
##🛠️ Enable Key/Value Secrets Engine
```bash
docker exec -it vault-setup_vault_1 vault secrets enable -path=secret kv-v2
docker exec -it vault-setup_vault_1 vault secrets enable -path=ldap kv-v2

docker exec -it vault-setup_vault_1 vault secrets list
docker exec -it vault-setup_vault_1 vault secrets list -detailed
```
## 📝 Store a Secret
```bash
vault kv put ldap/config \
  binddn="cn=admin,dc=example,dc=com" \
  bindpw="SuperSecret" \
  ldap_uri="ldap://ldap.example.com" \
  ldap_base="dc=example,dc=com"
```
## 🔍 Read a Secret
```bash
vault kv get ldap/config
```

## 🧪 Health Check
```bash
curl -k https://localhost:8200/v1/sys/health
# or
docker exec -it vault-setup_vault_1 curl -k https://localhost:8200/v1/sys/health
# or
docker exec -it vault-setup_vault_1 vault status
```

