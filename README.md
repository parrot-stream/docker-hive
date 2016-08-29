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

Setting the project name to *docker* with the **-p** option is useful to share the named data volumes created with with the containers created with other docker-compose.yml configurations (for example the one of the [Hadoop Docker image]((https://hub.docker.com/r/mcapitanio/hadoop/))).

Once started you'll be able to read the list of all the Hadoop Web GUIs urls, for example (the ip is non static!):

| **Hive Web UIs**          |**URL**                             |
|:--------------------------|:-----------------------------------|
| *Hadoop Name Node*        | http://172.17.0.3:50070            |
| *Hadoop Data Node*        | http://172.17.0.3:50075            |
| *YARN Node Manager*       | http://172.17.0.3:8042             |
| *YARN Resource Manager*   | http://172.17.0.3:8088             |
| *YARN Timeline History*   | http://172.17.0.3:8188             |
| *MapReduce Job History*   | http://172.17.0.3:19888/jobhistory |

While the Hadoop Docker container is running, you can always get the urls' list with the script:

    print-urls.sh

included in the GitHub source repository.

There are 3 named volumes defined:

- **hive_conf** wich points to HIVE_CONF_DIR
- **hive_logs** which points to HIVE_LOG_DIR

### Available tags:

- Apache Hive 2.1.0 ([latest](https://github.com/mcapitanio/docker-hadoop/blob/latest/Dockerfile), [2.1.0](https://github.com/mcapitanio/docker-hive/blob/2.1.0/Dockerfile))
