#!/bin/bash

# wait 5 seconds for dns to
echo "waiting 5 seconds for dns"
sleep 5

env

echo "http://master.mesos:8080/v2/apps${MARATHON_APP_ID}"

curl -l -s -H "Content-Type: application/json" http://master.mesos:8080/v2/apps${MARATHON_APP_ID}

INSTANCES=$(curl -l -s -H "Content-Type: application/json" http://master.mesos:8080/v2/apps${MARATHON_APP_ID} | jq '.app.instances')

echo "Instances: $INSTANCES"

# try until DNS is ready
url="${MARATHON_APP_ID:-.marathon.containerip.dcos.thisdcos.directory}"

# wait for all tasks starting
#for i in {1..20}
#do#
#	digs=`dig +short $url`
#	if [ -z "$digs" ]; then
#		echo "no DNS record found for $url"
#	else
#		# calculate discovery members
#		members=`echo $digs | sed -e "s/$ip //g" -e 's/ /:5000,/g'`":5000"
#		echo "calculated initial discovery members: $members"
#		export NEO4J_causalClustering_initialDiscoveryMembers=$members
#		break
#	fi
#   sleep 2
#done

sleep 1000