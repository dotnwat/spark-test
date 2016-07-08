#!/bin/bash

set -e

EXPR_NUM=$1
EXPR=scale_test_${EXPR_NUM}
DIR=$PWD/../$EXPR
if [ ! -d $DIR ]; then
  echo "test $EXPR_NUM does not exist."
  exit 1
fi

outdir=results.${EXPR}.date-$(date +"%m-%d-%Y-%H-%M-%S")
mkdir $outdir

sudo rm -rf logs
mkdir logs

cp $DIR/config.py spark-perf/config/
cp $DIR/spark-env.sh spark/conf/
cp ../slaves spark/conf/
rm -rf spark-perf/results spark/logs
ln -s ../$outdir spark-perf/results
ln -s ../logs spark/logs

spark-perf/bin/run
