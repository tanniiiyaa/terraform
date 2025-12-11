provider "aws" {
    region = "eu-north-1"
    profile = "configs"
    shared_credentials_files = ["/home/tan/.aws/credentials"]
}