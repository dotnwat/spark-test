#!/bin/bash

set -e
set -x

cdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build -t spark-perf $cdir

if [ -d results ]; then
  mv results results.prev
fi

mkdir results

# -it --entrypoint=/bin/bash \
docker run \
  --rm -it \
  -v $cdir/config.py.tiny:/spark-perf/config/config.py \
  -v `pwd`/results:/spark-perf/results \
  spark-perf bin/run
