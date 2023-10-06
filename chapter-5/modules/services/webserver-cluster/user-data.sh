#!/bin/bash

# Use this for your user data (script from top to bottom)
# install httpd (Amazon Linux 2023)                
dnf update -y
dnf install -y httpd.x86_64

#change httpd default port
port=${server_port}
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

cat > /var/www/html/index.html <<EOF
<h1>Hello world from $(hostname -f)</h1>
<p>Server port: ${server_port}</p>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF