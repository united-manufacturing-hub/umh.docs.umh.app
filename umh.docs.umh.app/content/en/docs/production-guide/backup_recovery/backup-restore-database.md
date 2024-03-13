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
installed on your machine. Make sure that its version is compatible with the version
installed on the UMH.

Also, enough free space is required on your machine to store the backup. To check
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

2. Run the following command to backup pre-data, which includes table and schema 
definitions, as well as information on sequences, owners, and settings:

   ```bash
   pg_dump -U factoryinsight -h <remote-host> -p 5432 -Fc -v --section=pre-data --exclude-schema="_timescaledb*" -f dump_pre_data.bak factoryinsight
   ```

   Then, enter your password. The default for factoryinsight is `changeme`.

   - `<remote-host>` is the server's IP where the database (UMH instance) is running.

   {{% notice note %}}

   The output of the command does not include Timescale-specific schemas. 

   {{% /notice %}}

3. Run the following command to connect to the factoryinsight database:

   ```bash
   psql "postgres://factoryinsight:<password>@<server-IP>:5432/factoryinsight?sslmode=require"
   ```

   The default password is `changeme`.

4. Check the table list running `\dt` and run the following command for each table 
to save all data to `.csv` files:

   ```sql
   \COPY (SELECT * FROM <TABLE_NAME>) TO <TABLE_NAME>.csv CSV
   ```

### Grafana and umh_v2 database

If you want to backup the Grafana or umh_v2 database, you can follow the same steps 
as above, but you need to replace any occurence of `factoryinsight` with `grafana`.

In addition, you need to write down the credentials in the
{{< resource type="secret" name="grafana" >}} Secret, as they are necessary
to access the dashboard after restoring the database.

The default username for `umh_v2` database is `kafkatopostgresqlv2`, and the password is 
`changemetoo`. 

## Restoring the database


For this section, we assume that you are restoring the data to a fresh United
Manufacturing Hub installation with an empty database.

### Temporarly disable kafkatopostrgesql, kafkatopostgresqlv2, and factoryinsight

Since `kafkatopostrgesql`, `kafkatopostgresqlv2`, and `factoryinsight` microservices 
might write actual data into the database while restoring it, they should be 
disabled. Connect to your server via SSH and run the following command: 

<!-- tested in e2e #1343 -->
```bash
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresql" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml;
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresqlv2" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml;
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="factoryinsight" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

### Restore the database

This section shows an example for restoring factoryinsight. If you want to restore 
`grafana`, you need to replace any occurence of `factoryinsight` with `grafana`.

For `umh_v2`, you should use `kafkatopostgresqlv2` for the user name and 
`changemetoo` for the password.

1. Make sure that your device is connected to server via SSH and run the following command:

   {{< include "open-database-shell" >}}

2. Drop the existing database:

   ```sql
   DROP DATABASE factoryinsight;
   ```

3. Create a new database:

   ```sql
   CREATE DATABASE factoryinsight;
   \c factoryinsight
   CREATE EXTENSION IF NOT EXISTS timescaledb;
   ```

4. Put the database in maintenance mode:

   ```sql
   SELECT timescaledb_pre_restore();
   ```

5. Now, open a new terminal and restore schemas except Timescale-specific schemas 
with the following command:

   ```bash
   pg_restore -U factoryinsight -h 10.13.47.205 -p 5432 --no-owner -Fc -v -d factoryinsight <path-to-dump_pre_data.bak>
   ```


6. Connect to the database:

    ```bash
   psql "postgres://factoryinsight:<password>@<server-IP>:5432/factoryinsight?sslmode=require"
   ```

7. Restore hypertables:
   - Commands for factoryinsight:
      ```sql
      SELECT create_hypertable('productTagTable', 'product_uid', chunk_time_interval => 100000);
      SELECT create_hypertable('productTagStringTable', 'product_uid', chunk_time_interval => 100000);
      SELECT create_hypertable('processValueStringTable', 'timestamp');
      SELECT create_hypertable('stateTable', 'timestamp');
      SELECT create_hypertable('countTable', 'timestamp');
      SELECT create_hypertable('processValueTable', 'timestamp');
      ```
   - Commands for umh_v2
      ```sql
      SELECT create_hypertable('tag', 'timestamp');
      SELECT create_hypertable('tag_string', 'timestamp');
      ```
   - Grafana database does not have hypertables by default.

8. Run the following SQL commands for each table to restore data into database:

   ```sql
   \COPY <table-name> FROM '<table-name>.csv' WITH (FORMAT CSV);
   ```

6. Go back to the terminal connected to the server and take the database out of 
maintenance mode. Make sure that the databsae shell is open:

   ```sql
   SELECT timescaledb_post_restore();
   ```

### Enable kafkatopostgresql, kafkatopostgresqlv2, and factoryinsight

Run the following command to enable `kafkatopostgresql`, `kafkatopostgresqlv2`, and `factoryinsight`:

<!-- tested in e2e #1343 -->
```bash
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresql" >}} --replicas=1 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml;
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="kafkatopostgresqlv2" >}} --replicas=1 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml;
sudo $(which kubectl) scale deployment {{< resource type="deployment" name="factoryinsight" >}} --replicas=2 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See the official [TimescaleDB migration guide](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/)
- See the official [pg_dump documentation](https://www.postgresql.org/docs/current/app-pgdump.html)
