#!/bin/sh

docker-compose run --rm -v "$(pwd):/usr/src" -w /usr/src node sh -c "npm run build"
