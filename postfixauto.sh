#!/bin/bash
cp /etc/postfix/main.cf /etc/postfix/main.cf.backup
var1="home_mailbox = Maildir/"
var2="smtpd_sasl_type = dovecot"
var3="smtpd_sasl_path = private/auth"
var4="smtpd_sasl_auth_enable = yes"
var5="smtpd_sasl_security_options = noanonymous"
var6="smtpd_sasl_local_domain = \$myhostname"
var7="smtpd_recipient_restrictions = permit_mynetworks,permit_auth_destination,permit_sasl_authenticated,reject"
echo -e "\n" | tee -a /etc/postfix/main.cf
echo $var1 | tee -a /etc/postfix/main.cf
echo $var2 | tee -a /etc/postfix/main.cf
echo $var3 | tee -a /etc/postfix/main.cf
echo $var4 | tee -a /etc/postfix/main.cf
echo $var5 | tee -a /etc/postfix/main.cf
echo $var6 | tee -a /etc/postfix/main.cf
echo $var7 | tee -a /etc/postfix/main.cf
echo -e "\n\n Change your own myhostname line!"
