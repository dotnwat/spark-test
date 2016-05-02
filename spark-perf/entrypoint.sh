#!/bin/bash
set -x
set -e

service ssh start
cd /spark-perf
$*
