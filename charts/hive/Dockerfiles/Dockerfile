FROM openjdk:8-jre

# ARG HADOOP_VERSION
# ARG HIVE_VERSION
# ARG TEZ_VERSION
ENV HIVE_VERSION=4.0.0-alpha-1
ENV HADOOP_VERSION=3.3.1
ENV TEZ_VERSION=0.10.2


# Install dependencies
RUN set -ex; \
  apt-get update; \
  apt-get -y install curl; \
  rm -rf /var/lib/apt/lists/*

RUN set -ex; \
    curl -fSL https://archive.apache.org/dist/hive/hive-$HIVE_VERSION/apache-hive-$HIVE_VERSION-bin.tar.gz -o /opt/apache-hive-$HIVE_VERSION-bin.tar.gz; \
    curl -fSL https://archive.apache.org/dist/hadoop/core/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -o /opt/hadoop-$HADOOP_VERSION.tar.gz

# COPY hadoop-$HADOOP_VERSION.tar.gz /opt
# COPY apache-hive-$HIVE_VERSION-bin.tar.gz /opt
RUN tar -xzvf /opt/hadoop-$HADOOP_VERSION.tar.gz -C /opt/ && \
    ln -s /opt/hadoop-$HADOOP_VERSION /opt/hadoop && \
    tar -xzvf /opt/apache-hive-$HIVE_VERSION-bin.tar.gz -C /opt/ && \
    ln -s /opt/apache-hive-$HIVE_VERSION-bin /opt/hive

Run curl -L https://archive.apache.org/dist/tez/$TEZ_VERSION/apache-tez-$TEZ_VERSION-bin.tar.gz \
    | tar xvz -C /opt/ && \
    ln -s /opt/apache-tez-$TEZ_VERSION-bin /opt/tez

# Set necessary environment variables.
ENV HADOOP_HOME=/opt/hadoop \
    HIVE_HOME=/opt/hive \
    TEZ_HOME=/opt/tez \
    SERVICE_NAME=hiveserver2

ENV PATH=$HIVE_HOME/bin:$HADOOP_HOME/bin:$PATH

COPY scripts/docker-entrypoint.sh /
# COPY conf $HIVE_HOME/conf
RUN chmod +x /docker-entrypoint.sh

EXPOSE 10000 10002
# ENTRYPOINT ["sh", "-c", "/docker-entrypoint.sh"]