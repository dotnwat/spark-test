# One-time Setup

1. Ensure that Java is install on the system
2. Ensure that `ssh localhost` works without password
3. Run `./prepare.sh` to download Spark and spark-perf

#### Password-less SSH

To setup password-less SSH if it is not already setup, the following usually
works depending on your configuration:

```bash
ssh-keygen -t rsa -N ''
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

# Run Tests

```bash
./spark-perf.sh 1
./spark-perf.sh 2
etc...
```
