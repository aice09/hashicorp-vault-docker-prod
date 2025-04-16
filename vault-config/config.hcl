ui = true

# Storage Backend - Use file storage for simplicity
storage "file" {
  path = "/vault/data"
}

# Listener for HTTP API
listener "tcp" {
  address = "0.0.0.0:8200"
  tls_cert_file = "/vault/config/certs/vault.crt"  # Path to your TLS certificate
  tls_key_file  = "/vault/config/certs/vault.key" # Path to your TLS key
  # Comment the above lines to enable TLS in development mode
  tls_disable = 0 # Set to 1 to disable TLS for development purposes
}


# Enable the Vault secrets engine
seal "awskms" {}

# Set Vault to be initialized
disable_mlock = true
