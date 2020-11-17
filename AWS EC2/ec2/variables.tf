variable "aws_access_key" {
    default = ""
}
variable "aws_secret_key" {
    default = ""
}
variable "aws_region" {
  default = "us-east-1"
}
variable "ec2_name"{
    default = "terraform-devops"
}
variable "ec2_user"{
    default = "ubuntu"
}
variable "availability_zone" {
    default = "us-east-1a"
}
variable "ec2_ami" {
    default = "ami-0885b1f6bd170450c"
}
variable "ec2_instance_type" {
    default = "t3.micro"
}
variable "ec2_instance_count" {
    default = 1
}
variable "subnet_id" {
    default = "subnet-9d384fd7" 
}
variable "ec2_associate_public_ip_address" {
    default = true
}
variable "ec2_volume_type" {
    default = "gp2"
}
variable "ec2_root_volume_size" {
    default = 20
}
variable "ec2_delete_on_termination" {
    default = true
}
variable "ec2_security_group_ids" {
    default = "sg-06a4ad15b3e4d39c9"
}
variable "aws_key_name" {
    default = "lutung"
}
variable "aws_private_key_location" {
    default = "../lutung.pem"
}
variable "ec2_install_ec2" {
    default = "sudo apt-get install -y nginx"
}

