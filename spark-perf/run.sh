#!/bin/bash

set -e
set -x

EXPR_NUM=$1
EXPR=scale_test_${EXPR_NUM}
DIR=$PWD/$EXPR
if [ ! -d $DIR ]; then
  echo "test $EXPR_NUM does not exist."
  exit 1
fi

docker build -t spark-perf .

outdir=results.${EXPR}.date-$(date +"%m-%d-%Y-%H-%M-%S")
mkdir $outdir

sudo rm -rf logs
mkdir logs

cid=$(docker run \
  -d -it \
  -v `pwd`/$EXPR/config.py:/spark-perf/config/config.py \
  -v `pwd`/$EXPR/spark-env.sh:/spark/conf/spark-env.sh \
  -v `pwd`/slaves:/spark/conf/slaves \
  -v `pwd`/$outdir:/spark-perf/results \
  -v `pwd`/logs/:/spark/logs \
  spark-perf bin/run)

while true; do
  RUNNING=$(docker inspect --format="{{ .State.Running }}" $cid 2> /dev/null)
  if [ "$RUNNING" == "false" ]; then
    break
  fi

  echo `date +%s` >> $outdir/stats.log
  echo `docker stats --no-stream $cid` >> $outdir/stats.log

  docker logs --tail=10 $cid

  sleep 2
done

docker rm $cid
