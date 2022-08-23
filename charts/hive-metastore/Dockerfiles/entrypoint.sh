#!/bin/sh
${HIVE_HOME}/bin/schematool -initSchema -ifNotExists -dbType mysql
${HIVE_HOME}/bin/start-metastore
