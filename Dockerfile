FROM mysql:5.7
ENV MYSQL_DATABASE=laravel
ENV MYSQL_ROOT_PASSWORD=laravel

FROM wyveo/nginx-php-fpm:latest
WORKDIR /usr/share/nginx/
RUN rm -rf /usr/share/nginx/html
COPY . /usr/share/nginx
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer install && \
    ln -s public html && \
    chown -R nginx:nginx * && \
    chmod -R 777 storage && \
    cp .env.example .env && \
    php artisan key:generate && \
    php artisan db:seed && \
    php vendor/bin/phpunit