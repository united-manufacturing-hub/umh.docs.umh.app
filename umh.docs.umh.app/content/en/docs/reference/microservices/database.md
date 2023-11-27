---
title: "Database"
content_type: microservices
description: |
    The technical documentation of the database microservice,
    which stores the data of the application.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="db" >}}`
- Service:
  - Internal ClusterIP for the replicas: `{{< resource type="service" name="db-replica" >}}` at
    port 5432
  - Internal ClusterIP for the config: `{{< resource type="service" name="db-config" >}}` at
    port 8008
  - External LoadBalancer: `{{< resource type="service" name="db-lb" >}}` at
    port 5432
- ConfigMap:
  - Patroni: `{{< resource type="configmap" name="db-patroni" >}}`
  - Post init: `{{< resource type="configmap" name="db-postinit" >}}`
  - Postgres BackRest: `{{< resource type="configmap" name="db-pgbackrest" >}}`
  - Scripts: `{{< resource type="configmap" name="db-scripts" >}}`
- Secret:
  - Certificate: `{{< resource type="secret" name="db-certificate" >}}`
  - Patroni credentials: `{{< resource type="secret" name="db-credentials" >}}`
  - Users passwords: `{{< resource type="secret" name="db-psw" >}}`
- PersistentVolumeClaim:
  - Data: `{{< resource type="pvc" name="db-data" >}}`
  - WAL-E: `{{< resource type="pvc" name="db-wal" >}}`

## {{% heading "configuration" %}}

There is only one parameter that usually needs to be changed: the password used
to connect to the database. To do so, set the value of the `db_password` key in
the [`_000_commonConfig.datastorage`](/docs/architecture/helm-chart/#data-storage)
section of the Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                        | Description                                                       | Type   | Allowed values                  | Default                                                                                                                  |
| ------------------------------------ | ----------------------------------------------------------------- | ------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| `BOOTSTRAP_FROM_BACKUP`              | Whether to bootstrap the database from a backup or not.           | int    | 0, 1                            | 0                                                                                                                        |
| `PATRONI_KUBERNETES_LABELS`          | The labels to use to find the pods of the StatefulSet.            | string | Any                             | `{app: united-manufacturing-hub-timescaledb, cluster-name: united-manufacturing-hub, release: united-manufacturing-hub}` |
| `PATRONI_KUBERNETES_NAMESPACE`       | The namespace in which the StatefulSet is deployed.               | string | Any                             | {{< resource type="ns" name="umh" >}}                                                                                    |
| `PATRONI_KUBERNETES_POD_IP`          | The IP address of the pod.                                        | string | Any                             | _Random IP_                                                                                                              |
| `PATRONI_KUBERNETES_PORTS`           | The ports to use to connect to the pods.                          | string | Any                             | `[{"name": "postgresql", "port": 5432}]`                                                                                 |
| `PATRONI_NAME`                       | The name of the pod.                                              | string | Any                             | {{< resource type="pod" name="database" >}}                                                                              |
| `PATRONI_POSTGRESQL_CONNECT_ADDRESS` | The address to use to connect to the database.                    | string | Any                             | $(PATRONI_KUBERNETES_POD_IP):5432                                                                                        |
| `PATRONI_POSTGRESQL_DATA_DIR`        | The directory where the database data is stored.                  | string | Any                             | /var/lib/postgresql/data                                                                                                 |
| `PATRONI_REPLICATION_PASSWORD`       | The password to use to connect to the database as a replica.      | string | Any                             | _Random 16 characters_                                                                                                   |
| `PATRONI_REPLICATION_USERNAME`       | The username to use to connect to the database as a replica.      | string | Any                             | standby                                                                                                                  |
| `PATRONI_RESTAPI_CONNECT_ADDRESS`    | The address to use to connect to the REST API.                    | string | Any                             | $(PATRONI_KUBERNETES_POD_IP):8008                                                                                        |
| `PATRONI_SCOPE`                      | The name of the cluster.                                          | string | Any                             | {{< resource type="cluster" name="name" >}}                                                                              |
| `PATRONI_SUPERUSER_PASSWORD`         | The password to use to connect to the database as the superuser.  | string | Any                             | _Random 16 characters_                                                                                                   |
| `PATRONI_admin_OPTIONS`              | The options to use for the admin user.                            | string | Comma separated list of options | createrole,createdb                                                                                                      |
| `PATRONI_admin_PASSWORD`             | The password to use to connect to the database as the admin user. | string | Any                             | _Random 16 characters_                                                                                                   |
| `PGBACKREST_CONFIG`                  | The path to the configuration file for Postgres BackRest.         | string | Any                             | /etc/pgbackrest/pgbackrest.conf                                                                                          |
| `PGDATA`                             | The directory where the database data is stored.                  | string | Any                             | $(PATRONI_POSTGRESQL_DATA_DIR)                                                                                           |
| `PGHOST`                             | The directory of the runnning database                            | string | Any                             | /var/run/postgresql                                                                                                      |
{{< /table >}}
