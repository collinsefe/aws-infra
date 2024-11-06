terraform {

  backend "s3" {
    bucket = "collins-capgem-demo-05112024"
    key    = "capgem-app/infra.tfstate"
    region = "eu-west-2"
    # dynamodb_table = "CollinsDemo"
    # encrypt = false
  }

}
