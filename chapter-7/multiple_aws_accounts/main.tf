data "aws_region" "region_1" {
  provider = aws.region_1
}

data "aws_region" "region_2" {
  provider = aws.region_2
}

data "aws_ami" "ubuntu_region_1" {
  provider    = aws.region_1
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

data "aws_ami" "ubuntu_region_2" {
  provider    = aws.region_2
  most_recent = true
  owners      = ["099720109477"] # Canonical
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

resource "aws_instance" "region_1" {
  provider      = aws.region_1
  ami           = var.ami_id_region_1
  instance_type = var.instance_type
}

resource "aws_instance" "region_1_ubuntu" {
  provider      = aws.region_1
  ami           = data.aws_ami.ubuntu_region_1.id
  instance_type = "t2.micro"
}

resource "aws_instance" "region_2" {
  provider      = aws.region_2
  ami           = var.ami_id_region_2
  instance_type = var.instance_type
}

resource "aws_instance" "region_2_ubuntu" {
  provider      = aws.region_2
  ami           = data.aws_ami.ubuntu_region_2.id
  instance_type = "t2.micro"
}
