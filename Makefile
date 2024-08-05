.RECIPEPREFIX = -

run: open
- bin/dev
#- bin/rails server

test:
- RAILS_ENV=test bin/rails db:migrate
- bin/rails test


migrate:
- bin/rails db:migrate

open:
- open http://localhost:3000

build:
- docker build . --tag tryout

ruby_version=$(shell cat .ruby-version)
ruby_gemset=$(shell cat .ruby-gemset)
rvm-info:
- @echo "rvm should use gemset specified in .ruby-version and .ruby-gemset after cd in dir, if not run:"
- @echo
- @echo "rvm gemset use ${ruby_version}@${ruby_gemset}"
- @echo
- rvm gemset list

rebuild-css:
- rm app/assets/builds/application.css && yarn build:css

### Docker

# run source secrets/set_rails_master_key.sh first
stop:
- docker compose down
start:
- docker compose up
prod:
- source secrets/set_rails_master_key.sh first && docker compose -f docker-compose.yml -f docker-compose-build-prod.yml up

bash:
- docker compose exec -ti railsapp bash

rebuild:
- docker compose  -f docker-compose.yml -f docker-compose-build-prod.yml   up --build --force-recreate railsapp

original:
- docker build -f Dockerfile.rails.original --tag original:latest --target app_image .