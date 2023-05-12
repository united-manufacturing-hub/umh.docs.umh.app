---
title: "Backup and Restore the United Manufacturing Hub"
content_type: task
description: |
        This page describes how to backup and restore the entire United Manufacturing Hub.
weight: 10
---

<!-- overview -->

This page describes how to back up the following:
- All Node-RED flows
- All Grafana dashboards
- The Helm values used for installing the {{< resource type="helm" name="release" >}} release
- All the contents of the United Manufacturing Hub database

It does **not** back up:
- Additional databases other the the United Manufacturing Hub default database
- TimescaleDB continuous aggregates: Follow the [official documentation](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-continuous-aggregates) to learn how.
- TimescaleDB policies: Follow the [official documentation](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-policies) to learn how.
- Everything else not included in the previous list

{{% notice warning %}}
This procedure only works on Windows.
{{% /notice %}}

## {{% heading "prerequisites" %}}

Download the [backup scripts](https://github.com/united-manufacturing-hub/backup/archive/refs/heads/main.zip) and extract the content in a folder of your choice.

For this task, you need to have [PostgreSQL](https://www.postgresql.org/download/)
installed on your machine.

You also need to have enough space on your machine to store the backup. To check
the size of the database, follow the steps below:

{{< include "open-database-shell" >}}

5. Run the following command to get the size of the database:

    ```sql
    SELECT pg_size_pretty(pg_database_size('factoryinsight'));
    ```

<!-- steps -->
## Backup

### Stop workloads

To prevent data inconsistencies, you need to temporarily stop the MQTT and Kafka Brokers.

1. In {{< resource type="lens" name="name" >}} go to the **Workloads** > **StatefulSets** tab.
2. Select the {{< resource type="statefulset" name="kafkabroker" >}} StatefulSet
3. {{< include "statefulset-scale.md" >}}
4. Set the number of replicas to 0 and click **Scale**.
5. Repeat the process for the {{< resource type="statefulset" name="mqttbroker" >}} StatefulSet.

### Generate Grafana API Key

Create a Grafana API Token for an admin user by following these steps:
1. Open the Grafana UI in your browser and log in with an admin user.
2. Click on the **Settings** icon in the left sidebar and select **API Keys**.
3. Give the API key a name and change its role to **Admin**.
4. Optionally set an expiration date.
5. Click **Add**.
6. Copy the generated API key and save it for later.

### Backup using the script



The backup script is located inside the folder you downloaded earlier.
1. Open a terminal and navigate inside the folder.
    ````powershell
    cd <FOLDER_PATH>
    ````
2. Run the script:

   ```powershell
   .\backup.ps1 -IP <IP_OF_THE_SERVER_TO_BACK_UP> -GrafanaToken <YOUR_GRAFANA_API_ADMIN_TOKEN> -KubeconfigPath <PATH_TO_KUBECONFIG> -OutputPath <PATH_TO_LOTS_OF_SPACE>
   ```
   {{% notice note %}}
   If the **OutputPath** is not set, the backup will be stored in the current folder.
   {{% /notice %}}

This script might take a while to finish, depending on the size of your database
and your connection speed.

   {{% notice warning %}}
   If the connection is interrupted, there is currently no option to resume the process, therefore you will need to start again.
   {{% /notice %}}

Here is a list of all available parameters:

{{< table caption="Available parameters" >}}
| Parameter            | Description                                | Required| type    |    
| -------------------- | ------------------------------------------ | ------- | ------- |
| `IP`                 | IP of the cluster                          | Yes     | String  |
| `GrafanaPort`        | External port of the Grafana service       | No      | String  |
| `GrafanaToken`       | Grafana API token                          | Yes     | String  |
| `DatabasePassword`   | Password of the database user.             | No      | String  |
| `DatabasePort`       | External port of the database              | No      | Int32   |
| `DatabaseUser`       | Database user                              | No      | String  |
| `DatabaseDatabase`   | Database name                              | No      | String  |
| `KubeconfigPath`     | Path to the kubeconfig file                | Yes     | String  |
| `SkipDiskSpaceCheck` | Skip disk space check                      | No      | Boolean |
| `OutputPath`         | Output path                                | No      | String  |
| `ParallelJobs`       | Parallel jobs                              | No      | Int32   |
| `DaysPerJob`         | Days per job                               | No      | Int32   |
| `EnableGpgSigning`   | Enable GPG signing                         | No      | Boolean |
| `GpgSigningKeyId`    | GPG encryption key ID                      | No      | String  |
| `EnableGpgEncryption`| Enable GPG encryption                      | No      | Boolean |
| `GpgEncryptionKeyId` | GPG encryption key ID                      | No      | String  |
| `SkipGpgQuestions`   | Skip GPG questions                         | No      | Boolean |
{{< /table >}}

## Restore

Each component of the United Manufacturing Hub can be restored separately, in
order to allow for more flexibility and to reduce the damage in case of a
failure.

### Cluster configuration
To restore the Kubernetes cluster, execute the `.\restore-helm.ps1` script with
the following parameters:

```powershell
.\restore-helm.ps1 -KubeconfigPath <PATH_TO_KUBECONFIG> -BackupPath <PATH_TO_BACKUP_FOLDER>
```

Verify that the cluster is up and running by opening {{< resource type="lens" name="name" >}}
and checking if the workloads are running.

### Grafana dashboards
To restore the Grafana dashboards, you first need to create a Grafana API Key
for an admin user in the new cluster by following these steps:

1. Open the Grafana UI in your browser and log in with an admin user.
2. Click on the **Settings** icon in the left sidebar and select **API Keys**.
3. Give the API key a name and change its role to **Admin**.
4. Optionally set an expiration date.
5. Click **Add**.
6. Copy the generated API key and save it for later.

Then, on your local machine, execute the `.\restore-grafana.ps1` script
with the following parameters:

   ````powershell
   .\restore-grafana.ps1 -FullUrl http://<IP_OF_THE_SERVER>:8080 -Token <GRAFANA_API_KEY> -BackupPath <PATH_TO_BACKUP_FOLDER>
   ````


### Restore Node-RED flows

To restore the Node-RED flows, execute the `.\restore-nodered.ps1` script with
the following parameters:

   ````powershell
   .\restore-nodered.ps1 -KubeconfigPath <PATH_TO_KUBECONFIG> -BackupPath <PATH_TO_BACKUP_FOLDER>
   ````

### Restore the database

To restore the database, execute the `.\restore-timescale.ps1` script with the
following parameters:

   ````powershell
   .\restore-timescale.ps1 -Ip <IP_OF_THE_SERVER> -BackupPath <PATH_TO_BACKUP_FOLDER> -PatroniSuperUserPassword <DATABASE_PASSWORD>
   ````

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}
- [UMH-Backup repository](https://github.com/united-manufacturing-hub/backup)
- [backup and restore database](/docs/production-guide/backup_recovery/backup-restore-database/)
- [import and export Node-RED flows](/docs/production-guide/backup_recovery/import-export-node-red-flows/)