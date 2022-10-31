FROM alpine:3.12
MAINTAINER Kensium
ENV DEBIAN_FRONTEND noninteractive
RUN apk update && apk add nginx && mkdir /run/nginx && apk add php7 php7-fpm php7-bcmath php7-cli php7-ctype php7-curl php7-dom php7-fpm php7-gd php7-iconv php7-intl php7-json php7-mbstring php7-mcrypt php7-openssl php7-pdo_mysql php7-phar php7-session php7-simplexml php7-soap php7-tokenizer php7-xml php7-xmlwriter php7-xsl php7-zip php7-zlib php7-sockets php7-sodium php7-fileinfo mysql mysql-client && addgroup mysql mysql && apk add curl wget axel gnupg vim sudo bash net-tools redis openssl openjdk11 && rm -rf /var/cache/apk/* && axel https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.6.2-linux-x86_64.tar.gz && tar -xf  elasticsearch-7.6.2-linux-x86_64.tar.gz -C /usr/share/ && echo -e "export ES_JAVA_HOME=/usr/lib/jvm/java-11-openjdk\nexport JAVA_HOME=/usr/lib/jvm/java-11-openjdk" >> /etc/profile && mv /usr/share/elasticsearch-7.6* /usr/share/elasticsearch && mkdir /usr/share/elasticsearch/data && mkdir /usr/share/elasticsearch/config/scripts && adduser -D -u 1000 -h /usr/share/elasticsearch elasticsearch && chown -R elasticsearch /usr/share/elasticsearch && rm -rf /usr/share/elasticsearch/modules/x-pack-ml && rm -rf /var/cache/apk/* /elasticsearch-7.6.2-linux-x86_64.tar.gz && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && php composer-setup.php && php -r "unlink('composer-setup.php');" && sudo mv composer.phar /usr/local/bin/composer && composer self-update 2.0.0 && mkdir /var/www/html
COPY php.ini /etc/php7/php.ini
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
COPY auth.json /root/.composer/auth.json
COPY auth.json /var/www/html
COPY default.conf /etc/nginx/conf.d/default.conf
COPY www.conf /etc/php7/php-fpm.d/www.conf 
COPY services.sh /
ENTRYPOINT ["/services.sh"]



