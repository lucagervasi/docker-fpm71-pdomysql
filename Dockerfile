FROM php:7.1-fpm-alpine

RUN        apk --update --no-cache add libpng libpng-dev jpeg jpeg-dev \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS openssl-dev \
	&& docker-php-ext-install mysqli \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install gd \
	&& pecl install xdebug \
	&& docker-php-ext-enable xdebug \
	&& apk del .phpize-deps 

COPY xdebug-conf.ini /usr/local/etc/php/conf.d

ADD docker-compose-installer.php /i.php
RUN php /i.php --quiet  --install-dir=/usr/bin --filename=composer

RUN mkdir i-p -m 0777 /xdebug
