data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "default" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = ["arn:aws:logs:*:*:*"]
  }
}

data "aws_iam_policy" "AWSLambdaVPCAccessExecutionRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

module "label" {
  source     = "git::https://github.com/cloudposse/terraform-terraform-label.git?ref=0.8.0"
  namespace  = var.namespace
  name       = var.name
  stage      = var.stage
  delimiter  = var.delimiter
  attributes = compact(concat(var.attributes, ["lambda"]))
  tags       = var.tags
  enabled    = "true"
}

locals {
  function_name       = module.label.id
  lambda_zip_filename = "${path.module}/lambda.zip"
}

resource "aws_iam_role" "default" {
  name               = local.function_name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  tags               = module.label.tags
}

resource "aws_iam_role_policy" "default" {
  name   = local.function_name
  role   = aws_iam_role.default.name
  policy = data.aws_iam_policy_document.default.json
}

resource "aws_iam_role_policy_attachment" "vpc-execution-role-policy-attach" {
  count      = var.vpc_mode_enable == true ? 1 : 0
  role       = aws_iam_role.default.name
  policy_arn = data.aws_iam_policy.AWSLambdaVPCAccessExecutionRole.arn
}

data "archive_file" "lambda" {
  type        = "zip"
  source_dir  = var.path_to_lambda_dir
  output_path = local.lambda_zip_filename
}

resource "aws_cloudwatch_log_group" "default" {
  name              = "/aws/lambda/${local.function_name}"
  tags              = module.label.tags
  retention_in_days = var.log_retention
}

resource "aws_lambda_function" "default" {
  filename         = local.lambda_zip_filename
  function_name    = local.function_name
  description      = local.function_name
  runtime          = "nodejs18.x"
  role             = aws_iam_role.default.arn
  handler          = "index.handler"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  tags             = module.label.tags
  timeout          = var.timeout
  memory_size      = var.memory_size

  dynamic "vpc_config" {
    for_each = var.vpc_mode_enable == true ? [var.vpc_config] : []
    content {
      subnet_ids         = vpc_config.value["subnet_ids"]
      security_group_ids = vpc_config.value["security_group_ids"]
    }
  }

  environment {
    variables = var.env_variables
  }

  depends_on = [
    aws_cloudwatch_log_group.default,
    aws_iam_role_policy.default,
  ]
}

resource "aws_lambda_alias" "default" {
  name             = "default"
  description      = "Use latest version as default"
  function_name    = aws_lambda_function.default.function_name
  function_version = "$LATEST"
}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.default.arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.default.arn
}

resource "aws_cloudwatch_event_rule" "default" {
  name                = local.function_name
  description         = local.function_name
  tags                = module.label.tags
  schedule_expression = var.schedule_expression
}

resource "aws_cloudwatch_event_target" "default" {
  target_id = local.function_name
  rule      = aws_cloudwatch_event_rule.default.name
  arn       = aws_lambda_function.default.arn
}
