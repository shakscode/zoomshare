#!/bin/bash
yum install -y httpd
mkdir -p /var/www/tritium/proton.html
chmod -R 755 /var/www/
echo "hey, I am $(hostname -f) tritum" > /var/www/tritium/proton.html
systemctl start httpd
systemctl enable httpd
