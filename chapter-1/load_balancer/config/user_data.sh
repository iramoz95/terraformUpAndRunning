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