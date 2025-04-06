terraform {
  backend "s3" {
    bucket                      = "terraform-state-b-homelab"
    key                         = "terraform.tfstate"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}