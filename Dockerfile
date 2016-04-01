FROM ubuntu:trusty

MAINTAINER Pedro Cesar <pedrocesar.ti@gmail.com>

RUN mkdir -p /app
WORKDIR /app/janky
EXPOSE 9292

RUN apt-get update 
RUN apt-get install -y git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev libmysqlclient-dev && gem install bundler

RUN apt-get install -y ruby ruby-dev && gem install bundler
RUN git clone https://github.com/github/janky.git /app/janky
RUN cd /app/janky/

RUN apt-get install -y mysql-server
RUN /etc/init.d/mysql restart
RUN mysqladmin -uroot create janky_development
RUN mysqladmin -uroot create janky_test

RUN script/bootstrap

RUN RACK_ENV=development bin/rake db:migrate
RUN RACK_ENV=test bin/rake db:migrate

RUN bin/rake db:seed

#CMD script/server
