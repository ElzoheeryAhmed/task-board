data "http" "myip" {
  url = "https://ipv4.icanhazip.com"

  lifecycle {
    postcondition {
      condition     = self.status_code == 200
      error_message = "Could not fetch public IP from icanhazip.com."
    }
  }
}
