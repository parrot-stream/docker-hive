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

psql -h postgres -U postgres -c "CREATE DATABASE metastore;" 2>/dev/null

$HIVE_HOME/bin/schematool -dbType postgres -initSchema

supervisorctl start hcat

wait-for-it.sh localhost:9083 -t 240

rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "  Hive Metastore not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start hiveserver2

wait-for-it.sh localhost:10000 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "   HiveServer2 not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

wait-for-it.sh localhost:10002 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "   HiveServer2 not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

supervisorctl start webhcat

wait-for-it.sh localhost:10002 -t 240
rc=$?
if [ $rc -ne 0 ]; then
    echo -e "\n---------------------------------------"
    echo -e "   WebHCat not ready! Exiting..."
    echo -e "---------------------------------------"
    exit $rc
fi

echo -e "\n\n--------------------------------------------------------------------------------"
echo -e "You can now access to the following Hive Web UIs:"
echo -e ""
echo -e "HiveServer2 Web Interface:		http://localhost:10002"
echo -e "\nMantainer:   Matteo Capitanio <matteo.capitanio@gmail.com>"
echo -e "--------------------------------------------------------------------------------\n\n"
