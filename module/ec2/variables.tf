variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "region" {
  default = "us-east-1"
}

variable "availability_zone" {
    default = "us-east-1a"
}

variable "ami" {
    default = "ami-0a313d6098716f372"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "root_volume_size" {
    default = 22
}

variable "instance_count" {
    default = 1
}

variable "delete_on_termination" {
    default = true
}

variable "volume_size" {
    default = 100
}

variable "volume_type" {
    default = "gp2"
}

variable "key_name" {
    default = "lutfi-key"
}

variable "vpc_security_group_ids" {
    default = ["sg-06a4ad15b3e4d39c9"]
}

variable "subnet_id" {
    default = "subnet-9d384fd7" 
}

variable "associate_public_ip_address" {
    default = true
}

variable "tags" {
    type = "map"
    default = {
        "name" = "devops-default"
        "purpose" = "devops-default"
        "env" = "dev"
    }
}

variable "install_ec2" {
    default = "sudo apt-get install -y python"
}
