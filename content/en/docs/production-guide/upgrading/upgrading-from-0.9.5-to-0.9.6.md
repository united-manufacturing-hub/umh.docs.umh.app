---
title: "Upgrading v0.9.5 to v0.9.6"
description: "During the Helm Hart upgrade from v0.9.5 to 0.9.6 the following steps need to executed additionally to the following guide."
minimum_version: 0.9.5
maximum_version: 0.9.6
---

## Instructions on upgrading

During the Helm chart upgrade from v0.9.5 to 0.9.6 the following steps need to executed additionally to the following guide:

[**Upgrading the Helm Chart**](/docs/production-guide/upgrading/upgrading-helm-chart)

# Adding another index to processValueTable

This release also adds another index to the processValueTable, allowing for faster query times in Grafana.

To manually create the index, execute the following SQL statement.

```sql
CREATE INDEX ON processvaluetable(valuename, asset_id) WITH (timescaledb.transaction_per_chunk);
REINDEX TABLE processvaluetable;
```

Note: the last command can take a while to complete, especially on large tables.

Afterwards, you can close the shell
