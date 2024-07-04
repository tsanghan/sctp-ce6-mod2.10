locals {
  region = "ap-southeast-1"

  common_tags = {
    Name = "tsanghan-ce6"
  }

  random = {
    Name = "${random_id.server.hex}"
  }
}