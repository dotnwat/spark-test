#!/bin/bash

while true; do
  echo "time `date +%s`"
  docker stats --no-stream $1
  sleep 1
done
