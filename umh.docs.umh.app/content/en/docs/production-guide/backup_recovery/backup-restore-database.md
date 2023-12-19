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
installed on your machine.

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

2. Run the following command:

   ```bash
   pg_dump -h <REMOTE_HOST> -p 5432 -U factoryinsight -Fc -f <BACKUP_NAME>.bak factoryinsight
   ```

   - `<REMOTE_HOST>` is the IP of the server where the database is running.
     Use `localhost` if you installed the United Manufacturing Hub using k3d.
   - `<BACKUP_NAME>` is the name of the backup file.

### Grafana database

If you want to backup the Grafana database, you can follow the same steps as
above, but you need to replace any occurence of `factoryinsight` with
`grafana`.

Additionally, you also need to write down the credentials in the
{{< resource type="secret" name="grafana" >}} Secret, as they will be needed
to access the dashboard after restoring the database.

## Restoring the database

{{< notice warning >}}
This section is untested. Please report any issues you encounter.
{{< /notice >}}

For this section, we assume that you are restoring the data to a fresh United
Manufacturing Hub installation with an empty database.

### Copy the backup file to the database pod

1. Open {{< resource type="lens" name="name" >}}.
2. Launch a new terminal sesstion by clicking on the **+** button in the
   bottom-left corner of the window.
3. Run the following command to copy the backup file to the database pod:

   ```bash
   kubectl cp /path/to/local/backup.bak {{< resource type="pod" name="database" >}}:/tmp/backup.bak
   ```

   Replace `/path/to/local/backup.bak` with the path to the backup file on your
   machine.

This step could take a while depending on the size of the backup file.

### Temporarly disable kafkatopostrgesql

1. Navigate to **Workloads** > **Deployments**.
2. Select the {{< resource type="deployment" name="kafkatopostgresql" >}} Deployment.
3. {{< include "deployment-scale" >}}
4. Scale the number of replicas to 0.

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

1. Navigate to **Workloads** > **Deployments**.
2. Select the {{< resource type="deployment" name="kafkatopostgresql" >}} Deployment.
3. {{< include "deployment-scale" >}}
4. Scale the number of replicas to the original value, usually 1.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See the official [TimescaleDB backup guide](https://docs.timescale.com/timescaledb/latest/how-to-guides/backup-and-restore/pg-dump-and-restore/)
- See the official [pg_dump documentation](https://www.postgresql.org/docs/current/app-pgdump.html)
