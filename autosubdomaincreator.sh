#!/bin/bash
read -p "First part of IP (192): " ip1
read -p "Second part of IP (168): " ip2
read -p "Third part of IP (1): " ip3
read -p "Last part of IP (1): " ip4
while true; do
		echo "Press ctrl + c to finish"
		read -p "Enter Subdomain (example.com): " domain
		read -p "Enter Subdomain type (Example: www/ntp/mail/any): " jsubdo
		echo -e "$jsubdo	IN	A	$ip1.$ip2.$ip3.$ip4" | tee -a /etc/bind/$fw
		echo -e "$ip4	IN	PTR	$jsubdo.$domain." | tee -a /etc/bind/$rv
done