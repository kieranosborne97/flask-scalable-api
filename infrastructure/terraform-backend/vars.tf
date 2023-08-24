variable "terraform_backend_bucket" {
  default = "highly-scalable-api-terraform-backend-bucket-2"
  description = "Must be globally unique for all S3 buckets"
}
variable "terraform_backend_dynamo_db" {
  default = "highly-scalable-api-terraform-backend-dynamo-db"
}