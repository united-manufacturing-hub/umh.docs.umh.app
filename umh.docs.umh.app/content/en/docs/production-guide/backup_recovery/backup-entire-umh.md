+++
title = "Backup and Restore the United Manufacturing Hub"
menuTitle = "Backup and Restore the UMH"
description = "This page describes how to backup and restore the entire UMH."
weight = 1000
+++

This page describes how to back up the following:
 - All Node-RED flows
 - All Grafana dashboards
 - The current Helm values for the united-manufacturing-hub chart
 - All timescale tables used by the united-manufacturing-hub chart

It does **not** back up:
 - Other grafana data like Alerts, Users, ...
 - Timescale data unrelated to the united-manufacturing-hub chart 
 - Any other data in the cluster 
 - TimescaleDB continuous aggregates: If you want to back them up, please follow [this guide](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-continuous-aggregates)
 - TimescaleDB policies: If you want to back them up, please follow [this guide](https://docs.timescale.com/self-hosted/latest/migration/schema-then-data/#recreate-policies)
    

## Requirements

1. Stop stateful services -> kafka/redpanda and HiveMQ to prevent inconsistencies in the dataset.

   ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/lensStopStatefulServices.png?width=75%)
2. Create a Grafana API Token for an admin user:
   - login to Grafana
   - click on **settings** -> **API keys**
   
     ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/grafanaSettingsApiKey.png?)
   - create a new API-key and change its role to **Admin**.
   
     ![Untitled](/images/production-guide/backup_recovery/backup-entire-umh/ApiKeycahngeRole.png?)
   
3. Download the [backup](https://github.com/united-manufacturing-hub/backup) repository. 
4. Make sure you have postgresql installed.



## Backup

1. Open a Terminal inside the repository folder.
2. In this folder, there are multiple powershell scripts. To create a full backup use the **backup.ps1** script. 
   The following parameters are available for this script:
   - IP <String> :IP of the cluster
   - GrafanaPort <String> :External port of the Grafana service
   - GrafanaToken <String> :Grafana API token
   - DatabasePassword <String> :Password of the database user. If default user (factoryinsight) is used, the default password is changeme
   - DatabasePort <Int32> :External port of the database
   - DatabaseUser <String> :Database user
   - DatabaseDatabase <String> :Database name
   - KubeconfigPath <String> :Path to the kubeconfig file
   - SkipDiskSpaceCheck <Boolean> :Skip disk space check
   - OutputPath <String> :Output path
   - ParallelJobs <Int32> :Parallel jobs
   - DaysPerJob <Int32> :Days per job
   - EnableGpgSigning <Boolean> :Enable GPG signing
   - GpgSigningKeyId <String> :GPG signing key ID
   - EnableGpgEncryption <Boolean> :Enable GPG encryption
   - GpgEncryptionKeyId <String> :GPG encryption key ID
   - SkipGpgQuestions <Boolean> :Skip GPG questions
3. Execute the script with your desired parameters.

   ```
   .\backup.ps1 `
   -IP <IP_OF_THE_SERVER_TO_BACK_UP> `
   -GrafanaToken <YOUR_GRAFANA_API_ADMIN_TOKEN> `
   -KubeconfigPath <PATH_TO_KUBECONFIG> `
   -OutputPath <PATH_TO_LOTS_OF_SPACE>
   ```
   {{% notice note %}}
   The minimal required parameters are the Ip of the server, grafana API token and the kubeconfig path.
   If the **OutputPath** is not set, the backup will be stored in the current folder.
   {{% /notice %}}

4. Wait until the backup is created. This can take a while and your PC needs to stay awake and connected to the server.
   {{% notice warning %}}
   If the connection is interrupted, there is currently no script to continue from the last checkpoint.
   {{% /notice %}}

## Restore

1. Open a terminal inside the backup repository folder.
2. To restore **Helm** execute the **.\restore-helm.ps1** script with the following parameters:

   ```powershell
   .\restore-helm.ps1 `
   -KubeconfigPath <PATH_TO_KUBECONFIG_OF_THE_NEW_SERVER> `
   -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ```
3. Wait after the Helm restore is done and for all pods to be running again.
4. Execute **.\restore-grafana.ps1** to restore Grafana.
   
   ````powershell
   .\restore-grafana.ps1 `
   -FullUrl http://<IP_OF_YOUR_NEW_SERVER>:8080 `
   -Token <YOUR_GRAFANA_API_ADMIN_TOKEN_ON_THE_NEW_SERVER> `
   -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ````
   
5. Next restore Node-RED with the **.\restore-nodered.ps1** script.

   ````powershell
   .\restore-nodered.ps1 `
   -KubeconfigPath <PATH_TO_KUBECONFIG_OF_THE_NEW_SERVER> `
   -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ````
   
6. Restore TimescaleDB with the script **.\restore-timescale.ps1**

   ````powershell
   .\restore-timescale.ps1 `
   -Ip <IP_OF_YOUR_NEW_SERVER> `
   -BackupPath <FULL_PATH_TO_BACKUP_FOLDER> `
   -PatroniSuperUserPassword <TIMESCALEDB_SUPERUSERPASSWORD>
   ````

## Further reading

For more information, please refer to the following resources:

- [UMH-Backup repository](https://github.com/united-manufacturing-hub/backup)
