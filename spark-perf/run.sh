#!/bin/bash

set -e
set -x

docker build -t spark-perf .

mkdir results || true

sudo rm -rf logs
mkdir logs

# -it --entrypoint=/bin/bash \
docker run \
  --rm -it \
  -v `pwd`/config.py.tiny:/spark-perf/config/config.py \
  -v `pwd`/spark-env.sh:/spark/conf/spark-env.sh \
  -v `pwd`/slaves:/spark/conf/slaves \
  -v `pwd`/results:/spark-perf/results \
  -v `pwd`/logs/:/spark/logs \
  spark-perf bin/run
