FROM php:5.6-apache

MAINTAINER Dries De Peuter <dries@nousefreak.be>

RUN apt-get update \
    && apt-get install -y \
        fontconfig \
        xfonts-75dpi \
        libxrender1 \
        xfonts-base \
        libjpeg62-turbo \
        libxext6 \
        wget \
    && wget -O wkhtmltox.deb http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-jessie-amd64.deb \
    && dpkg -i wkhtmltox.deb \
    && apt-get clean

RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/web|' /etc/apache2/apache2.conf \
    && echo "FallbackResource /index.php" >> /etc/apache2/apache2.conf

COPY . /var/www/html

RUN php -r "readfile('https://getcomposer.org/installer');" | php \
	&& php composer.phar install \
	&& rm composer.phar
