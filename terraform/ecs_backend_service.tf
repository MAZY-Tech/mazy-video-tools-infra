locals {
  container_env_backend = [
    { name = "AWS_REGION", value = var.region },
    { name = "UPLOAD_BUCKET_NAME", value = var.upload_bucket_name },
    { name = "COGNITO_ISSUER_URI", value = local.cognito_issuer_uri }
  ]
}

resource "aws_ecs_task_definition" "backend" {
  family                   = "mazy-video-tools"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 512
  memory                   = 1024
  task_role_arn            = data.aws_iam_role.task_exec.arn
  execution_role_arn       = data.aws_iam_role.task_exec.arn

  container_definitions = jsonencode([
    {
      name      = "mazy-video-tools"
      image     = "${aws_ecr_repository.backend.repository_url}:latest"
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 8080
          hostPort      = 8080
        }
      ]
      environment = local.container_env_backend
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.backend.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "backend"
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "backend" {
  name            = "mazy-video-tools"
  cluster         = aws_ecs_cluster.main.id
  desired_count   = 1
  task_definition = aws_ecs_task_definition.backend.arn

  network_configuration {
    subnets          = aws_subnet.private[*].id
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_tg.arn
    container_name   = "mazy-video-tools"
    container_port   = 8080
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  depends_on = [aws_lb_listener.https]
}
