provider "aws" {
  region = var.region
  profile = "sero-terraform"
}

module "common" {
  source = "../../modules/common"

  name = var.name
}
