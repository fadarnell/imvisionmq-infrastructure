# Administrator access

locals {
  tags = merge(
    var.tags,
    {
      "Provisioned-By" = "Miquido-IAM-Roles"
    },
  )
  role_admin                         = "${var.roles_prefix}AdministratorAccess"
  role_readonly                      = "${var.roles_prefix}ReadOnlyAccess"
  role_alexa                         = "${var.roles_prefix}AlexaDeveloper"
  role_superadmin                    = "${var.roles_prefix}SuperAdministratorAccess"
  role_analyst                       = "${var.roles_prefix}Analyst"
  policy_deny_ct_write               = "${var.policies_prefix}DenyCloudTrailWrite"
  policy_cloud_formation_full_access = "${var.policies_prefix}CloudFormationFullAccess"
  policy_iam_power_access            = "${var.policies_prefix}IAMRolePowerAccess"
  policy_serveless_repo_full_access  = "${var.policies_prefix}ServerLessRepoFullAccess"
}

data "aws_iam_policy_document" "assume_role_policy" {
  version = "2012-10-17"

  statement {
    sid     = "AllowAssumeRole"
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = var.principals
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = ["true"]
    }

    dynamic "condition" {
      for_each = var.assume_role_mfa_enabled ? ["true"] : []
      content {
        test     = "Bool"
        variable = "aws:MultiFactorAuthPresent"
        values   = [condition.value]
      }
    }

    dynamic "condition" {
      for_each = var.assume_role_external_id == "" ? [] : [var.assume_role_external_id]
      content {
        test     = "StringEquals"
        variable = "sts:ExternalId"
        values   = [condition.value]
      }
    }
  }
}

resource "aws_iam_role" "super-administrator-access" {
  count                = var.role_superadmin_enabled ? 1 : 0
  name                 = local.role_superadmin
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

resource "aws_iam_role" "administrator-access" {
  count                = var.role_admin_enabled ? 1 : 0
  name                 = local.role_admin
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "administrator-access" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_role_policy_attachment" "administrator-access-attach" {
  count      = var.role_admin_enabled ? 1 : 0
  role       = aws_iam_role.administrator-access[0].name
  policy_arn = data.aws_iam_policy.administrator-access.arn
}

resource "aws_iam_role_policy_attachment" "super-administrator-access-attach" {
  count      = var.role_superadmin_enabled ? 1 : 0
  role       = aws_iam_role.super-administrator-access[0].name
  policy_arn = data.aws_iam_policy.administrator-access.arn
}

data "aws_iam_policy_document" "deny-ct-write" {
  statement {
    effect = "Deny"
    actions = [
      "cloudtrail:PutEventSelectors",
      "cloudtrail:StopLogging",
      "cloudtrail:AddTags",
      "cloudtrail:DeleteTrail",
      "cloudtrail:UpdateTrail",
      "cloudtrail:RemoveTags",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "deny-ct-write" {
  count  = var.role_admin_enabled ? 1 : 0
  name   = local.policy_deny_ct_write
  policy = data.aws_iam_policy_document.deny-ct-write.json
}

resource "aws_iam_role_policy_attachment" "deny-ct-write-attach" {
  count      = var.role_admin_enabled ? 1 : 0
  role       = aws_iam_role.administrator-access[0].name
  policy_arn = aws_iam_policy.deny-ct-write[0].arn
}

# Read only access

resource "aws_iam_role" "readonly-access" {
  count                = var.role_readonly_enabled ? 1 : 0
  name                 = local.role_readonly
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "readonly-access" {
  arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy_attachment" "readonly-access-attach" {
  count      = var.role_readonly_enabled ? 1 : 0
  role       = aws_iam_role.readonly-access[0].name
  policy_arn = data.aws_iam_policy.readonly-access.arn
}

# Analyst

resource "aws_iam_role" "analyst-access" {
  count                = var.role_analyst_enabled ? 1 : 0
  name                 = local.role_analyst
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "athena-full-access" {
  arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

resource "aws_iam_role_policy_attachment" "analyst-readonly-access-attach" {
  count      = var.role_analyst_enabled ? 1 : 0
  role       = aws_iam_role.analyst-access[0].name
  policy_arn = data.aws_iam_policy.readonly-access.arn
}

resource "aws_iam_role_policy_attachment" "analyst-athena-full-access-attach" {
  count      = var.role_analyst_enabled ? 1 : 0
  role       = aws_iam_role.analyst-access[0].name
  policy_arn = data.aws_iam_policy.athena-full-access.arn
}

# Alexa developer

resource "aws_iam_role" "alexa-developer" {
  count                = var.role_alexa_enabled ? 1 : 0
  name                 = local.role_alexa
  tags                 = local.tags
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.roles_max_session_duration
  description          = "Role used by Miquido to assume access"
}

data "aws_iam_policy" "lex-full-access" {
  arn = "arn:aws:iam::aws:policy/AmazonLexFullAccess"
}

data "aws_iam_policy" "alexa-full-access" {
  arn = "arn:aws:iam::aws:policy/AlexaForBusinessFullAccess"
}

data "aws_iam_policy" "lambda-full-access" {
  arn = "arn:aws:iam::aws:policy/AWSLambda_FullAccess"
}

data "aws_iam_policy_document" "cloudformation-full-access" {
  statement {
    effect = "Allow"
    actions = [
      "cloudformation:Describe*",
      "cloudformation:EstimateTemplateCost",
      "cloudformation:Get*",
      "cloudformation:List*",
      "cloudformation:ValidateTemplate",
      "cloudformation:DetectStackDrift",
      "cloudformation:DetectStackResourceDrift",
      "cloudformation:CreateChangeSet",
      "cloudformation:ExecuteChangeSet",
      "cloudformation:DeleteStack",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cloudformation-full-access" {
  count  = var.role_alexa_enabled ? 1 : 0
  name   = local.policy_cloud_formation_full_access
  policy = data.aws_iam_policy_document.cloudformation-full-access.json
}

data "aws_iam_policy_document" "iam-role-power-access" {
  statement {
    effect = "Allow"
    actions = [
      "iam:CreateRole",
      "iam:DeleteRole",
      "iam:TagRole",
      "iam:UntagRole",
      "iam:UpdateRole",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "iam-role-power-access" {
  count  = var.role_alexa_enabled ? 1 : 0
  name   = local.policy_iam_power_access
  policy = data.aws_iam_policy_document.iam-role-power-access.json
}

data "aws_iam_policy_document" "serverlessrepo-full-access" {
  statement {
    effect = "Allow"
    actions = [
      "serverlessrepo:*",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "serverlessrepo-full-access" {
  count  = var.role_alexa_enabled ? 1 : 0
  name   = local.policy_serveless_repo_full_access
  path   = "/"
  policy = data.aws_iam_policy_document.serverlessrepo-full-access.json
}

resource "aws_iam_role_policy_attachment" "alexa-developer-alexa-full-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = data.aws_iam_policy.alexa-full-access.arn
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lex-full-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = data.aws_iam_policy.lex-full-access.arn
}

resource "aws_iam_role_policy_attachment" "alexa-developer-lambda-full-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = data.aws_iam_policy.lambda-full-access.arn
}

resource "aws_iam_role_policy_attachment" "alexa-developer-serverlessrepo-full-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = aws_iam_policy.serverlessrepo-full-access[0].arn
}

resource "aws_iam_role_policy_attachment" "alexa-developer-cloudformation-full-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = aws_iam_policy.cloudformation-full-access[0].arn
}

resource "aws_iam_role_policy_attachment" "alexa-developer-iam-role-power-access-attach" {
  count      = var.role_alexa_enabled ? 1 : 0
  role       = aws_iam_role.alexa-developer[0].name
  policy_arn = aws_iam_policy.iam-role-power-access[0].arn
}
