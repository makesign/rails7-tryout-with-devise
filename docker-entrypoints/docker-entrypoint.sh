#!/bin/bash

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

echo "----------  RAILS_ENV = ${RAILS_ENV} --------"
echo "----------  RAILSAPP_IMAGE = ${RAILSAPP_IMAGE} --------"

bundle exec rails db:migrate
bundle exec rails s -b 0.0.0.0

# tail -f Gemfile