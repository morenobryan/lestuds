#!/usr/bin/env bash

mix deps.get

mix ecto.setup

cd assets
npm install
