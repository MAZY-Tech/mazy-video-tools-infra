resource "aws_ecr_repository" "api" {
  name = "mazy-video-tools-api"
}

resource "aws_ecr_repository" "frontend" {
  name = "mazy-video-tools-frontend"
}