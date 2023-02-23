---
title: Execute SQL commands in the database
content_type: task
description: |
  This page describes how to execute SQL commands directly in the United
  Manufacturing Hub database.
weight: 50
---

<!-- overview -->
This page describes how to execute SQL commands directly in the United
Manufacturing Hub database.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Open the database shell

{{< include "open-database-shell.md" >}}

5. Execute any SQL commands. For example, to create an index on the processValueTable:

   ```sql
   CREATE INDEX ON processValueTable (valuename);
   ```

6. Exit the postgres shell:

   ```bash
   exit
   ```

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [SQL commands](https://www.postgresql.org/docs/current/sql-commands.html)
- See United Manufacturing Hub [database schema](/docs/datamodel/TODO)
