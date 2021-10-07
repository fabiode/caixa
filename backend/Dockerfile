FROM ruby:2.7.4-alpine

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.1.4
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV RAILS_PORT 3000

# copy entrypoint scripts and grant execution permissions
COPY ./.docker/bin/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./.docker/bin/entrypoint.test.sh /usr/local/bin/entrypoint.test.sh
RUN chmod +x /usr/local/bin/entrypoint.sh && chmod +x /usr/local/bin/entrypoint.test.sh

# install dependencies for application
RUN apk -U add --no-cache \
build-base \
git \
postgresql-dev \
postgresql-client \
libxml2-dev \
libxslt-dev \
imagemagick \
tzdata \
&& rm -rf /var/cache/apk/* \
&& mkdir -p $APP_PATH 


RUN gem install bundler --version "$BUNDLE_VERSION" \
&& rm -rf $GEM_HOME/cache/*

# navigate to app directory
WORKDIR $APP_PATH

EXPOSE $RAILS_PORT

ENTRYPOINT [ "bundle", "exec" ]

CMD [ "rails", "s"]
