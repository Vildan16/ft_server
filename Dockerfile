FROM debian:buster

#install packages
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install  nginx openssl mariadb-server \
                        php7.3 php-mysql php-fpm php-pdo \
                        php-gd php-curl php-intl php-soap \
                        php-xml php-xmlrpc php-zip php-cli \
                        php-mbstring wget

COPY srcs /tmp/

WORKDIR /var/www/localhost/

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xvzf latest.tar.gz && \
    rm -rf latest.tar.gz && \
    wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz && \
    tar -xf phpMyAdmin-5.0.1-english.tar.gz && \
    rm -rf phpMyAdmin-5.0.1-english.tar.gz && \
    mv phpMyAdmin-5.0.1-english phpmyadmin

RUN bash /tmp/config.sh

EXPOSE 80 443

ENTRYPOINT bash /tmp/init.sh

CMD tail -f /dev/null