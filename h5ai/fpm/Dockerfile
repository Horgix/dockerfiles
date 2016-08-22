FROM php:fpm-alpine

MAINTAINER Alexis Horgix Chotard <alexis.horgix.chotard@gmail.com>

ADD https://release.larsjung.de/h5ai/h5ai-0.29.0.zip /srv/h5ai.zip
RUN apk add --update --no-cache unzip zip \
      freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev \
      && docker-php-ext-configure gd \
          --with-gd \
          --with-freetype-dir=/usr/include/ \
          --with-png-dir=/usr/include/ \
          --with-jpeg-dir=/usr/include/ \
      && docker-php-ext-install gd exif \
      && apk del --no-cache freetype-dev libpng-dev libjpeg-turbo-dev
RUN mkdir -p /srv/h5ai \
      && unzip /srv/h5ai.zip -d /srv/h5ai \
      && rm /srv/h5ai.zip \
      && chown -R www-data:www-data /srv/h5ai
