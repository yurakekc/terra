provider "aws" {
 region = var.region
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "ubuntu" {
  count = 5000
  #ami                         = var.win_ami
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type1
  subnet_id     = var.subnet
  tags          = merge({ "Name" = format("y.zhuk-test -> %s -> %s", substr("🤔🤷", 0, 1), data.aws_ami.ubuntu.name) }, var.tags)
  timeouts {
    create = "9m"
    delete = "15m"
  }
}

output "sensitive" {
  sensitive = true
  value     = "VALUE"
}
/*
resource "aws_instance" "ubuntu1" {
  count = "${terraform.workspace == "default" ? 5 : 1}"

  # ... other arguments
}
*/
  

