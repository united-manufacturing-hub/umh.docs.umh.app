---
title: "Optimize Time Consuming Queries"
content_type: task
description: |
  This page shows how to optimize the database in order to reduce the time needed 
  to execute queries.
weight: 100
minimum_version: 0.9.4
maximum_version: 0.9.6
---

<!-- overview -->

When you have a large database, it is possible that some queries take a long time
to execute. This especially shows when you are using Grafana and the dropdown
menu in the datasource takes a long time to load or does not load at all.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

{{< version-check >}}

<!-- steps -->

## Open a shell in the database container

{{< include "open-database-shell.md" >}}

Connect to the `factoryinsight` database:

```bash
\c factoryinsight
```

## Create an index

Indexes are used to speed up queries. Run this query to create an index on the
`processvaluetable` table:

   ```sql
   CREATE INDEX ON processvaluetable(valuename, asset_id) WITH (timescaledb.transaction_per_chunk);
   ```

## Rollback factoryinsight

If you have already created an index, you can rollback the factoryinsight deployment
to version 0.9.4. This way it will use a less optimized but faster query, significantly
reducing the execution time.

From the instance's shell, run the following command:

```bash
sudo $(which helm) upgrade united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub --set factoryinsight.image.tag=0.9.4 -n united-manufacturing-hub --reuse-values --version $(sudo $(which helm) get metadata united-manufacturing-hub -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -o json | jq '.version') --kubeconfig /etc/rancher/k3s/k3s.yaml
```

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access the Database](/docs/production-guide/administration/access-database/)
- See [Reduce Database Size](/docs/production-guide/administration/reduce-database-size/)
