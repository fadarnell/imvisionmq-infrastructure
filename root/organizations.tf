################
# Organization #
################
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
  enabled_policy_types = [
    "SERVICE_CONTROL_POLICY"
  ]
  aws_service_access_principals = [
    "sso.amazonaws.com"
  ]
}

################
#   Accounts   #
################
resource "aws_organizations_account" "accounts_root" {
  name      = "IMvision Dental"
  email     = "fred@imvisiondental.com"
  role_name = "OrganizationAccountAccessRole"

  # There is no AWS Organizations API for reading role_name on imported accounts
  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "imvision_dev" {
  name      = "IMvision Dev"
  email     = "devops+imvision-dev@miquido.com"
  role_name = "OrganizationAccountAccessRole"

  # There is no AWS Organizations API for reading role_name on imported accounts
  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_organizations_account" "imvision_qa" {
  name      = "IMvision QA"
  email     = "awsqaowner@imvisiondental.com"
  role_name = "OrganizationAccountAccessRole"

  # There is no AWS Organizations API for reading role_name on imported accounts
  lifecycle {
    ignore_changes = [role_name]
  }
}

################
# SCP policies #
################
resource "aws_organizations_policy" "full_aws_access" {
  name        = "FullAWSAccess"
  description = "Allows access to every operation"
  type        = "SERVICE_CONTROL_POLICY"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "*",
      "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy" "deny_organization_role_removal" {
  name        = "DenyOrganizationRoleRemoval"
  description = "Deny deletion or detaching policy from OrganizationAccountAccessRole, AdministratorAccess, ReadOnlyAccess roles"
  type        = "SERVICE_CONTROL_POLICY"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Action": [
        "iam:DeleteRole",
        "iam:DeleteRolePermissionsBoundary",
        "iam:DeleteRolePolicy",
        "iam:DetachRolePolicy"
      ],
      "Resource": [
        "arn:aws:iam::*:role/OrganizationAccountAccessRole",
        "arn:aws:iam::*:role/AdministratorAccess",
        "arn:aws:iam::*:role/ReadOnlyAccess"
      ]
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy" "organizations_aws_access" {
  name        = "OrganizationsAWSAccess"
  description = ""
  type        = "SERVICE_CONTROL_POLICY"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1500980635000",
      "Effect": "Allow",
      "Action": [
        "organizations:AcceptHandshake",
        "organizations:CancelHandshake",
        "organizations:DeclineHandshake",
        "organizations:DescribeAccount",
        "organizations:DescribeCreateAccountStatus",
        "organizations:DescribeHandshake",
        "organizations:DescribeOrganization",
        "organizations:DescribeOrganizationalUnit",
        "organizations:DescribePolicy",
        "organizations:InviteAccountToOrganization",
        "organizations:LeaveOrganization",
        "organizations:ListAccounts",
        "organizations:ListAccountsForParent",
        "organizations:ListChildren",
        "organizations:ListCreateAccountStatus",
        "organizations:ListHandshakesForAccount",
        "organizations:ListHandshakesForOrganization",
        "organizations:ListOrganizationalUnitsForParent",
        "organizations:ListParents",
        "organizations:ListPolicies",
        "organizations:ListPoliciesForTarget",
        "organizations:ListRoots",
        "organizations:ListTargetsForPolicy",
        "iam:ListInstanceProfiles",
        "acm:ListCertificates",
        "iam:ListRoles",
        "iam:ListServerCertificates",
        "iam:GetRole",
        "cloudformation:ListStackResources",
        "iam:CreateRole"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy" "deny_leave_organization" {
  name        = "DenyLeaveOrganization"
  description = "This SCP denies access to LeaveOrganization option"
  type        = "SERVICE_CONTROL_POLICY"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyLeaveOrganization",
      "Effect": "Deny",
      "Action": [
        "organizations:LeaveOrganization"
      ],
      "Resource": "*"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy" "deny_all_outside_allowed_regions" {
  name        = "DenyAllOutsideEUWest"
  description = "This SCP denies access to any operations outside of the ${var.aws_region} region, except for actions in the listed services."
  type        = "SERVICE_CONTROL_POLICY"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyAllOutsideEUWest",
      "Effect": "Deny",
      "NotAction": [
        "account:*",
        "acm:*",
        "budgets:*",
        "cloudfront:*",
        "ec2:DescribeRegions",
        "ec2:DescribeTransitGateways",
        "ec2:DescribeVpnGateways",
        "globalaccelerator:*",
        "health:*",
        "iam:*",
        "importexport:*",
        "kms:*",
        "organizations:*",
        "route53:*",
        "route53domains:*",
        "s3:GetAccountPublic*",
        "s3:ListAllMyBuckets",
        "s3:PutAccountPublic*",
        "shield:*",
        "sts:*",
        "support:*",
        "trustedadvisor:*",
        "waf-regional:*",
        "waf:*",
        "wafv2:*",
        "wellarchitected:*",
        "aws-portal:ViewPaymentMethods",
        "aws-portal:ViewAccount",
        "aws-portal:ViewBilling",
        "aws-portal:ViewUsage"
      ],
      "Resource": "*",
      "Condition": {
        "StringNotEquals": {
          "aws:RequestedRegion": [
            "${var.aws_region}"
          ]
        }
      }
    }
  ]
}
CONTENT
}

#####################
# Policy attachment #
#####################
resource "aws_organizations_policy_attachment" "full_aws_access" {
  policy_id = aws_organizations_policy.full_aws_access.id
  target_id = aws_organizations_organization.org.roots.0.id
}

resource "aws_organizations_policy_attachment" "organizations_aws_access" {
  policy_id = aws_organizations_policy.organizations_aws_access.id
  target_id = aws_organizations_organization.org.roots.0.id
}

