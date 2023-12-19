---
title: "Access the Database"
content_type: task
description: |
  This page describes how to access the United Manufacturing Hub database to 
  perform SQL operations using a database client or the CLI.
weight: 11
---

<!-- overview -->

There are multiple ways to access the database. If you want to just visualize data,
then using Grafana or a database client is the easiest way. If you need to also
perform SQL commands, then using a database client or the CLI are the best options.

Generally, using a database client gives you the most flexibility, since you can
both visualize the data and manipulate the database. However, it requires you to
install a database client on your machine.

Using the CLI gives you more control over the database, but it requires you to
have a good understanding of SQL.

Grafana comes with a pre-configured PostgreSQL datasource, so you can use it to
visualize the data.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

### Get the database credentials

If you are not using the CLI, you need to know the database credentials. You can
find them in the **{{< resource type="secret" name="db-psw">}}** Secret. Run the
following command to get the credentials:

```bash
sudo $(which kubectl) get secret {{< resource type="secret" name="db-psw">}} -n united-manufacturing-hub -o go-template='{{range $k,$v := .data}}{{if eq $k "1_set_passwords.sh"}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{"\n"}}{{end}}{{end}}'  --kubeconfig /etc/rancher/k3s/k3s.yaml
```

This command will print an SQL script that contains the username and password
for the different databases.

<!-- steps -->

## Access the database using a database client

There are many database clients that you can use to access the database. Here's
a list of some of the most popular database clients:

{{< table caption="Database clients" >}}
| Name                                            | Free or Paid | Platforms             |
| :---------------------------------------------- | :----------- | :-------------------- |
| [pgAdmin](https://www.pgadmin.org/)             | Free         | Windows, macOS, Linux |
| [DataGrip](https://www.jetbrains.com/datagrip/) | Paid         | Windows, macOS, Linux |
| [DBeaver](https://dbeaver.io/)                  | Both         | Windows, macOS, Linux |
{{< /table >}}

For the sake of this tutorial, pgAdmin will be used as an example, but other clients
have similar functionality. Refer to the specific client documentation for more
information.

### Using pgAdmin

You can use [pgAdmin](https://www.pgadmin.org/) to access the database. To do so,
you need to install the pgAdmin client on your machine. For more information, see
the [pgAdmin documentation](https://www.pgadmin.org/docs/pgadmin4/latest/index.html).

1. Once you have installed the client, you can add a new server from the main window.

   ![pgAdmin main window](/images/administration/pgadmin-main-window.png)

2. In the **General** tab, give the server a meaningful name. In the **Connection**
   tab, enter the database credentials:

   - The **Host name/address** is the IP address of your instance.
   - The **Port** is 5432.
   - The **Maintenance database** is postgres.
   - The **Username** and **Password** are the ones you found in the Secret.

3. Click **Save** to save the server.

   ![pgAdmin connection window](/images/administration/pgadmin-connection-window.png)

You can now connect to the database by double-clicking the server.

Use the side menu to navigate through the server. The tables are listed under
the **Schemas** > **public** > **Tables** section of the factoryinsight database.

Refer to the [pgAdmin documentation](https://www.pgadmin.org/docs/pgadmin4/latest/index.html)
for more information on how to use the client to perform database operations.

## Access the database using the command line interface

You can access the database from the command line using the `psql` command
directly from the **{{< resource type="pod" name="database" >}}** Pod.

You will not need credentials to access the database from the Pod's CLI.

The following steps need to be performed from the machine where the cluster is
running, either by logging into it or by using a remote shell.

### Open a shell in the database Pod

{{< include "open-database-shell.md" >}}

### Perform SQL commands

Once you have a shell in the database, you can perform
[SQL commands](https://www.postgresql.org/docs/current/sql-commands.html).

1. For example, to create an index on the processValueTable:

   ```sql
   CREATE INDEX ON processvaluetable (valuename);
   ```

2. When you are done, exit the postgres shell:

   ```bash
    exit
    ```

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See a list of [SQL commands](https://www.postgresql.org/docs/current/sql-commands.html)
- See how to [Delete Assets from the Database](/docs/production-guide/administration/delete-assets/)
- See how to [Reduce the Database Size](/docs/production-guide/administration/reduce-database-size/)
- See how to [Backup and Restore the Database](/docs/production-guide/backup_recovery/backup-timescale)
- See how to [Expose Grafana to the Internet](/docs/production-guide/administration/expose-grafana-to-internet/)
