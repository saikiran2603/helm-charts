#!/bin/sh
${HIVE_HOME}/bin/schematool -dbType mysql -validate
if [[ $? -ne 0 ]];
then
  ${HIVE_HOME}/bin/schematool -dbType mysql -initSchema
fi;

# ${HIVE_HOME}/bin/schematool -initSchema -dbType mysql
${HIVE_HOME}/bin/start-metastore
