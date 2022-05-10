#!/bin/bash
read -p "First part of IP (192): " ip1
read -p "Second part of IP (168): " ip2
read -p "Third part of IP (1): " ip3
read -p "Last part of IP (1): " ip4
read -p "Your Domain (example.com): " domain
read -p "Enter the name of the forward file (Example: db.forward): " fw 
read -p "Enter the name of the reverse file (Example: db.reverse): " rv
cp /etc/bind/db.local /etc/bind/$fw
cp /etc/bind/db.127 /etc/bind/$rv 
z1="zone	\"$domain\"{"
zr1="zone	\"$ip3.$ip2.$ip1.in-addr.arpa\"{"
echo -e $z1 | tee -a /etc/bind/named.conf.local
echo -e "	type master;" | tee -a /etc/bind/named.conf.local
echo -e "	file \"/etc/bind/$fw\";" | tee -a /etc/bind/named.conf.local
echo "};" | tee -a /etc/bind/named.conf.local
echo -e "\n" | tee -a /etc/bind/named.conf.local
echo -e $zr1 | tee -a /etc/bind/named.conf.local
echo -e "	type master;" | tee -a /etc/bind/named.conf.local
echo -e "	file \"/etc/bind/$rv\";" | tee -a /etc/bind/named.conf.local
echo "};" | tee -a /etc/bind/named.conf.local
sed -i "s/localhost/$domain/g" /etc/bind/$fw
sed -i "s/localhost/$domain/g" /etc/bind/$rv
sed -i "s/127.0.0.1/$ip1.$ip2.$ip3.$ip4/g" /etc/bind/$fw
sed -i "s/127.0.0.1/$ip1.$ip2.$ip3.$ip4/g" /etc/bind/$rv
sed -i "s/1.0.0/$ip4/g" /etc/bind/$rv
echo -e "nameserver $ip1.$ip2.$ip3.$ip4" >> /etc/resolv.conf
echo -e "search $domain" | tee -a /etc/resolv.conf
echo -e "domain $domain" | tee -a /etc/resolv.conf
echo -e "\n"
read -p "Want to create subdomain(s)? y/n: " opt
if [[ $opt == 'y' ]]
then
	while true; do
		echo "Press ctrl + c to finish"
		read -p "Enter Subdomain type (Example: www/ntp/mail/any): " jsubdo
		echo -e "$jsubdo	IN	A	$ip1.$ip2.$ip3.$ip4" | tee -a /etc/bind/$fw
		echo -e "$ip4	IN	PTR	$jsubdo.$domain." | tee -a /etc/bind/$rv
	done
else
	exit
fi
