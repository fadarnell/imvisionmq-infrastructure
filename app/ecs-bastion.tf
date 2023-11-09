module "ecs-bastion" {
  count             = var.bastion_enabled == true ? 1 : 0
  source            = "git::ssh://git@gitlab.com/miquido/terraform/ecs-bastion.git?ref=tags/1.1.46"
  aws_region        = var.aws_region
  ecs_cluster_arn   = aws_ecs_cluster.main.arn
  environment       = var.environment
  project           = var.project
  route53_zone_id   = aws_route53_zone.app_domain.id
  public_ssh_keys   = <<EOT
                        ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDc8M6xbf7pftaEp0G4+Ta40DtX7bNRegvUjB0fua4qi1ol7M+Yr1JPFVfb7y06/KQGOwB/VzRF8BIixRUEPuws= dawid.orzel@miquido.com
                        ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCu57HaCCmKGRs4J3Fn1+oPGhRKQkKs9R0vRCJowlSohmpQo+1DdQZqIBJaprAP6NWQLSnmZnA+aMPHsewwu9AU63G2T4YTsBpsaGUizJOH/reEKpKdHi+qDPlAIbgXK7vTbs8EmBjZCILADpmn8fDyy3GkkYVAFDURIVFDOWBT6fmG1fUOo0nWgagJbM4xVkr/LaL3OqO6zvcQ/TbVeCUTXo3qpYORT1GdE+1PJ9+0m2BWakJHvTVGbH1xS0l8Uf3lHJky5UGsiIyeqT29mp1RjdXRSdi4J+ZPje4K5iOoxxQOKZhJSCRwxL7nJ9Nr0XttCvv0dJuLNsFqqGkfQ3yZkmNDu4bi7KrlToGCgmdNNVrR1gxW6Cl0d01DbTHmWHeGP3AWZWb4dqNhcC1SQONE89M3Mr+Xsq8Q4QdmUbPyQb6vRRdDHkSAIIa53Gn96hYeB5WVNUMCEbLApc67efhzRPDsdlO6rbpK2+QWrb6ZmjLT8S3UUdUuKeGeJ5EciH8= andmal@MacBook-Pro-And.local
    EOT
  public_subnet_ids = module.vpc.public_subnet_ids
  security_groups   = [module.vpc.vpc_main_security_group_id]
  vpc_id            = module.vpc.vpc_id
  web_domain        = "bastion.${local.app_domain}"
  whitelist_ips = [
    {
      description = "Miquido - Office",
      cidr        = "78.11.41.128/29",
    },
    {
      description = "Miquido - Office - 2",
      cidr        = "80.82.16.48/29",
    }
  ]

  auto_deploy_new_task_versions = true
  tags                          = var.tags
}