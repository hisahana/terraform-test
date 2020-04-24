terraform {
  backend "s3" {
    bucket = "sero-terraform-test-bucket"
    key = "production.tfstate"
    region = "ap-southeast-1"
    profile = "sero-terraform"
  }
}
