# store the terraform state file in s3 and lock with dynamodb

terraform {
  backend "s3" {
    bucket         = var.s3_bucket
    key            = "red-ecs/terraform.tfstate"
    region         = var.region
    profile        = "default"
    dynamodb_table = "terraform-state-lock"
  }
}
