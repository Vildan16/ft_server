#!/bin/bash

#copy nginx.conf to sites-available folder
cp /tmp/nginx.conf /etc/nginx/sites-available/

#link nginx.conf with sites-enabled
ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/

#unling default froms sites-enabled
unlink /etc/nginx/sites-enabled/default


#SSL config
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=RU/ST=Tatarstan/L=Kazan/O=Ecole42/OU=School21/CN=localhost" \
    -keyout /etc/ssl/certs/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt
chmod 666 /etc/ssl/certs/nginx-selfsigned.key /etc/ssl/certs/nginx-selfsigned.crt


#MySQL
service mysql start
echo "CREATE DATABASE exampledb;" | mysql -u root
echo "GRANT ALL ON exampledb.* TO 'exampleuser'@'localhost' IDENTIFIED BY 'exampleuser';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

#PHP
chown -R www-data:www-data /var/www/localhost/*
chmod -R 755 /var/www/*

#WordPress
echo "CREATE DATABASE wp DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
echo "GRANT ALL ON wp.* TO 'admin'@'localhost' IDENTIFIED BY 'admin' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
cp /tmp/wp-config.php /var/www/localhost/wordpress

#PHP MyAdmin
cp /tmp/config.inc.php /var/www/localhost/phpmyadmin/config.inc.php