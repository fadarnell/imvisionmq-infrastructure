provider "aws" {
  region = "us-east-1"
}

module "task" {
  source = "../../"

  name               = "task"
  project            = "example"
  environment        = "test"
  container_image    = "nginx"
  container_port     = 80
  logs_region        = "us-east-1"
  ecs_cluster_arn    = ""
  vpc_id             = ""
  subnet_ids         = []
  security_group_ids = []

  # container security
  readonly_root_filesystem = true
  user                     = "app:app" # 1000:1000

  # enable CPU based autoscalling
  autoscaling_enabled      = true
  autoscaling_min_capacity = 1
  autoscaling_max_capacity = 2
  ecs_alarms_enabled       = true

  # prefer FARGATE_SPOT; but allow FARGATE
  # if you wish you can set "base=1" on FARGATE provider
  # to guarantee that at least one task on FARGATE provider will be active at all times
  capacity_provider_strategies = [
    {
      capacity_provider = "FARGATE_SPOT"
      weight            = 3
      base              = null
    },
    {
      capacity_provider = "FARGATE"
      weight            = 1
      base              = null
    }
  ]

  # create ephemeral volume due to read only root filesystem
  docker_volumes = [{
    name                        = "app_tmp"
    host_path                   = "/tmp"
    docker_volume_configuration = []
  }]

  # mount "app_tmp" task volume to default container at "/tmp" path
  mount_points = [{
    sourceVolume  = "app_tmp"
    containerPath = "/tmp"
  }]
}
