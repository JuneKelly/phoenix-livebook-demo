FROM elixir:1.16.2-otp-25-alpine

RUN apk add --update git build-base inotify-tools curl bash

RUN mkdir /app && mkdir /app/_build && mkdir /app/deps
WORKDIR /app

RUN addgroup --gid "1000" apprunner

RUN adduser \
  --disabled-password \
  --gecos "" \
  --home "/home/apprunner/" \
  --ingroup "apprunner" \
  --uid "1000" \
  apprunner

RUN chown -R apprunner:apprunner /app

USER apprunner

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force
