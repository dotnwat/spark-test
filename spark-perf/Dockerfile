FROM ubuntu:14.04

RUN apt-get update && apt-get -y install default-jdk vim tmux git curl openssh-server

RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys

RUN curl -O http://apache.cs.utah.edu/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz
RUN tar xzf spark-1.6.1-bin-hadoop2.6.tgz
RUN mv spark-1.6.1-bin-hadoop2.6 spark
RUN echo "localhost" > /spark/conf/slaves

RUN git clone https://github.com/databricks/spark-perf
RUN cd /spark-perf/mllib-tests; sbt/sbt -Dspark.version=1.6.0 clean assembly

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8080 4040 4041
