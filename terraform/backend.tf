terraform {
  backend "s3" {
    bucket       = "k3s-tfstate-munirih-1862026"
    key          = "k3s-infrastructure/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}

