provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "instance" {
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  key_name = "${var.key_name}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_id = "${var.subnet_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  count = "${var.instance_count}"
  root_block_device {
    volume_type           = "${var.volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.delete_on_termination}"
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
  }
  tags {
    Name = "${var.tags["Name"]}"
    Purpose = "${var.tags["Purpose"]}"
    Env = "${var.tags["Env"]}"
  }
  volume_tags {
    Name = "${var.tags["Name"]}"
    Purpose = "${var.tags["Purpose"]}"
    Env = "${var.tags["Env"]}"
  }

  

   provisioner "remote-exec" {
        inline = [
            "sudo apt-get update",
            "sudo apt-get install -y python ansible ",
            "${var.install_ec2}"      
        ]

        connection {
            type = "ssh"
            user = "ubuntu"
            private_key = "${file("/home/ubuntu/terraform/key.pem")}"

        }
    }
 

}
