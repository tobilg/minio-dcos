#!/bin/bash

# wait 5 seconds for dns to
echo "Waiting 30 seconds for dns"
sleep 30

# print environment
env

# get instance count
INSTANCES=$(curl -l -s -H "Content-Type: application/json" http://master.mesos:8080/v2/apps${MARATHON_APP_ID} | jq '.app.instances')

# echo instance count
echo "Instances: $INSTANCES"

# try until DNS is ready
ENDPOINT=$(echo "${MARATHON_APP_ID}.marathon.containerip.dcos.thisdcos.directory" | sed -e "s/\///g")

echo "Endpoint: ${ENDPOINT}"

# define mino start command
MINIO_CMD="minio server"

# wait for all tasks starting
for i in {1..20}
do

	# get ip addresses and write to file
	dig +short $ENDPOINT > minio-endpoints.txt

	# read the endpoint ips from the file
	IFS=$'\n' read -d '' -r -a ENPOINT_IPS < minio-endpoints.txt

	# Check if endpoints are found
	if [ -z "$ENPOINT_IPS" ]; then
		echo "no DNS record found for $ENDPOINT"
	else
		# show endpoint ips
		echo "Endpoint IPs are:"
		cat minio-endpoints.txt
	fi

	# check if endpoints match desired Marathon instances
	if [ "${#ENPOINT_IPS[@]}" -eq "${INSTANCES}" ]; then
		echo "Got matching endpoints compared to Marathon instances"
	else
		echo "Got non-matching endpoints (${#ENPOINT_IPS[@]}) compared to Marathon instances (${INSTANCES})"
	fi

	# handling
	if [ "${#ENPOINT_IPS[@]}" -eq "${INSTANCES}" ]; then

		# iterate over the endpoints
		for endpoint_ip in "${ENPOINT_IPS[@]}"; do
			MINIO_CMD="${MINIO_CMD} http://${endpoint_ip}/export"
    	done
		
		break
	fi

   	sleep 2

done

# echo final minio command
echo "The following command will be run to start Minio:"
echo "${MINIO_CMD}"

# execute minio
exec ${MINIO_CMD}
