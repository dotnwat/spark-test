```bash
git clone https://github.com/mtnriver/spark-test.git
cd spark-test
docker build -t=docker-spark-test .
./test.sh docker-spark-test spark-env.sh spark-defaults.conf 10
#you may have to execute `rm /tmp/cid` to execute another iteration
rm /tmp/cid;  ./test.sh docker-spark-test spark-env.sh spark-defaults.conf 20
rm /tmp/cid;  ./test.sh docker-spark-test spark-env.sh spark-defaults.conf 30
...
```


#NEW MODIFICATION:
```
USAGE: ./test.sh <docker img> <spark_env_sh_file> <spark_defaults_conf_file> nvert[ nvert[ ...]]
```
##I also added sample files
`spark-env.sh`
`spark-defaults.conf`
