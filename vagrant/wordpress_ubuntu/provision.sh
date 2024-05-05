#!/bin/bash

echo "**********************************************************************************************"

sudo -i
# Update package list
apt update -y

apt install apache2 -y
ufw allow in "Apache"

apt install mysql-server -y
mysql -e 'CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;'
mysql -e 'CREATE USER "wordpress"@"%" IDENTIFIED WITH mysql_native_password BY "Admin1234";'
mysql -e "GRANT ALL ON wordpress.* TO 'wordpress'@'%';"
mysql -e "FLUSH PRIVILEGES;"

apt install php libapache2-mod-php php-mysql -y
apt update -y
apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y
cat > /etc/apache2/sites-available/wordpress.conf <<EOF
<VirtualHost *:80>
    DocumentRoot /srv/www/wordpress
    <Directory /srv/www/wordpress>
        Options FollowSymLinks
        AllowOverride All
        DirectoryIndex index.php
        Require all granted
    </Directory>
    <Directory /srv/www/wordpress/wp-content>
        Options FollowSymLinks
        Require all granted
    </Directory>
</VirtualHost>
EOF
a2enmod rewrite
a2ensite wordpress
a2dissite 000-default
systemctl restart apache2

cd /tmp
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
cp /tmp/wordpress/wp-config-sample.php /tmp/wordpress/wp-config.php
mkdir /tmp/wordpress/wp-content/upgrade
mkdir -p /srv/www/wordpress/
cp -a /tmp/wordpress/. /srv/www/wordpress
chown -R www-data:www-data /srv/www/wordpress
find /srv/www/wordpress/ -type f -exec chmod 640 {} \;
find /srv/www/wordpress/ -type d -exec chmod 750 {} \;
sudo -u www-data sed -i 's/username_here/wordpress/g' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/database_name_here/wordpress/g' /srv/www/wordpress/wp-config.php
sudo -u www-data sed -i 's/password_here/Admin1234/g' /srv/www/wordpress/wp-config.php

systemctl restart mysql
systemctl restart apache2

echo "**********************************************************************************************"
