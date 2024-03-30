#!/bin/bash

mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
# iex --erl "-kernel shell_history enabled" \
# 	--name tiny_note@tiny_note \
# 	--cookie magiccookie \
# 	-S mix phx.server
