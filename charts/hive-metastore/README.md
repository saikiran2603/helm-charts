# hive-metastore

![Version: 0.3.2](https://img.shields.io/badge/Version-0.3.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 3.0.0](https://img.shields.io/badge/AppVersion-3.0.0-informational?style=flat-square)

Hive standalone metastore

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | mariadb | * |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| hiveMetastore.image.image_name | string | `"hive-metastore"` |  |
| hiveMetastore.image.registry | string | `"neo2603"` |  |
| hiveMetastore.image.tag | string | `"latest"` |  |
| hiveMetastore.mysql.dbName | string | `"metastore_db"` |  |
| hiveMetastore.mysql.jdbcUrl | string | `"jdbc:mysql://mariadb-primary:3306"` |  |
| hiveMetastore.mysql.password | string | `"admin"` |  |
| hiveMetastore.mysql.user | string | `"admin"` |  |
| hiveMetastore.s3.accessKey | string | `"minio"` |  |
| hiveMetastore.s3.endpoint | string | `"http://localhost:80"` |  |
| hiveMetastore.s3.secretKey | string | `"minio123"` |  |
| hiveMetastore.s3.warehouseBucket | string | `"test-trino"` |  |
| hiveMetastore.service.nodePort | string | `""` |  |
| hiveMetastore.service.port | int | `9083` |  |
| hiveMetastore.service.type | string | `"ClusterIP"` |  |
| mariadb.architecture | string | `"replication"` |  |
| mariadb.auth.database | string | `"metastore_db"` |  |
| mariadb.auth.password | string | `"admin"` |  |
| mariadb.auth.username | string | `"admin"` |  |
| mariadb.fullnameOverride | string | `"mariadb"` |  |
| mariadb.secondary.replicaCount | int | `3` |  |
| replicaCount | int | `4` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)