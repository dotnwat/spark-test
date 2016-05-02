#!/bin/bash

cdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t spark-perf $cdir

# -it --entrypoint=/bin/bash \
docker run \
  -v $cdir/config.py.tiny:/spark-perf/config/config.py \
  spark-perf bin/run
