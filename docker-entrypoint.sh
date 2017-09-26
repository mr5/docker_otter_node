#!/bin/bash
if [ -z "$MAX_MEN" ];then
	MAX_MEN=3072m
fi
if [ -z "$ZK_TIMEOUT" ];then
	ZK_TIMEOUT=60000
fi
echo '---------------- environments --------'
echo MANAGER_ADDRESS: $MANAGER_ADDRESS
echo NID: $NID
echo MAX_MEN: $MAX_MEN
echo ZK_TIMEOUT: $ZK_TIMEOUT

echo $NID > /opt/otter_node/conf/nid
sed -i s/"-server -Xms32m -Xmx3072m"/"-server -Xms32m -Xmx$MAX_MEN"/g /opt/otter_node/bin/startup.sh
sed -ri "s/(otter.manager.address).*/\1 = $MANAGER_ADDRESS/" /opt/otter_node/conf/otter.properties
/opt/otter_node/bin/startup.sh
tail -f /opt/otter_node/logs/manager.log & wait