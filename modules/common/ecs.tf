resource "aws_ecs_cluster" "app_cluster" {
  name = "app-cluster"
}

resource "aws_ecs_task_definition" "app_task" {
  container_definitions = file("${path.module}/container_definitions.json")
  family = "app-task"
  cpu = "256"
  memory = "512"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  volume {
    name = "fargate-efs"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.efs.id
      root_directory = "/"
    }
  }
}

resource "aws_ecs_service" "app" {
  name = "app-server"
  cluster = aws_ecs_cluster.app_cluster.arn
  task_definition = aws_ecs_task_definition.app_task.arn
  desired_count = 2
  launch_type = "FARGATE"
  platform_version = "1.4.0"
  #health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = true
    security_groups = [
      aws_security_group.web.id
    ]

    subnets = [
      aws_subnet.public1.id,
      aws_subnet.public2.id
    ]
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}
