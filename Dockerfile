######################
# Stage: Builder

FROM ruby:2.6.6-alpine as Builder

RUN apk add --update --no-cache build-base git

RUN gem install bundler -v 1.17.3

WORKDIR /app

ADD . /app/

RUN bundle install --without development

###############################
# Stage Final
FROM ruby:2.6.6-alpine

EXPOSE 4567 8080

WORKDIR /app

RUN addgroup -g 1000 -S slanger \
 && adduser -u 1000 -S slanger -G slanger
USER slanger

COPY --from=Builder /usr/local/bundle/ /usr/local/bundle/
COPY --from=Builder --chown=slanger:slanger /app /app

# Start the slanger server
CMD ["sh", "-c", "bin/slanger --app_key ${APP_KEY} --secret ${SECRET} -r redis://${REDIS_HOST}:${REDIS_PORT}/${REDIS_DB}"]
