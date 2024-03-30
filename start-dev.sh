#!/bin/bash

mix deps.get
mix ecto.create
mix ecto.migrate

## This works:
mix phx.server

## But this just exits immediately
# iex -S mix phx.server
