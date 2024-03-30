#!/bin/bash

mix archive.install --force github hexpm/hex branch latest

mix deps.get
mix ecto.create
mix ecto.migrate

iex --name tiny_note@tiny_note --cookie magiccookie \
	-S mix phx.server -e "Process.sleep(:infinity)"
