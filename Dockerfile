FROM keachi/php-sql

ENV VERSION 2.9.1

RUN apt-get update \
    && apt-get install -y libpng12-dev imagemagick curl unzip \
    ; \
    curl -L "http://piwigo.org/download/dlcounter.php?code=${VERSION}" -o /piwigo.zip \
    && unzip /piwigo.zip -d /var/www \
    && rm -rf /var/www/html \
    && mv /var/www/piwigo /var/www/html \
    && rm /piwigo.zip \
    && sed -i "s#if (\$result)#if (pwg_db_num_rows(\$result))#" /var/www/html/include/functions_session.inc.php \
    ; \
    apt-get autoremove --purge -y unzip \
    && rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install gd mbstring exif

COPY assets/database.inc.php /var/www/html/local/config/database.inc.php

VOLUME "/var/www/html/_data"
VOLUME "/var/www/html/upload"
