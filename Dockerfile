FROM ubuntu:22.04

LABEL maintainer="https://twitter.com/djfurman4tech"

ENV FLASK_APP=flaskr

RUN apt-get -y update && \
    apt-get install -y python3-pip && \
    apt-get install -y apache2 libapache2-mod-wsgi-py3 && \
    python3 -m pip install --upgrade pip setuptools

COPY . /var/www/app
WORKDIR /var/www/app
RUN python3 setup.py install

RUN ln -s /var/www/app/conf/flaskr.conf /etc/apache2/sites-available/flaskr.conf && \
    a2dissite 000-default.conf && \
    a2ensite flaskr.conf

RUN flask init-db

EXPOSE 80

CMD apachectl -D FOREGROUND