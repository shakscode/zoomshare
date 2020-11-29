#!/bin/bash

#consists to install and config nginx reverse proxy

# function to install nginx
Install_nginx () { 
  yum install -y nginx
  }
   

#function to config nginx

config_nginx () {
  mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.ori.bkp

echo '

upstream PROTON {

  server proton1:443 max_fails=5  fail_timeout=300;
  server proton2:443 max_fails=5  fail_timeout=300;
  server protonn:443 max_fails=5  fail_timeout=300;
  
  }

server {
	listen              443 ssl http2;
	server_name         localhost;
	ssl_certificate     PROTON.crt;
	ssl_certificate_key PROTON.key;
	ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers         HIGH:!aNULL:!MD5;
	location /tritium/ {
		proxy_pass http://PROTON:8080/tritium/;
		proxy_buffering off;
		proxy_http_version 1.1;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection $http_connection;
		proxy_cookie_path /tritium/ /tritium/;
		access_log off;
    }

}' > /etc/nginx/conf.d/PROTON.conf 

###selfsigned cert config 

  openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/PROTON.key -out /etc/nginx/PROTON.crt
  systemctl enable nginx
  systemctl start nginx
  
  }

Install_nginx
config_nginx
#
