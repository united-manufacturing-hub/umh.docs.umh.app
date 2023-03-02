---
title: "Explore Cached Data"
content_type: task
description: |
  This page shows how to explore cached data in the United Manufacturing Hub.
weight: 90
---

<!-- overview -->

When working with the United Manufacturing Hub, you might want to visualize
information about the cached data. This page shows how you can access the cache
and explore the data.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Open a shell in the cache Pod

1. Open {{< resource type="lens" name="name" >}} and navigate to the **Config** >
   **Secrets** page.
2. Get the cache password from the Secret **{{< resource type="secret" name="cache-psw" >}}**.
3. From the **Pods** section click on **{{% resource type="pod" name="cache" %}}**
   to open the details page.

   {{< notice note >}}
   If you have multiple cache Pods, you can select any of them.
   {{< /notice >}}
4. {{< include "pod-shell.md" >}}
5. Enter the shell:

    ```bash
    redis-cli -a <cache-password>
    ```

6. Now you can execute any command. For example, to get the number of keys in
   the cache, run:

    ```bash
    KEYS *
    ```

   Or, to get the cache size, run:

    ```bash
    DBSIZE
    ```

For more information about Redis commands, see the [Redis documentation](https://redis.io/commands).

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- [Access the database](/docs/production-guides/administration/access-database/)
