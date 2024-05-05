FROM ubuntu:latest
RUN apt update && apt install apache2 -y
WORKDIR /var/www/html
ADD web.tar.gz .
EXPOSE 80
CMD ["apachectl","-D","FOREGROUND"]