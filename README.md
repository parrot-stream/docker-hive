# **hive**
___

### Description
___

This image runs the [*Apache Hive*](https://hive.apache.org/) on a Centos 7 Linux distribution.

You can pull it with:

    docker pull parrotstream/hive

You can also find other images based on different Apache Hive releases, using a different tag in the following form:

    docker pull parrotstream/hive:[hive-release]

For example, if you want Apache Hive release 1.1.0 you can pull the image with:

    docker pull parrotstream/hive:1.2.2

Run with Docker Compose:

    docker-compose -p parrot up

Stop with Docker Compose:

    docker-compose -p parrot down

Setting the project name to *parrot* with the **-p** option is useful to share the network created with the containers coming from other Parrot docker-compose.yml configurations.

### Available tags:

- Apache Hive 2.3.3 ([latest](https://github.com/parrot-stream/docker-hive/blob/latest/Dockerfile), [2.3.3](https://github.com/parrot-stream/docker-hive/blob/2.3.3/Dockerfile))
- Apache Hive 1.2.2 ([1.2.2](https://github.com/parrot-stream/docker-hive/blob/1.2.2/Dockerfile))
- Apache Hive 1.1.0-cdh5.11.1 ([1.1.0-cdh5.11.1](https://github.com/parrot-stream/docker-hive/blob/1.1.0-cdh5.11.1/Dockerfile))
