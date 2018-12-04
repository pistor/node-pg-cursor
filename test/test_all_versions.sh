#!/bin/bash

node_versions='6 8 10'
pg_versions='9.6 10 11'

trap cleanup 0 1 2 3 6
set -e

function cleanup {
  docker-compose down
}

for node_version in $node_versions
do
  export NODE_VERSION=$node_version
  for pg_version in $pg_versions
  do
    export POSTGRES_VERSION=$pg_version
    echo "Running tests with Node v$node_version, PostgreSQL v$pg_version..."
    docker-compose run --rm test
    docker-compose down
  done
done
echo "All done"
