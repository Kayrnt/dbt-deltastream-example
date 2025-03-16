#!/bin/bash

# use .env file
export $(cat .env | xargs)

declare -a sources=("postgres_cluster" "pageviews" "users_log")

for source in "${sources[@]}"; do
  dbt -d run-operation create_source_by_name --args "{source_name: $source}" --target prod
done

dbt -d run --target prod