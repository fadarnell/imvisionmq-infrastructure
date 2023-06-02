module "iam-user-cicd" {
  source  = "cloudposse/iam-system-user/aws"
  version = "1.1.0"

  name        = "cicd"
  ssm_enabled = false
  namespace   = var.project
  stage       = var.environment
  tags        = var.tags
}

data "aws_iam_policy_document" "ecs-iam-policy-deployer" {
  statement {
    actions = [
      "iam:PassRole",
      "ecs:*",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "ecs-iam-policy-deployer" {
  name   = "${var.environment}-ECSDeployer"
  path   = "/"
  policy = data.aws_iam_policy_document.ecs-iam-policy-deployer.json
}

data "aws_iam_policy_document" "ecr-iam-policy-power-user" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:DescribeImages",
      "ecr:BatchGetImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "ecr-iam-policy-power-user" {
  name   = "${var.environment}-ECRPowerUser"
  path   = "/"
  policy = data.aws_iam_policy_document.ecr-iam-policy-power-user.json
}

resource "aws_iam_user_policy_attachment" "cicd-ecr-iam-policy-power-user-attach" {
  user       = module.iam-user-cicd.user_name
  policy_arn = aws_iam_policy.ecr-iam-policy-power-user.arn
}

resource "aws_iam_user_policy_attachment" "cicd-ecs-iam-policy-deployer-attach" {
  user       = module.iam-user-cicd.user_name
  policy_arn = aws_iam_policy.ecs-iam-policy-deployer.arn
}
