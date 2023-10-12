#!/bin/bash

# Use this for your user data (script from top to bottom)
# install httpd (Amazon Linux 2023)                
dnf update -y
dnf install -y httpd.x86_64

#change httpd default port
config_file="/etc/httpd/conf/httpd.conf"
# Check if the configuration file exists
if [ -f "$config_file" ]; then        
    sudo sed -i "s/Listen 80/Listen ${server_port}/" "$config_file"    
    echo "Apache port changed to ${server_port}"
else
    echo "Apache configuration file not found."
fi

#start Apache
systemctl start httpd.service
systemctl enable httpd.service

cat > /var/www/html/index.html <<EOF
<h1>${server_text}</h1>
<h2>Hostname: $(hostname -f)</h2>
<p>Server port: ${server_port}</p>
<p>DB address: ${db_address}</p>
<p>DB port: ${db_port}</p>
EOF