resource "aws_s3_bucket" "uploads" {
  bucket        = var.upload_bucket_name
  force_destroy = true
}
