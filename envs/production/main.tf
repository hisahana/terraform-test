provider "aws" {
  region = var.region
  profile = "sero-terraform"
}

module "common" {
  source = "../../modules/common"

  name = var.name
  avarability_zone_1 = var.availability_zone_1
  avarability_zone_2 = var.availability_zone_2
}
