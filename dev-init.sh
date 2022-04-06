#!/bin/sh

cp -n ./.env.local ./.env

docker-compose up -d
