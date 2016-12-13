# **hive**
___

### Description
___

This image runs the official [*Apache Hive*](https://hive.apache.org/) on a Centos Linux distribution.

The *latest* tag of this image is build with the [latest stable](https://hive.apache.org/downloads.html) release of Apache Hive on Centos 7.

You can pull it with:

    docker pull mcapitanio/hive


You can also find other images based on different Apache Hadoop releases, using a different tag in the following form:

    docker pull mcapitanio/hive:[hive-release]


For example, if you want Apache Hadoop release 1.2.1 you can pull the image with:

    docker pull mcapitanio/hive:1.2.1


Run with Docker Compose:

    docker-compose -p docker up

Stop with Docker Compose:

    docker-compose -p docker down --remove-orphans

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created with with the containers created with other docker-compose.yml configurations (for example the one of the [Hadoop Docker image]((https://hub.docker.com/r/mcapitanio/hadoop/))).

Once started you'll be able to read the list of all the Hive Web UIs urls, for example (the ip is non static!):

| **Hive Web UIs**            |**URL**                             |
|:----------------------------|:-----------------------------------|
| *HiveServer2 Web Interface* | http://172.17.0.3:10002            |


There are 2 named volumes defined:

- **hive_conf** wich points to HIVE_CONF_DIR
- **hive_logs** which points to HIVE_LOG_DIR

### Available tags:

- Apache Hive 2.1.1 ([latest](https://github.com/mcapitanio/docker-hadoop/blob/latest/Dockerfile), [2.1.1](https://github.com/mcapitanio/docker-hive/blob/2.1.1/Dockerfile))
- Apache Hive 2.1.0 ([2.1.0](https://github.com/mcapitanio/docker-hive/blob/2.1.0/Dockerfile))
