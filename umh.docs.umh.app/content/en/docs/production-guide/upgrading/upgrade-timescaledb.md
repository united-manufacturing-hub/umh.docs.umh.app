---
title: "Upgrading TimescaleDB on UMH"
content_type: task
description: |
    This page describes how to upgrade TimescaleDB on your existing instances.
weight: 2700
---

<!-- overview -->
In this guide, you will learn how to upgrade TimescaleDB from 2.8.0 to 2.9.1 
(UMH v0.13.6 to the latest).

## {{% heading "prerequisites" %}}

<!-- Use the include shortcode for the prerequisites, depending
     on the type of task. For example, if the task happens after installation,
     use the {{< include "task-aftinst-prereqs.md" >}} shortcode, and if the
     task happens before installation, use the {{< include "task-befinst-prereqs.md" >}}
     shortcode. If the task has no prerequisites, delete the {{% heading "prerequisites" %}}
-->

<!-- If you set the minimum_version or maximum_version parameter in the page's
     front matter, add the version check shortcode {{< version-check >}}.
-->

{{< include "task-aftinst-prereqs.md" >}}

Make sure that your instance's version is v0.13.6. To upgrade your instance, 
refer to [our upgrading guide](/docs/production-guide/upgrading/0.13.4/).

{{% notice note %}}
You do not need to back up and restore your data for this upgrade.
You can find more information in [the release note](https://docs.timescale.com/about/latest/release-notes/past-releases/)
and [the upgrade guide](https://docs.timescale.com/self-hosted/latest/upgrades/minor-upgrade/#plan-your-upgrade)
provided by TimescaleDB.
{{% /notice %}}

## Upgrade TimescaleDB
The upgrade process of UMH will also upgrade the Chart of TimescaleDB, but you have to update 
TimescaleDB extensions manually. The following steps are needed to be done to update them.

1. Open a `psql` shell with the following command on your server's terminal (via ssh).

    ```bash
    sudo $(which kubectl) exec -it $(sudo $(which kubectl) get pods --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -l app.kubernetes.io/component=timescaledb -o jsonpath="{.items[0].metadata.name}") --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -- psql -U postgres -X
    ```

    Setting `-X` flag prevents any `.psqlrc` commands from accidentally triggering the load of 
    a previous TimescaleDB version on session startup.

2. You should be connected `postgres` database now. The following command should be executed for each 
database except `template0`.

    ```sql
    ALTER EXTENSION timescaledb UPDATE;
    ```

    To check the installed version, run

    ```sql
    \dx timescaledb
    ```
3. For the `postgres` database, run the following command to update the TimescaleDB Toolkit extension.

    ```sql
    ALTER EXTENSION timescaledb_toolkit UPDATE;
    ```