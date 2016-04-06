```bash
git clone https://github.com/noahdesu/spark-test.git
pushd spark-test
docker build -t=docker-spark-test .
./test.sh  docker-spark-test spark-env.sh spark-defaults.conf 10
```


#NEW MODIFICATION:
```
USAGE: ./test.sh <docker img> <spark_env_sh_file> <spark_defaults_conf_file> nvert[ nvert[ ...]]
```
##I also added sample files
`spark-env.sh`
`spark-defaults.conf`
