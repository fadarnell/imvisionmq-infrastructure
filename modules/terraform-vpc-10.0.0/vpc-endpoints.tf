#####################################
# VPC Endpoints S3, ECR API, ECR DKR
#####################################

data "aws_vpc_endpoint_service" "s3" {
  service      = "s3"
  service_type = "Gateway"
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id              = module.vpc.vpc_id
  service_name        = data.aws_vpc_endpoint_service.s3.service_name
  vpc_endpoint_type   = "Gateway"
  private_dns_enabled = false
  tags                = var.tags
  route_table_ids     = flatten([module.vpc.vpc_main_route_table_id, module.dynamic-subnets.public_route_table_ids, module.dynamic-subnets.private_route_table_ids])

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect    = "Allow"
        Principal = "*"
        Resource  = "*"
      },
    ]
  })
}

data "aws_vpc_endpoint_service" "ecr-dkr" {
  service = "ecr.dkr"
}

data "aws_vpc_endpoint_service" "ecr-api" {
  service = "ecr.api"
}

data "aws_vpc_endpoint_service" "cloudwatch" {
  service = "logs"
}

resource "aws_vpc_endpoint" "cloudwatch" {
  count = var.enable_ecs_fargate_private_link ? 1 : 0

  vpc_id              = module.vpc.vpc_id
  service_name        = data.aws_vpc_endpoint_service.cloudwatch.service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = module.dynamic-subnets.private_subnet_ids
}

resource "aws_vpc_endpoint" "ecr-api" {
  count = var.enable_ecs_fargate_private_link ? 1 : 0

  vpc_id              = module.vpc.vpc_id
  service_name        = data.aws_vpc_endpoint_service.ecr-api.service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = module.dynamic-subnets.private_subnet_ids
}

resource "aws_vpc_endpoint" "ecr-dkr" {
  count = var.enable_ecs_fargate_private_link ? 1 : 0

  vpc_id              = module.vpc.vpc_id
  service_name        = data.aws_vpc_endpoint_service.ecr-dkr.service_name
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = module.dynamic-subnets.private_subnet_ids
}
