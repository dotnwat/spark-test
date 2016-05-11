Instructions:

```
git clone https://github.com/noahdesu/spark-test.git
cd spark-test/spark-perf
./run.sh

## Customizing the run

Setup `spark-env.sh`:

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

Example output:

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

Explanation:

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
