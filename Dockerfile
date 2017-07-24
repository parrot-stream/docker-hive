FROM parrotstream/centos-openjdk

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ADD cloudera-cdh5.repo /etc/yum.repos.d/
RUN rpm --import https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN yum install -y hive hive-hbase hive-jdbc hive-metastore hive-server2
RUN yum clean all

WORKDIR /

ADD etc/supervisord.conf /etc/
ADD etc/hive/conf/*.xml /etc/hive/conf/
ADD etc/hadoop/conf/*.xml /etc/hadoop/conf/
ADD bin/supervisord-bootstrap.sh ./
ADD bin/wait-for-it.sh ./
RUN chmod +x ./*.sh

EXPOSE 9083 10000 10002

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
