locals {
  container_env_frontend = [
    { name = "API_URL", value = var.api_url },
    { name = "NEXTAUTH_URL", value = var.nextauth_url },
    { name = "NEXTAUTH_SECRET", value = var.nextauth_secret },
    { name = "COGNITO_USER_POOL_ID", value = aws_cognito_user_pool.users.id },
    { name = "COGNITO_CLIENT_ID", value = aws_cognito_user_pool_client.frontend.id },
    { name = "COGNITO_CLIENT_SECRET", value = aws_cognito_user_pool_client.frontend.client_secret },
    { name = "COGNITO_DOMAIN", value = aws_cognito_user_pool_domain.domain.domain },
    { name = "COGNITO_ISSUER", value = local.cognito_issuer_uri },
    { name = "AWS_REGION", value = var.region },
    { name = "SENTRY_DSN", value = var.frontend_sentry_dsn }
  ]
}

resource "aws_ecs_task_definition" "frontend" {
  family                   = "mazy-video-tools-frontend"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  task_role_arn            = data.aws_iam_role.task_exec.arn
  execution_role_arn       = data.aws_iam_role.task_exec.arn

  container_definitions = jsonencode([
    {
      name      = "mazy-video-tools-frontend"
      image     = "${aws_ecr_repository.frontend.repository_url}:latest"
      essential = true
      portMappings = [
        {
          protocol      = "tcp"
          containerPort = 3000
          hostPort      = 3000
        }
      ]
      environment = local.container_env_frontend
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.frontend.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "frontend"
        }
      }
    }
  ])

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}

resource "aws_ecs_service" "frontend" {
  name            = "mazy-video-tools-frontend"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.frontend.arn
  desired_count   = 1

  network_configuration {
    subnets          = aws_subnet.private[*].id
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "mazy-video-tools-frontend"
    container_port   = 3000
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

  depends_on = [aws_lb_listener.https]
}
