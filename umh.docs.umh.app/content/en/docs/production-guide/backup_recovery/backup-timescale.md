+++
title =  "Backing up the database"
description = "Learn how to backup the database"
draft = true
+++


## Requirements

- Please ensure that you have installed `pg_dump` on your machine.
    - For Windows users, installation of [PostgreSQL](https://www.postgresql.org/download/windows/) is required.
        - Alternatively, you can use [chocolatey](https://chocolatey.org/packages/postgresql) to install it.
    - Linux users can use their package manager to install it.
- We have observed that even small sites can have databases with more than 100GB of data, so please make sure that you have enough space on your machine to store the backup.


## Backup

To store the backup, please follow the below steps:

1. Open a terminal and navigate to the folder where you want to store the backup.
2. Run the following command:

    ```bash
    pg_dump -h <REMOTE_HOST> -p <REMOTE_PORT> -U factoryinsight -Fc -f <BACKUP_NAME>.bak factoryinsight
    ```
   where:
    - `<REMOTE_HOST>` is the hostname of the server where the database is running.
    - `<REMOTE_PORT>` is the port of the database (default is 5432).
    - `<BACKUP_NAME>` is the name of the backup file.

{{< notice info >}}
Postgresql is normally not exposed to the outside.
In this case, you can port-forward it using Lens
{{< /notice >}}

{{< notice note >}}
This will not export the Grafana dashboard password.
These are stored in Kubernetes secrets.
{{< /notice >}}

## Restore

{{< notice warning >}}
This section is untested !
{{< /notice >}}

To restore the backup, we assume that you have a new stack running and the database is empty. Please follow the below steps:

1. Upload the database backup to the server where the database is running.
   ```bash
   kubectl cp <BACKUP_NAME>.bak <timescaledb-pod>:/tmp/<BACKUP_NAME>.bak
   ```

2. Scale the `kafkatopostgres` deployment to 0.
   {{< include "deployment-scale" >}}
3. Open a terminal inside the timescaledb pod
   {{< include "open-database-shell" >}}
4. Delete the auto-generated database
    ```sql
    DROP DATABASE factoryinsight;
    ```
5. Create a new database
    ```sql
    CREATE DATABASE factoryinsight;
    \c factoryinsight
    CREATE EXTENSION IF NOT EXISTS timescaledb;
    ```
6.  Put the database into timescale restore mode
    ```sql
    SELECT timescaledb_pre_restore();
    ```
7. Restore the database
    ```bash
    \! pg_restore -Fc -d factoryinsight /tmp/<BACKUP_NAME>.bak
    ```
8. Put the database back into normal mode
    ```sql
    SELECT timescaledb_post_restore();
    ```


## Further reading

For more information, please refer to the following resources:

- [TimescaleDB backup guide](https://docs.timescale.com/timescaledb/latest/how-to-guides/backup-and-restore/pg-dump-and-restore/)
- [pg_dump documentation](https://www.postgresql.org/docs/current/app-pgdump.html)
