#!/bin/bash

declare -a sources=("pageviews" "users_log")

for source in "${sources[@]}"; do
  dbt -d run-operation create_source_by_name --args "{source_name: $source}"
done