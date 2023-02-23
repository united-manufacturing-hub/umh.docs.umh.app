---
title: "Access the Database"
content_type: task
description: |
  This page describes how to access the United Manufacturing Hub database to 
  perform SQL operations.
weight: 50
---

<!-- overview -->

There are two main ways to access the database. You can use a database client with
a graphical interface, or you can use the command line interface (recommended
for experienced users).

Both are suitable for performing SQL operations.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

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

### Get the database credentials

To access the database using a database client, you need to know the database
credentials. You can find them in the **{{< resource type="secret" name="db-psw">}}**
Secret. By default, the username is factoryinsight and the password is changeme.

```bash
...
ALTER USER factoryinsight WITH PASSWORD 'changeme';
...
```

You also need to forward the database port to your local machine. To do so, from
the **Pod** tab in {{< resource type="lens" name="name" >}}, click the **{{< resource type="pod" name="database" >}}**
Service. In the **Pod Details** window, click the **Forward** button next to the
postgresql:5432/TCP port. You can choose to use a random port or a specific port.
Click **Start** to forward the port.

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

You can also access the database from the command line using the `psql` command
directly from the **{{< resource type="pod" name="database" >}}** Pod.

{{< include "open-database-shell.md" >}}

5. Execute any SQL commands. For example, to create an index on the processValueTable:

   ```sql
   CREATE INDEX ON processvaluetable (valuename);
   ```

6. Exit the postgres shell:

   ```bash
    exit
    ```

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [SQL commands](https://www.postgresql.org/docs/current/sql-commands.html)
- See how to [Delete Assets from the Database](/docs/administration/delete-assets/)
- See how to [Reduce the Database Size](/docs/administration/reduce-database-size/)
