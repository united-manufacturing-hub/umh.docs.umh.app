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
- The current Helm values for the united-manufacturing-hub chart
- All timescale tables used by the {{< resource type="helm" name="release" >}} chart
- All the contents of the United Manufacturing Hub database

It does **not** back up:
- Additional databases other the the United Manufacturing Hub default database
- TimescaleDB continuous aggregates: If you want to back them up, please follow [this guide](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-continuous-aggregates)
- TimescaleDB policies: If you want to back them up, please follow [this guide](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-policies)
- Everything else not included in the previous list

  {{% notice warning %}}
  This procedure only works on windows
  {{% /notice %}}

## {{% heading "prerequisites" %}}

Download the [backup](https://github.com/united-manufacturing-hub/backup/archive/refs/heads/main.zip) repository and create a folder where you unzip it.

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
1. In {{< resource type="lens" name="name" >}} go to the **StatefulSets** tab.
2. Select the {{< resource type="statefulset" name="kafkabroker" >}} statefulset and scale it down to 0.

    ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/lensStopStatefulServices.png?width=75%)
3. Repeat the process for the {{< resource type="statefulset" name="mqttbroker" >}} statefulset.

### Generate Grafana API Key

Create a Grafana API Token for an admin user by following these steps:
- login to Grafana
- click on **settings** -> **API keys**

  ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/grafanaSettingsApiKey.png?)
- create a new API-key and change its role to **Admin**.

  ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/ApiKeycahngeRole.png?)

### Backup using the script

This table gives you an overview of all available script parameters.

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


1. Open a terminal and navigate to the folder containing the script. 
````powershell
cd <LOCATION_OF_FOLDER>
````
2. Execute the script with your desired parameters.

   ```powershell
   .\backup.ps1 -IP <IP_OF_THE_SERVER_TO_BACK_UP> -GrafanaToken <YOUR_GRAFANA_API_ADMIN_TOKEN> -KubeconfigPath <PATH_TO_KUBECONFIG> -OutputPath <PATH_TO_LOTS_OF_SPACE>
   ```
   {{% notice note %}}
   If the **OutputPath** is not set, the backup will be stored in the current folder.
   {{% /notice %}}

3. Wait until the backup is created. This can take a while and your PC needs to stay awake and connected to the server.

   {{% notice warning %}}
   If the connection is interrupted, there is currently no option to resume the process, therefore you will need to start again.
   {{% /notice %}}

## Restore

There are four different scripts to restore different components of the United Manufacturing Hub. Each of these scripts
need to be executed separately. 
Open a terminal and navigate to the backup folder using:
````powershell
cd <LOCATION_OF_FOLDER>
````

### Restore cluster configuration
To restore **Helm** execute the **.\restore-helm.ps1** script with the following parameters:

   ```powershell
   .\restore-helm.ps1 -KubeconfigPath <PATH_TO_KUBECONFIG_OF_THE_NEW_SERVER> -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ```
Wait after the Helm restore is done and for all pods to be running again.

### Restore Grafana dashboards
Execute **.\restore-grafana.ps1** to restore Grafana.

   ````powershell
   .\restore-grafana.ps1 -FullUrl http://<IP_OF_YOUR_NEW_SERVER>:8080 -Token <YOUR_GRAFANA_API_ADMIN_TOKEN_ON_THE_NEW_SERVER> -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ````

### Restore Node-RED flows

Execute **.\restore-nodered.ps1** to restore Node-RED.

   ````powershell
   .\restore-nodered.ps1 -KubeconfigPath <PATH_TO_KUBECONFIG_OF_THE_NEW_SERVER> -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ````

### Restore the database

Execute **.\restore-timescale.ps1** to restore the database.

   ````powershell
   .\restore-timescale.ps1 -Ip <IP_OF_YOUR_NEW_SERVER> -BackupPath <FULL_PATH_TO_BACKUP_FOLDER> -PatroniSuperUserPassword <TIMESCALEDB_SUPERUSERPASSWORD>
   ````

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}
- [UMH-Backup repository](https://github.com/united-manufacturing-hub/backup)
- [backup and restore database](/docs/production-guide/backup_recovery/backup-restore-database/)
- [import and export Node-RED flows](/docs/production-guide/backup_recovery/import-export-node-red-flows/)