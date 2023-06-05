variable "principals" {
  type        = list(string)
  description = "List of AWS Prinicpals to allow assuming created IAM roles (https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_principal.html)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags to apply on all created resources"
}

variable "roles_prefix" {
  type        = string
  default     = ""
  description = "Prefix added to created roles"
}

variable "roles_max_session_duration" {
  type        = number
  default     = 3600
  description = " The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "policies_prefix" {
  type        = string
  default     = ""
  description = "Prefix added to created roles"
}

variable "assume_role_mfa_enabled" {
  type        = bool
  default     = true
  description = "Whether to require MFA to assume enabled roles. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-mfa"
}

variable "assume_role_external_id" {
  type        = string
  default     = ""
  description = "Specify external ID required to assume enabled roles. Disabled if empty. See: https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html#cli-configure-role-xaccount"
}

variable "role_admin_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable AdministratorAccess IAM Role"
}

variable "role_superadmin_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable SuperAdministratorAccess IAM Role (Administrator with ability to manage CloudTrail)"
}

variable "role_readonly_enabled" {
  type        = bool
  default     = true
  description = "Whether to enable ReadOnlyAccess IAM Role"
}

variable "role_alexa_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable AlexaDeveloper IAM Role"
}

variable "role_analyst_enabled" {
  type        = bool
  default     = false
  description = "Whether to enable Analyst IAM Role (ReadOnly + AmazonAthenaFullAccess)"
}
