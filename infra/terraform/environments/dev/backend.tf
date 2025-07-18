terraform {
  backend "s3" {
    bucket         = "my-terraform-states"
    key            = "dev/network/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
