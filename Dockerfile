FROM hashicorp/vault:latest

# Optional: Copy your Vault config and certs into the image
COPY vault-config/ /vault/config/

# If using entrypoint script or plugin:
# COPY scripts/start.sh /usr/local/bin/start.sh
# RUN chmod +x /usr/local/bin/start.sh

# ENTRYPOINT ["/usr/local/bin/start.sh"]
