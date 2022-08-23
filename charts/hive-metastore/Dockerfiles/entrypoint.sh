#!/bin/sh
${HIVE_HOME}/bin/schematool -dbType mysql -validate || ${HIVE_HOME}/bin/schematool -dbType mysql -initSchema

# ${HIVE_HOME}/bin/schematool -initSchema -dbType mysql
${HIVE_HOME}/bin/start-metastore
