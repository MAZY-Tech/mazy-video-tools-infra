resource "aws_security_group" "app" {
  name        = "mazy-video-tools-sg"
  description = "Allow HTTP ingress to ALB and traffic to ECS tasks"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.allowed_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
