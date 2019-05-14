provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "example2" {
  bucket = "devops-lutfi-terraform"
  acl = "private"
  versioning {
    enabled = true
  }

  tags {
    Name = "devops-cilsy-lutfy"
  }

}
