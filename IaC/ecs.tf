# Cluster ECS
resource "aws_ecs_cluster" "PRD-GENERAL" {
  name = "PRD-GENERAL"
}

# Role para a ECS
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      }
      Effect = "Allow"
      Sid    = ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Task definition
resource "aws_ecs_task_definition" "PRD-BMD" {
  family                   = "PRD-BMD"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name      = "PRD-BMD"
    image     = "961341509182.dkr.ecr.us-east-1.amazonaws.com/meu_app_tectoy:2.7"
    essential = true
    portMappings = [{
      containerPort = 80
      hostPort      = 80
      protocol      = "tcp"
    }]
    execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  }])
}

# Serviço ECS
resource "aws_ecs_service" "PRD-BMD" {
  name            = "PRD-BMD"
  cluster         = aws_ecs_cluster.PRD-GENERAL.id
  task_definition = aws_ecs_task_definition.PRD-BMD.id
  desired_count   = 5
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.subnet01.id, aws_subnet.subnet02.id]
    security_groups  = [aws_security_group.allow_http_https_ssh.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.TG-PRD-BMD.arn
    container_name   = "PRD-BMD"
    container_port   = 80
  }
}
