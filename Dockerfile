FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update
RUN apt-get install -y \
  software-properties-common \
  python-software-properties \
  openjdk-8-jdk-headless \
  openjdk-8-jre-headless \
  curl

#Download SPARK
RUN curl -s http://mirror.intergrid.com.au/apache/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-2.3.0-bin-hadoop2.7 spark
ENV SPARK_HOME /usr/local/spark


# upload Spark config
ADD conf/spark-defaults.conf /usr/local/spark/conf/spark-defaults.conf
ADD scripts/master.sh /usr/local/spark/sbin/docker-master.sh
ADD scripts/slave.sh /usr/local/spark/sbin/docker-slave.sh

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080
ENV SPARK_WORKER_PORT 8888
ENV SPARK_WORKER_WEBUI_PORT 8081

# Clean up
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8080 4040 8081 7077 6066

WORKDIR /
CMD ["./start-all.sh"]
