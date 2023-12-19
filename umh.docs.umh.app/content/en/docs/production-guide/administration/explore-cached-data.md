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

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Open a shell in the cache Pod

Get access to the instance's shell and execute the following commands.

1. Get the cache password

   ```bash
   sudo $(which kubectl) get secret {{< resource type="secret" name="cache" >}} -n united-manufacturing-hub -o go-template='{{range $k,$v := .data}}{{printf "%s: " $k}}{{if not $v}}{{$v}}{{else}}{{$v | base64decode}}{{end}}{{"\n"}}{{end}}'  --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```

2. Open a shell in the Pod:

   ```bash
   sudo $(which kubectl) exec -it {{< resource type="pod" name="cache" >}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -- /bin/sh
   ```

   {{< notice note >}}
   If you have multiple cache Pods, you can select any of them.
   {{< /notice >}}

3. Enter the Redis shell:

    ```bash
    redis-cli -a <cache-password>
    ```

4. Now you can execute any command. For example, to get the number of keys in
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

- [Access the database](/docs/production-guide/administration/access-database/)
