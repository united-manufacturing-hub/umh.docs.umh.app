---
title: "Access the Database"
content_type: task
description: |
  This page describes how to access the United Manufacturing Hub database to 
  perform SQL operations using a database client, the CLI or Grafana.
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

Grafana, on the other hand, is for visualizing data. It is a good option if
you just want to see the data in a dashboard and don't need to manupulate it.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

### Get the database credentials

If you are not using the CLI, you need to know the database credentials. You can
find them in the **{{< resource type="secret" name="db-psw">}}** Secret. By
default, the username is factoryinsight and the password is changeme.

```bash
...
ALTER USER factoryinsight WITH PASSWORD 'changeme';
...
```

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

### Forward the database port to your local machine

1. From the **Pods** section in {{< resource type="lens" name="name" >}}, find
   the **{{< resource type="pod" name="database" >}}** Pod.
2. In the **Pod Details** window, click the **Forward** button next to the
   postgresql:5432/TCP port.
3. Enter a port number, such as 5432, and click **Start**. You can disable the
   **Open in browser** option if you don't want to open the port in your browser.

### Using pgAdmin

You can use [pgAdmin](https://www.pgadmin.org/) to access the database. To do so,
you need to install the pgAdmin client on your machine. For more information, see
the [pgAdmin documentation](https://www.pgadmin.org/docs/pgadmin4/latest/index.html).

Once you have installed the client, you can add a new server from the main window.

![pgAdmin main window](/images/administration/pgadmin-main-window.png)

In the **General** tab, give the server a meaningful name. In the **Connection**
tab, enter the database credentials:

- The **Host name/address** is localhost.
- The **Port** is the port you forwarded.
- The **Maintenance database** is postgres.
- The **Username** and **Password** are the ones you found in the Secret.

Click **Save** to save the server.

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

## Access the database using Grafana

You can use Grafana to visualize data from the database.

### Add PostgreSQL as a data source

1. Open the Grafana dashboard in your browser.
2. From the **Configuration** (gear) icon, select **Data Sources**.
3. Click **Add data source** and select PostgreSQL.
4. Configure the connection to the database:

   - The **Host** is {{< resource type="service-cluster" name="database" >}}.
   - The **Database** is factoryinsight.
   - The **User** and **Password** are the ones you found in the Secret.
   - Set **TLS/SSL Mode** to require.
   - Enable **TimescaleDB**.

   Everything else can be left as the default.

   ![Grafana PostgreSQL data source](/images/administration/grafana-postgresql-data-source.png)
5. Click **Save & Test** to save the data source.
6. Now click on **Explore** to start querying the database.
7. You can also create dashboards using the newly created data source.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See a list of [SQL commands](https://www.postgresql.org/docs/current/sql-commands.html)
- See how to [Delete Assets from the Database](/docs/administration/delete-assets/)
- See how to [Reduce the Database Size](/docs/administration/reduce-database-size/)
- See how to [Backup and Restore the Database](TODO)
- See how to [Expose Grafana to the Internet](/docs/administration/expose-grafana-to-internet/)
