resource "aws_ecr_repository" "backend" {
  name = "mazy-video-tools"
}

resource "aws_ecr_repository" "frontend" {
  name = "mazy-video-tools-frontend"
}