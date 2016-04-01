#!/bin/bash
WORK_DIR="/app/janky"


# Configuring DATABASE
service mysql restart
mysqladmin -uroot create janky_development
mysqladmin -uroot create janky_test


# Fetching all dependencies 
cd ${WORK_DIR}
bundle install
script/bootstrap

# Populating DB
RACK_ENV=development bin/rake db:migrate
RACK_ENV=test bin/rake db:migrate
bin/rake db:seed

# Running service
script/server
