resource "aws_instance" "example" {
  ami                    = "ami-04cb4ca688797756f" #Amazon Linux 2023 
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]
  key_name               = "dev"

  user_data = <<-EOF
    #!/bin/bash
    # Use this for your user data (script from top to bottom)
    
    # install httpd (Amazon Linux 2023)                
    dnf update -y
    dnf install -y httpd.x86_64

    #change httpd default port
    port=8080
    config_file="/etc/httpd/conf/httpd.conf"
    # Check if the configuration file exists
    if [ -f "$config_file" ]; then        
        sudo sed -i "s/Listen 80/Listen $port/" "$config_file"    
        echo "Apache port changed to $port"
    else
        echo "Apache configuration file not found."
    fi

    #start Apache
    systemctl start httpd.service
    systemctl enable httpd.service
    echo "<h1>Hello from $(hostname -f)</h1>" > /var/www/html/index.html
    EOF

  user_data_replace_on_change = true

  tags = {
    Name = "terraform-example"
  }

}


resource "aws_security_group" "instance" {
  name = "terrform-examaple-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
