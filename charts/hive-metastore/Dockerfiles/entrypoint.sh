#!/bin/sh


${HIVE_HOME}/bin/schematool -dbType mysql -validate 
if [ "$?" -eq "0" ]
then
  echo "Validation Success"
else
  echo "Failed Validation "
  ${HIVE_HOME}/bin/schematool -dbType mysql -initSchema
  echo "Init Completed "
fi

echo "Starting Hive metastore "
# ${HIVE_HOME}/bin/schematool -initSchema -dbType mysql
${HIVE_HOME}/bin/start-metastore
