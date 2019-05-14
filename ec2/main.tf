module "ec2" {
    source = "../module/ec2"
    instance_count = 1
    install_ec2 = "sudo apt-get install -y  docker.io"
    tags = {
        Name = "devops-lutfi-cilsy"
        Env = "development"
        Purpose = "Training"
    }
}
