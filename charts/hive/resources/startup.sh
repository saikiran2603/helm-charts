##!/bin/bash
#
##: ${HADOOP_PREFIX:=/usr/local/hadoop}
#
##. $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh
#
## Directory to find config artifacts
##CONFIG_DIR="/tmp/hadoop-config"
#
#set -x
#
## Copy config files from volume mount
##for f in slaves core-site.xml hdfs-site.xml mapred-site.xml yarn-site.xml; do
##    if [[ -e ${CONFIG_DIR}/$f ]]; then
##    cp ${CONFIG_DIR}/$f $HADOOP_HOME/etc/hadoop/$f
##    else
##    echo "ERROR: Could not find $f in $CONFIG_DIR"
##    exit 1
##    fi
#
## Note. This script set hive paths in hdfs with user hive and ensures hiveServer is runAsUser hive
#
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -mkdir /tmp
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -mkdir -p  /user/hive/warehouse
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod 777 /tmp
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod g+w /tmp
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chmod g+w /user/hive/warehouse
#HADOOP_USER_NAME={{ .Values.conf.hdfsAdminUser }} hdfs dfs -chown hive:hive /user/hive/warehouse
#
#
##if id -u hive ; then
##    echo "hive user exists";
##else
##    echo "Creating hive user";
##    groupadd -g 500 -r hive && \
##    useradd --comment "Hive user" -u 500 --shell /bin/bash -M -r -g hive hive
##fi
#
##if [[ whoami != hive ]]
##then
##    echo "Switching to hive user";
##    su hive -c "cd $HIVE_HOME/bin; ./hiveserver2 --hiveconf hive.server2.enable.doAs=false"
##else
#    cd $HIVE_HOME/bin; ./hiveserver2 --hiveconf hive.server2.enable.doAs=false --hiveconf hive.root.logger={{ .Values.conf.logLevel }},console
##fi

#!/bin/bash

#
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -x

: ${DB_DRIVER:=derby}

SKIP_SCHEMA_INIT="${IS_RESUME:-false}"

function initialize_hive {
  $HIVE_HOME/bin/schematool -dbType $DB_DRIVER -initOrUpgradeSchema $SCHEMA_ARGS
  if [ $? -eq 0 ]; then
    echo "Initialized schema successfully.."
  else
    echo "Schema initialization failed!"
    exit 1
  fi
}

export HIVE_CONF_DIR=$HIVE_HOME/conf
if [[ "${SKIP_SCHEMA_INIT}" == "false" ]]; then
  # handles schema initialization
  initialize_hive
fi

if [ "${SERVICE_NAME}" == "hiveserver2" ]; then
  export HADOOP_CLASSPATH=$TEZ_HOME/*:$TEZ_HOME/lib/*:$HADOOP_CLASSPATH
elif [ "${SERVICE_NAME}" == "metastore" ]; then
  export METASTORE_PORT=${METASTORE_PORT:-9083}
fi

export HADOOP_CLIENT_OPTS="$HADOOP_CLIENT_OPTS -Xmx1G $SERVICE_OPTS"

exec /opt/hive/bin/hive --skiphadoopversion --skiphbasecp --service $SERVICE_NAME $SERVICE_ARGS