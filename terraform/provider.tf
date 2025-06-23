provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project = "MAZY Video Tools"
    }
  }

}
