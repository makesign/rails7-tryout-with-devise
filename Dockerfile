FROM ruby:3.3.3-alpine AS railsapp-base

ENV RAILSAPP_IMAGE=railsapp-base
ENV BUNDLER_VERSION=2.3.24

ENV RAILS_ENV production

WORKDIR /railsapp
COPY Gemfile Gemfile.lock ./

ENV GENERAL_DEPS="bash tzdata libpq"
ENV BUILD_DEPS="git linux-headers libxml2-dev libxslt-dev build-base postgresql-dev gcompat"
ENV NOKOGIRI_SYSTEM_LIBS="build-base libxml2-dev libxslt-dev"
ENV AO --no-cache

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
# Production
# -------------------------------------------------------------------

FROM railsapp-base AS railsapp-prod
ENV RAILSAPP_IMAGE=railsapp-prod
COPY . ./
ENV ASSETS_DEPS="nodejs npm yarn"
RUN set -ex  \
  && apk add $AO --virtual assetdeps $ASSETS_DEPS \
  && yarn \
  && SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile \
  && apk del assetdeps

  
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

# -------------------------------------------------------------------
# slim production
# -------------------------------------------------------------------


FROM ruby:3.3.3-alpine AS railsapp-slim
ENV RAILSAPP_IMAGE=railsapp-slim
ENV RAILS_ENV production
WORKDIR /railsapp

COPY --from=railsapp-prod . ./
COPY --from=railsapp-prod /usr/local/bundle/gems /usr/local/bundle/gems/

