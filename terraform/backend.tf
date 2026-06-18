terraform {
  backend "s3" {
    bucket         = "k3s-tfstate-munirih-1862026"
    key            = "k3s-infrastructure/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "k3s-munirih-terraform-locks"
    encrypt        = true
  }
}
