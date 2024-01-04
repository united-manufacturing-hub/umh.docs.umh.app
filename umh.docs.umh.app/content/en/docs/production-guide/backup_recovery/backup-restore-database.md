---
title: "Backup and Restore Database"
content_type: task
description: |
    This page describes how to backup and restore the database.
weight: 50
aliases:
   - /docs/production-guide/backup_recovery/backup-timescale/
---

<!-- overview -->

## {{% heading "prerequisites" %}}

For this task, you need to have [PostgreSQL](https://www.postgresql.org/download/)
installed on your machine. Make sure that its version is a compatible with the version
installed on the UMH.

You also need to have enough space on your machine to store the backup. To check
the size of the database, ssh into the system and follow the steps below:

{{< include "open-database-shell" >}}

Connect to the `umh_v2` or `factoryinsight` database:

```bash
\c <database-name>
```

 Run the following command to get the size of the database:

```sql
SELECT pg_size_pretty(pg_database_size('<database-name>'));
```

If you need, check the version of PostgreSQL with this command:

```bash
\! psql --version
```

<!-- steps -->

## Backing up the database

Follow these steps to create a backup of the factoryinsight database on your
machine:

1. Open a terminal, and using the `cd` command, navigate to the folder where
   you want to store the backup. For example:

   {{< tabs name="change-dir" >}}
   {{< tab name="Windows" codelang="powershell" >}}
   cd C:\Users\user\backups
   {{< /tab >}}
   {{< tab name="macOS" codelang="bash">}}
   cd /Users/user/backups
   {{< /tab >}}
   {{< tab name="Linux" codelang="bash" >}}
   cd /home/user/backups
   {{< /tab >}}
   {{< /tabs >}}

   If the folder does not exist, you can create it using the `mkdir` command or
   your file manager.

2. Run the following command to dump the schema pre-data. :

   ```bash
   pg_dump -U factoryinsight -h <remote-host> -p 5432 -Fc -v --section=pre-data --exclude-schema="_timescaledb*" -f dump_pre_data.bak factoryinsight
   ```

   - `<remote-host>` is the IP of the server where the database is running.

   {{% notice note %}}

   The output of the command does not include Timescale-specific schemas. 

   {{% /notice %}}

3. Run the following command to connect to the factoryinsight database:

   ```bash
   psql "postgres://factoryinsight:<password>@<server-IP>:5432/factoryinsight?sslmode=require"
   ```

   The default username for factoryinsight is `factoryinsight` and the password is `changeme`.

4. Check the table list running `\dt` and run the following command for each table to save all data to `.csv` files:

   ```sql
   \COPY (SELECT * FROM <TABLE_NAME>) TO <TABLE_NAME>.csv CSV
   ```

### Grafana and umh_v2 database

If you want to backup the Grafana or umh_v2 database, you can follow the same steps 
as above, but you need to replace any occurence of `factoryinsight` with `grafana`.

Additionally, you also need to write down the credentials in the
{{< resource type="secret" name="grafana" >}} Secret, as they will be needed
to access the dashboard after restoring the database.

The default username for umh_v2 is `kafkatopostgresqlv2` and the password is `changemetoo`.

## Restoring the database


For this section, we assume that you are restoring the data to a fresh United
Manufacturing Hub installation with an empty database.

### Copy the backup file to the database pod

1. Using `scp` (secure copy), save the `.bak` file on the server. If you use 
Windows OS, you need to install it. Run the following command on your local machine:

   ```bash
   scp <path-to-local-.bak-file> <umh-instance-ip>:<save-location-on-server>
   ```

2. Run the following command to copy the backup file to the database pod (on the server):

   ```bash
   sudo $(which kubectl) cp <path-to-host-.bak-file> {{< resource type="pod" name="database" >}}:/tmp/backup.bak -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```

This step could take a while depending on the size of the backup file.

### Temporarly disable kafkatopostrgesql

<!-- tested in e2e #1343 -->
```bash
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresql" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

### Open a shell in the database pod

{{< include "open-database-shell" >}}

### Restore the database

1. Drop the existing database:

   ```sql
   DROP DATABASE factoryinsight;
   ```

2. Create a new database:

   ```sql
   CREATE DATABASE factoryinsight;
   \c factoryinsight
   CREATE EXTENSION IF NOT EXISTS timescaledb;
   ```

3. Put the database in maintenance mode:

   ```sql
   SELECT timescaledb_pre_restore();
   ```

4. Restore the database:

   ```sql
   \! pg_restore -Fc -d factoryinsight /tmp/backup.bak
   ```

5. Take the database out of maintenance mode:

   ```sql
   SELECT timescaledb_post_restore();
   ```

### Enable kafkatopostgresql

<!-- tested in e2e #1343 -->
```bash
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresql" >}} --replicas=1 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

{{% notice note %}}

Also, refer [this documentation](https://docs.timescale.com/self-hosted/latest/migration/entire-database/) 
for larger databases to migrate schema and data separately or to restore your 
hypertables.

{{% /notice %}}

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See the official [TimescaleDB migration guide](https://docs.timescale.com/self-hosted/latest/migration/entire-database/)
- See the official [pg_dump documentation](https://www.postgresql.org/docs/current/app-pgdump.html)
