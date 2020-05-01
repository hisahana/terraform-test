resource "aws_efs_file_system" "efs" {
  creation_token                  = "fargate-efs"
  provisioned_throughput_in_mibps = "50"
  throughput_mode                 = "provisioned"

  tags = {
    Name = "fargate-efs"
  }
}

resource "aws_efs_mount_target" "public1" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.public1.id
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "aws_efs_mount_target" "public2" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_subnet.public2.id
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "aws_security_group" "efs" {
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 2049
    protocol = "tcp"
    to_port = 2049
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
