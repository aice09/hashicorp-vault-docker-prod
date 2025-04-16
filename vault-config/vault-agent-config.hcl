vault = "http://vault:8200"
auto_auth {
  method "approle" {
    mount_path = "auth/approle/login"
    config = {
      role_id   = "your_role_id"
      secret_id = "your_secret_id"
    }
  }
  sink "file" {
    config = {
      path = "/vault/config/vault-token"
    }
  }
}
