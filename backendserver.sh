#!/bin/bash
yum install -y httpd
echo "hey, I am $(hostname -f)" > /var/www/html/index.html
systemctl start httpd
systemctl enable httpd
