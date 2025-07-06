resource "aws_cloudwatch_log_group" "api" {
  name              = "/ecs/mazy-video-tools-api"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "frontend" {
  name              = "/ecs/mazy-video-tools-frontend"
  retention_in_days = 7
}