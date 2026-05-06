remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket  = get_env("S3_STATE_BUCKET", "")
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
