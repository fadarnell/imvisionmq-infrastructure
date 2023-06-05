provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group_rule" "example" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = "sg-123456"
}

module "task" {
  source = "../../"

  name                 = "task"
  project              = "example"
  environment          = "test"
  container_image      = "nginx"
  container_port       = 80
  logs_region          = "us-east-1"
  ecs_cluster_arn      = ""
  vpc_id               = ""
  subnet_ids           = []
  security_group_ids   = []
  security_group_rules = [aws_security_group_rule.example]
}
