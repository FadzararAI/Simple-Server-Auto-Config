#!/bin/bash
read -p "Your Domain name (www.example.com): " domain
read -p "Your Webmail: " mail
echo "Give the name of the folder for the apache directory /var/www/html/directory_name"
read -p "DocumentRoot Location: /var/www/html/directory_name: " droot
cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/$domain.conf
sed -i "s/#ServerName www.example.com/ServerName $domain/" /etc/apache2/sites-enabled/$domain.conf
sed -i "s/ServerAdmin webmaster@localhost/ServerAdmin $mail@$domain/" /etc/apache2/sites-enabled/$domain.conf
sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/$droot/" /etc/apache2/sites-enabled/$domain.conf
mkdir /var/www/html/$droot
