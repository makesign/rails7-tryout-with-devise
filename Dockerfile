FROM ruby:3.3.3-alpine AS railsapp-base

ENV RAILSAPP_IMAGE=railsapp-base
ENV BUNDLER_VERSION=2.3.24

ENV RAILS_ENV production
ENV NODE_ENV production

WORKDIR /railsapp
COPY Gemfile Gemfile.lock ./

ENV GENERAL_DEPS="bash gcompat libpq tzdata nodejs npm yarn"
ENV BUILD_DEPS="git linux-headers libpq libxml2-dev libxslt-dev build-base postgresql-dev"
ENV NOKOGIRI_SYSTEM_LIBS="build-base libxml2-dev libxslt-dev"
ENV AO="--no-install-recommends --no-cache"

# General dependencies
RUN apk update \
  && echo "Installing general dependencies..." \
  && apk add $AO $GENERAL_DEPS \
  && echo "Installing build dependencies..." \
  && apk add $AO --virtual builddependencies $BUILD_DEPS \
  && echo "Installing Nokogiri system libraries..." \
  && apk add $AO $NOKOGIRI_SYSTEM_LIBS \
  && echo "Installing Nokogiri gem..." \
  && gem install nokogiri --platform=ruby -- --use-system-libraries \
  && echo "Installing Bundler..." \
  && gem install bundler -v $BUNDLER_VERSION \
  && echo "Configuring Bundler..." \
  && bundle config set force_ruby_platform true \
  && bundle config set without 'development test' \
  && bundle config \
  && echo "Running bundle install..." \
  && bundle install \
  && echo "Cleaning up build dependencies..." \
  && apk del builddependencies

ENTRYPOINT ["./docker-entrypoints/docker-entrypoint.sh"]

# -------------------------------------------------------------------
# Production without assets (for Pull Requests)
# -------------------------------------------------------------------

FROM railsapp-base AS railsapp-prod-no-assets
ENV RAILSAPP_IMAGE=railsapp-prod-no-assets
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY
  
COPY . ./

RUN set -ex  \
  && yarn 

# -------------------------------------------------------------------
# Production
# -------------------------------------------------------------------

FROM railsapp-prod-no-assets AS railsapp-prod
ENV RAILSAPP_IMAGE=railsapp-prod
ARG RAILS_MASTER_KEY
ENV RAILS_MASTER_KEY $RAILS_MASTER_KEY

RUN set -ex  \
  && yarn \
  && bin/rails assets:precompile 

# -------------------------------------------------------------------
# Development & Test
# -------------------------------------------------------------------

FROM railsapp-base AS railsapp-dev
ENV RAILSAPP_IMAGE=railsapp-dev

ENV RAILS_ENV development
ENV NODE_ENV development

RUN bundle config unset without \
    && bundle config \
    && bundle install
