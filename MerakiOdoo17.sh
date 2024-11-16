#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo adduser -system -home=/opt/odoo -group odoo
sudo apt-get install postgresql -y
sudo su - postgres -c "createuser -s odoo" 2> /dev/null || true
sudo apt-get install git python3 python3-pip build-essential wget python3-dev python3-venv python3-wheel libxslt-dev libzip-dev libldap2-dev libsasl2-dev python3-setuptools node-less libjpeg-dev gdebi -y
sudo apt-get install libpq-dev python-dev libxml2-dev libxslt1-dev libldap2-dev libsasl2-dev libffi-dev 
sudo apt-get install nodejs npm -y
sudo npm install -g rtlcss
sudo apt-get install xfonts-75dpi
sudo wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.bionic_amd64.deb
sudo dpkg -i wkhtmltox_0.12.6-1.bionic_amd64.deb
sudo cp /usr/local/bin/wkhtmltoimage /usr/bin/wkhtmltoimage
sudo cp /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
sudo mkdir /var/log/odoo
sudo chown odoo:odoo /var/log/odoo
sudo apt-get install git
sudo git clone --depth 1 --branch 17.0 https://www.github.com/odoo/odoo /odoo/odoo-server
sudo chown -R odoo:odoo /odoo/*
sudo touch /etc/odoo-server.conf
sudo su root -c "printf 'admin_passwd = admin\n' >> /etc/odoo-server.conf"
sudo su root -c "printf 'xmlrpc_port = 8069\n' >> /etc/odoo-server.conf"
sudo su root -c "printf 'logfile = /var/log/odoo/odoo-server.log\n' >> /etc/odoo-server.conf"
sudo su root -c "printf 'addons_path=/odoo/odoo-server/addons\n' >> /etc/odoo-server.conf"
sudo chown odoo:odoo /etc/odoo-server.conf
sudo chmod 640 /etc/odoo-server.conf
sudo su - odoo -s /bin/bash
cd /odoo/odoo-server 
./odoo-bin -c /etc/odoo-server.conf 
systemctl stop apache2
apt-get purge apache2*
apt autoremove
sudo apt-get update
sudo apt-get install nginx
sudo service nginx start
systemctl restart odoo
service nginx restart