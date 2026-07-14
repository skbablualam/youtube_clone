terraform {

  backend "s3" {

    bucket         = "bablu-youtube-clone-terraform-state-2026"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "youtube-clone-terraform-lock"

    encrypt = true

  }

}