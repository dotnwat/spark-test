Instructions

```
git clone https://github.com/noahdesu/spark-test.git
cd spark-test/spark-perf
./run.sh <experiment number>
```

See max memory used:

```bash
issdm@pl2:~/spark-test/spark-perf$ ./max-mem.py results.dir/stats.log 
peak memory usage: 111.100000 gb
```

## Customizing the run

```diff
issdm@pl2:~/spark-test/spark-perf$ diff -uprN scale_test_1 scale_test_2
diff -uprN scale_test_1/config.py scale_test_2/config.py
--- scale_test_1/config.py      2016-06-29 16:05:40.265530638 -0700
+++ scale_test_2/config.py      2016-06-29 16:09:07.961539154 -0700
@@ -126,7 +126,7 @@ PYTHON_MLLIB_OUTPUT_FILENAME = "results/
 # number of records in a generated dataset) if you are running the tests with more
 # or fewer nodes. When developing new test suites, you might want to set this to a small
 # value suitable for a single machine, such as 0.001.
-SCALE_FACTOR = 0.1
+SCALE_FACTOR = 0.545
 
 assert SCALE_FACTOR > 0, "SCALE_FACTOR must be > 0."
 
@@ -145,7 +145,7 @@ COMMON_JAVA_OPTS = [
     # Fraction of JVM memory used for caching RDDs.
     JavaOptionSet("spark.storage.memoryFraction", [0.66]),
     JavaOptionSet("spark.serializer", ["org.apache.spark.serializer.KryoSerializer"]),
-    JavaOptionSet("spark.executor.memory", ["200g"]),
+    JavaOptionSet("spark.executor.memory", ["700g"]),
     # Turn event logging on in order better diagnose failed tests. Off by default as it crashes
     # releases prior to 1.0.2
     # JavaOptionSet("spark.eventLog.enabled", [True]),
diff -uprN scale_test_1/spark-env.sh scale_test_2/spark-env.sh
--- scale_test_1/spark-env.sh   2016-06-29 16:04:43.381528305 -0700
+++ scale_test_2/spark-env.sh   2016-06-29 16:08:29.729537586 -0700
@@ -1,3 +1,3 @@
 SPARK_WORKER_INSTANCES=1
-SPARK_WORKER_CORES=16
-SPARK_WORKER_MEMORY=200g
+SPARK_WORKER_CORES=32
+SPARK_WORKER_MEMORY=700g
```

## Customizing the run 2

Setup `spark-env.sh`

```
SPARK_WORKER_INSTANCES=2
SPARK_WORKER_CORES=8
```

Modify `config.py`. Setup with respect to Spark runtime configuration, in
addition to the `spark-env.sh` settings:

```
SCALE_FACTOR = 0.05
JavaOptionSet("spark.executor.memory", ["20g"]),
SPARK_DRIVER_MEMORY = "20g"
IGNORED_TRIALS = 1
OptionSet("num-trials", [2]),
```

## Results

Example output

```
glm-regression, glm-regression --num-trials=2 --inter-trial-wait=3 --num-partitions=6 --random-seed=5 --num-examples=50000 --feature-noise=1.0 --num-features=10000 --num-iterations=20 --step-size=0.001 --reg-type=l2 --reg-param=0.1 --elastic-net-param=0.0 --optimizer=sgd --intercept=0.0 --label-noise=0.1 --loss=l2
Training time: 32.232, 0.000, 32.232, 32.232, 32.232
Test time: 1.627, 0.000, 1.627, 1.627, 1.627
Training Set Metric: 33.4215006941, 0.000, 33.4215006941, 33.4215006941, 33.4215006941
Test Set Metric: 33.3162064825, 0.000, 33.3162064825, 33.3162064825, 33.3162064825
glm-classification, glm-classification --num-trials=2 --inter-trial-wait=3 --num-partitions=6 --random-seed=5 --num-examples=50000 --feature-noise=1.0 --num-features=10000 --num-iterations=20 --step-size=0.001 --reg-type=l2 --reg-param=0.1 --elastic-net-param=0.0 --per-negative=0.3 --optimizer=sgd --loss=logistic
Training time: 32.2, 0.000, 32.2, 32.2, 32.2
Test time: 1.014, 0.000, 1.014, 1.014, 1.014
Training Set Metric: 85.1502369005, 0.000, 85.1502369005, 85.1502369005, 85.1502369005
Test Set Metric: 84.9587306675, 0.000, 84.9587306675, 84.9587306675, 84.9587306675
```

Explanation

```
glm-regresion, ...: test and test parameters / options
Training time: median, std, min, first, last
Training time: 32.232, 0.000, 32.232, 32.232, 32.232
Test time: same
Metrics: experiment-specific results
```

## Notes

Waiting to find out if dataset creation time is included in test time:

* https://github.com/databricks/spark-perf/issues/104
