FROM centos

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

#ENV HIVE_VER 1.1.0+cdh5.11.1
#ENV HADOOP_VER 2.6.0+cdh5.11.1

USER root

#RUN apt-get update -y
#RUN apt-get upgrade -y
#RUN apt-get install -y wget apt-transport-https python-setuptools openjdk-8-jdk apt-utils sudo postgresql libpostgresql-jdbc-java
#RUN easy_install supervisor
#RUN wget http://archive.cloudera.com/cdh5/one-click-install/trusty/amd64/cdh5-repository_1.0_all.deb
#RUN dpkg -i cdh5-repository_1.0_all.deb
#RUN apt-get update -y
#RUN apt-get install -y --allow-unauthenticated hive=$HIVE_VER* hive-hbase=$HIVE_VER* hive-jdbc=$HIVE_VER* hive-metastore=$HIVE_VER* hive-server2=$HIVE_VER*
#RUN ln -s /usr/share/java/postgresql-jdbc4.jar /usr/lib/hive/lib/postgresql-jdbc4.jar

RUN yum update -y
RUN yum install -y wget python-setuptools java-1.8.0-openjdk-devel sudo curl vim
RUN easy_install supervisor
ADD cloudera-cdh5.repo /etc/yum.repos.d/
RUN rpm --import https://archive.cloudera.com/cdh5/redhat/5/x86_64/cdh/RPM-GPG-KEY-cloudera
RUN yum install -y hive hive-hbase hive-jdbc hive-metastore hive-server2

WORKDIR /

ADD etc/supervisord.conf /etc/
ADD etc/hive/conf/*.xml /etc/hive/conf/
ADD etc/hadoop/conf/*.xml /etc/hadoop/conf/
ADD bin/supervisord-bootstrap.sh ./
ADD bin/wait-for-it.sh ./
RUN chmod +x ./*.sh

#RUN useradd -p $(echo "impala" | openssl passwd -1 -stdin) impala
#RUN groupadd supergroup; \
#    usermod -a -G supergroup impala; \
#    usermod -a -G hdfs impala; \
#    usermod -a -G supergroup hive; \
#    usermod -a -G hdfs hive

EXPOSE 9083 10000 10002

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
