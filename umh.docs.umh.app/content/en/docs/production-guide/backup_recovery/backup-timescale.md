+++
title =  "Backing up the database"
description = "Learn how to backup the database"
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

## Further reading

For more information, please refer to the following resources:

- [TimescaleDB backup guide](https://docs.timescale.com/timescaledb/latest/how-to-guides/backup-and-restore/pg-dump-and-restore/)
- [pg_dump documentation](https://www.postgresql.org/docs/current/app-pgdump.html)
