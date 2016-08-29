#!/bin/bash

rm /opt/hive/logs/*.pid 2> /dev/null

wait-for-it.sh zookeeper:2181 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "Zookeeper not ready! Exiting..."
	exit $rc
fi

wait-for-it.sh hadoop:8020 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "HDFS not ready! Exiting..."
	exit $rc
fi

wait-for-it.sh postgres:5432 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "PostgreSQL not ready! Exiting..."
	exit $rc
fi

hdfs dfs -mkdir -p /tmp
hdfs dfs -mkdir -p /user/hive/warehouse
hdfs dfs -chmod g+w /tmp
hdfs dfs -chmod g+w /user/hive/warehouse
hdfs dfs -chown -R hdfs:supergroup /tmp
hdfs dfs -chown -R hdfs:supergroup /user

psql -h postgres -U postgres -c "CREATE DATABASE metastore;" 2>/dev/null

supervisorctl start hcat

wait-for-it.sh localhost:9083 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "Hive Metastore not ready! Exiting..."
    exit $rc
fi

supervisorctl start hiveserver2

wait-for-it.sh localhost:10000 -t 120
wait-for-it.sh localhost:10002 -t 120

rc=$?
if [ $rc -ne 0 ]; then
    echo "HiveServer2 not ready! Exiting..."
    exit $rc
fi

supervisorctl start webhcat

ip=`awk 'END{print $1}' /etc/hosts`

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hive Web UIs:"
echo -e ""
echo -e "HiveServer2 Web Interface:		http://$ip:10002"
echo -e "--------------------------------------------------------------------------------\n\n"
