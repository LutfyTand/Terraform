provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_s3_bucket" "lutung" {
  bucket = "${var.aws_s3_bucket}"
  acl = "${var.aws_s3_acl}"

  versioning {
    enabled = true
  }

  tags = {
    Name = "devops-terraform"
  }

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Deny",
          "Principal": "*",
          "Action": [
              "s3:DeleteObjectVersion",
              "s3:DeleteObjectVersionTagging"
          ],
          "Resource": "arn:aws:s3:::${var.aws_s3_bucket}/*"
      },
      {
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::${var.aws_s3_bucket}/*"
      }
  ]
}
POLICY
}