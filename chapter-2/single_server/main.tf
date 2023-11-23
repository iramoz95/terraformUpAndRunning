resource "aws_instance" "example" {
  ami           = "ami-04cb4ca688797756f" #Amazon Linux 2023 
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }

}
