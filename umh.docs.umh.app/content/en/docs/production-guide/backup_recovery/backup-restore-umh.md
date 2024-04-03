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
- All the contents of the United Manufacturing Hub database (`factoryinsight` and `umh_v2`)
- The Management Console Companion's settings

It does **not** back up:
- Additional databases other than the United Manufacturing Hub default database
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
the size of the database, ssh into the system and follow the steps below:

{{< include "open-database-shell" >}}

 Run the following command to get the size of the database:

```sql
SELECT pg_size_pretty(pg_database_size('umh_v2')) AS "umh_v2", pg_size_pretty(pg_database_size('factoryinsight')) AS "factoryinsight";
```

<!-- steps -->
## Backup

### Generate Grafana API Key

Create a Grafana API Token for an admin user by following these steps:
1. Open the Grafana UI in your browser and log in with an admin user.
2. Click on the **Configuration** icon in the left sidebar and select **API Keys**.
3. Give the API key a name and change its role to **Admin**.
4. Optionally set an expiration date.
5. Click **Add**.
6. Copy the generated API key and save it for later.

### Stop workloads

To prevent data inconsistencies, you need to temporarily stop the MQTT and Kafka Brokers.

Access the instance's shell and execute the following commands:

<!-- tested in e2e #1343 -->
```bash
sudo $(which kubectl) scale statefulset {{< resource type="statefulset" name="kafkabroker" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
sudo $(which kubectl) scale statefulset {{< resource type="statefulset" name="mqttbroker" >}} --replicas=0 -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

### Copy kubeconfig file

To run the backup script, you'll first need to obtain a copy of the Kubernetes 
configuration file from your instance. This is essential for providing the 
script with access to the instance.

1. In the shell of your instance, execute the following command to display the 
Kubernetes configuration:

   ```bash
   sudo cat /etc/rancher/k3s/k3s.yaml
   ```

   Make sure to copy the entire output to your clipboard.

   {{% notice tip %}}
   This tutorial is based on the assumption that your kubeconfig file is located 
   at /etc/rancher/k3s/k3s.yaml. Depending on your setup, the actual file location 
   might be different.
   {{% /notice %}}

2. Open a text editor, like Notepad, on your local machine and paste the copied content.
3. In the pasted content, find the server field. It usually defaults to `https://127.0.0.1:6443`. 
Replace this with your instance's IP address

    ```yaml
    server: https://<INSTANCE_IP>:6443
    ```

4. Save the file as `k3s.yaml` inside the `backup` folder you downloaded earlier.

### Backup using the script

The backup script is located inside the folder you downloaded earlier.

1. Open a terminal and navigate inside the folder.

   ```powershell
   cd <FOLDER_PATH>
   ```

2. Run the script:

   ```powershell
   .\backup.ps1 -IP <IP_OF_THE_SERVER> -GrafanaToken <GRAFANA_API_KEY> -KubeconfigPath .\k3s.yaml
   ```

   You can find a list of all available parameters down below.

   {{% notice info %}}
   If `OutputPath` is not set, the backup will be stored in the current folder.
   {{% /notice %}}

This script might take a while to finish, depending on the size of your database
and your connection speed.

{{% notice warning %}}
If the connection is interrupted, there is currently no option to resume the process, therefore you will need to start again.
{{% /notice %}}

Here is a list of all available parameters:

{{< table caption="Available parameters" >}}
| Parameter             | Description                                                 | Required | Default value    |
| --------------------- | ----------------------------------------------------------- | -------- | ---------------- |
| `GrafanaToken`        | Grafana API key                                             | Yes      |                  |
| `IP`                  | IP of the cluster to backup                                 | Yes      |                  |
| `KubeconfigPath`      | Path to the kubeconfig file                                 | Yes      |                  |
| `DatabaseDatabase`    | Name of the databse to backup                               | No       | factoryinsight   |
| `DatabasePassword`    | Password of the database user                               | No       | changeme         |
| `DatabasePort`        | Port of the database                                        | No       | 5432             |
| `DatabaseUser`        | Database user                                               | No       | factoryinsight   |
| `DaysPerJob`          | Number of days worth of data to backup in each parallel job | No       | 31               |
| `EnableGpgEncryption` | Set to `true` if you want to encrypt the backup             | No       | `false`          |
| `EnableGpgSigning`    | Set to `true` if you want to sign the backup                | No       | `false`          |
| `GpgEncryptionKeyId`  | ID of the GPG key used for encryption                       | No       |                  |
| `GpgSigningKeyId`     | ID of the GPG key used for signing                          | No       |                  |
| `GrafanaPort`         | External port of the Grafana service                        | No       | 8080             |
| `OutputPath`          | Path to the folder where the backup will be stored          | No       | _Current folder_ |
| `ParallelJobs`        | Number of parallel job backups to run                       | No       | 4                |
| `SkipDiskSpaceCheck`  | Skip checking available disk space                          | No       | `false`          |
| `SkipGpgQuestions`    | Set to `true` if you want to sign or encrypt the backup     | No       | `false`          |
{{< /table >}}

## Restore

Each component of the United Manufacturing Hub can be restored separately, in
order to allow for more flexibility and to reduce the damage in case of a
failure.

### Copy kubeconfig file

To run the restore script, you'll first need to obtain a copy of the Kubernetes 
configuration file from your instance. This is essential for providing the 
script with access to the instance.

1. In the shell of your instance, execute the following command to display the 
Kubernetes configuration:

   ```bash
   sudo cat /etc/rancher/k3s/k3s.yaml
   ```

   Make sure to copy the entire output to your clipboard.

   {{% notice tip %}}
   This tutorial is based on the assumption that your kubeconfig file is located 
   at /etc/rancher/k3s/k3s.yaml. Depending on your setup, the actual file location 
   might be different.
   {{% /notice %}}

2. Open a text editor, like Notepad, on your local machine and paste the copied content.
3. In the pasted content, find the server field. It usually defaults to `https://127.0.0.1:6443`. 
Replace this with your instance's IP address

    ```yaml
    server: https://<INSTANCE_IP>:6443
    ```

4. Save the file as `k3s.yaml` inside the `backup` folder you downloaded earlier.

### Cluster configuration
To restore the Kubernetes cluster, execute the `.\restore-helm.ps1` script with
the following parameters:

```powershell
.\restore-helm.ps1 -KubeconfigPath .\k3s.yaml -BackupPath <PATH_TO_BACKUP_FOLDER>
```

Verify that the cluster is up and running by using the command
```bash
sudo $(which kubectl) get pods -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

### Grafana dashboards
To restore the Grafana dashboards, you first need to create a Grafana API Key
for an admin user in the new cluster by following these steps:

1. Open the Grafana UI in your browser and log in with an admin user.
2. Click on the **Configuration** icon in the left sidebar and select **API Keys**.
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

   ```powershell
   .\restore-nodered.ps1 -KubeconfigPath .\k3s.yaml -BackupPath <PATH_TO_BACKUP_FOLDER>
   ```

### Restore the database

1. Check the database password by running the following command in your instance's shell:
      ```bash
      sudo $(which kubectl) get secret united-manufacturing-hub-credentials --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -o jsonpath="{.data.PATRONI_SUPERUSER_PASSWORD}" | base64 --decode; echo
      ```

2. Execute the `.\restore-timescale.ps1` and  `.\restore-timescale-v2.ps1` script with the
following parameters to restore `factoryinsight` and `umh_v2` databases:
      ```powershell
      .\restore-timescale.ps1 -Ip <IP_OF_THE_SERVER> -BackupPath <PATH_TO_BACKUP_FOLDER> -PatroniSuperUserPassword <DATABASE_PASSWORD>
      .\restore-timescale-v2.ps1 -Ip <IP_OF_THE_SERVER> -BackupPath <PATH_TO_BACKUP_FOLDER> -PatroniSuperUserPassword <DATABASE_PASSWORD>
      ```

### Restore the Management Console Companion

Execute the `.\restore-companion.ps1` script with the following parameters to restore the companion:
   ```powershell
   .\restore-companion.ps1 -KubeconfigPath .\k3s.yaml -BackupPath <FULL_PATH_TO_BACKUP_FOLDER>
   ```

## Troubleshooting
### Unable to connect to the server: x509: certificate signed ...
This issue may occur when the device's IP address changes from DHCP to static 
after installation. A quick solution is skipping TLS validation. If you want 
to enable `insecure-skip-tls-verify` option, run the following command on 
the instance's shell **before** copying kubeconfig on the server:

   ```bash
   sudo $(which kubectl) config set-cluster default --insecure-skip-tls-verify=true --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```



<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- Take a look at the [UMH-Backup repository](https://github.com/united-manufacturing-hub/backup)
- Learn how to manually [backup and restore the database](/docs/production-guide/backup_recovery/backup-restore-database/)
- Read how to [import and export Node-RED flows](/docs/production-guide/backup_recovery/import-export-node-red-flows/) via the UI