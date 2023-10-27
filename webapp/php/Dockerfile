FROM php:8.1.8-fpm-bullseye

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y wget make libzip-dev unzip sqlite3 procps git autoconf g++ && \
  wget -q https://dev.mysql.com/get/mysql-apt-config_0.8.22-1_all.deb && \
  apt-get -y install ./mysql-apt-config_*_all.deb && \
  apt-get -y update && \
  apt-get -y install default-mysql-client && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure zip && \
  docker-php-ext-install zip && \
  docker-php-ext-install pdo_mysql

RUN git clone https://github.com/tideways/php-profiler-extension.git && \
  cd php-profiler-extension && \
  phpize && \
  ./configure && \
  make && \
  make install && \
  echo 'extension=tideways_xhprof.so' > /usr/local/etc/php/conf.d/tideways_xhprof.ini && \
  echo 'tideways.auto_prepend_library=0' >> /usr/local/etc/php/conf.d/tideways_xhprof.ini && \
  echo 'tideways.output_dir=/home/isucon/tmp' >> /usr/local/etc/php/conf.d/tideways_xhprof.ini

RUN useradd --uid=1001 --create-home isucon
USER isucon
RUN mkdir -p /home/isucon/webapp/php
WORKDIR /home/isucon/webapp/php

COPY composer* /home/isucon/webapp/php/
RUN ./composer.phar install

COPY --chown=isucon:isucon ./ /home/isucon/webapp/php/
