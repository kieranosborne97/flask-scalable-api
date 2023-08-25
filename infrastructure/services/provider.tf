provider "aws" {
  region = "ap-southeast-2"
}

terraform {
  backend "s3" {
    # Ensure these variables are the same as in [../terraform-backend/vars.tf -> bucket + table]
    bucket         = "highly-scalable-api-terraform-backend-bucket-2"
    key            = "workspaces-example/terraform.tfstate"
    region         = "ap-southeast-2"

    dynamodb_table = "highly-scalable-api-terraform-backend-dynamo-db"
    encrypt        = true
  }
}
