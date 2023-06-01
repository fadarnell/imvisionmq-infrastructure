# imvisionmq-infrastructure

# Info
Terraform files for IMvisionMQ AWS infrastructure.

## Requirements
Terraform requires `GITLAB_TOKEN` with API privileges. It automatically setup Environment variables in gitlab repositories.

`GITLAB_TOKEN` is the GitLab personal access token. It must be provided every time terraform runs, but it can also be sourced from the `GITLAB_TOKEN` environment variable.

## Usage

`export GITLAB_TOKEN=value`

-----------------------------

`terraform init`

`terraform validate`

`terraform plan`

`terraform apply`
