#!/bin/bash

# wait 5 seconds for dns to
echo "waiting 5 seconds for dns"
sleep 5

# print environment
env

# get instance count
INSTANCES=$(curl -l -s -H "Content-Type: application/json" http://master.mesos:8080/v2/apps${MARATHON_APP_ID} | jq '.app.instances')

# echo instance count
echo "Instances: $INSTANCES"

# try until DNS is ready
ENDPOINT=$(echo "${MARATHON_APP_ID}.marathon.containerip.dcos.thisdcos.directory" | sed -e "s///g")

# wait for all tasks starting
for i in {1..20}
do
	digs=`dig +short $ENDPOINT`
	if [ -z "$digs" ]; then
		echo "no DNS record found for $ENDPOINT"
	else
		# calculate discovery members
		echo $digs
		#members=`echo $digs | sed -e "s/$ip //g" -e 's/ /:9000,/g'`":9000"
		break
	fi
   	sleep 2
done

sleep 1000