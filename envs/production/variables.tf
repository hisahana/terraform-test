variable "name" {
  description = "Environment name."
  default = "production"
}

variable "region" {
  description = "AWS region to launch servers."
  default     = "ap-southeast-1"
}

variable "availability_zone_1" {
  description = "Availability Zone 1."
  default     = "ap-southeast-1a"
}

variable "availability_zone_2" {
  description = "Availability Zone 1."
  default     = "ap-southeast-1c"
}
