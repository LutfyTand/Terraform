provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "lutung" {
  ami = "${var.ec2_ami}"
  instance_type = "${var.ec2_instance_type}"
  key_name = "${var.aws_key_name}"
  vpc_security_group_ids = ["${var.ec2_security_group_ids}"]
  subnet_id = "${var.ec2_subnet_id}"
  associate_public_ip_address = "${var.ec2_associate_public_ip_address}"
  count = "${var.ec2_instance_count}"
  root_block_device {
    volume_type           = "${var.ec2_volume_type}"
    volume_size           = "${var.ec2_root_volume_size}"
    delete_on_termination = "${var.ec2_delete_on_termination}"
  }
  tags = {
    Name = "${var.ec2_name}"
    Cost = "terraform"
    Env = "dev"
  }
  volume_tags = {
    Name = "${var.ec2_name}"
    Cost = "terraform"
    Env = "dev"
  }
  provisioner "remote-exec" {
      inline = [
          "sudo apt-get update",
          "${var.ec2_install_ec2}",
          "sudo hostnamectl set-hostname ${var.ec2_name}"     
      ]

      connection {
          type = "ssh"
          user = "${var.ec2_user}"
          private_key = "${file("${var.aws_private_key_location}")}"
          host = self.public_ip
      }
  }
}