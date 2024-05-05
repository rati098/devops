#!/bin/bash

sudo apt update -y

sudo apt install -y apache2

sudo systemctl enable apache2

cd /tmp/

wget https://www.tooplate.com/zip-templates/2132_clean_work.zip

sudo apt install -y unzip

unzip 2132_clean_work.zip

sudo mv 2132_clean_work/* /var/www/html/

sudo chmod -R www-data:www-data /var/www/html/