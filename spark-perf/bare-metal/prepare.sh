#!/bin/bash

set -e

if [ ! -d spark ]; then
  curl -o http://apache.cs.utah.edu/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
  tar xzf spark-1.6.1-bin-hadoop2.6.tgz
  mv spark-1.6.1-bin-hadoop2.6 spark
fi

if [ ! -d spark-perf ]; then
  rm -rf .spark-perf.tmp
  git clone https://github.com/databricks/spark-perf .spark-perf.tmp
  pushd .spark-perf.tmp/mllib-tests
  sbt/sbt -Dspark.version=1.6.0 clean assembly
  popd
  mv .spark-perf.tmp spark-perf
fi
