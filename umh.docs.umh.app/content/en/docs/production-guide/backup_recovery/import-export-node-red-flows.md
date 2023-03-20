---
title: "Import and Export Node-RED Flows"
content_type: task
description: |
    This page describes how to import and export Node-RED flows.
weight: 50
---

<!-- overview -->

<!-- steps -->

## Export Node-RED Flows

To export Node-RED flows, please follow the steps below:

1. Access Node-RED by navigating to `http://<CLUSTER-IP>:1880/nodered` in your
   browser. Replace `<CLUSTER-IP>` with the IP address of your cluster, or
   `localhost` if you are running the cluster locally.
2. From the top-right menu, select **Export**.
3. From the Export dialog, select wich nodes or flows you want to export.
4. Click **Download** to download the exported flows, or **Copy to clipboard** to
   copy the exported flows to the clipboard.

   ![ExportWindow](/images/production-guide/backup_recovery/import-export-node-red/export-nodes.png)

{{< notice warning >}}
The credentials of the connector nodes are not exported. You will need to
re-enter them after importing the flows.
{{< /notice >}}

## Import Node-RED Flows

To import Node-RED flows, please follow the steps below:

1. Access Node-RED by navigating to `http://<CLUSTER-IP>:1880/nodered` in your
   browser. Replace `<CLUSTER-IP>` with the IP address of your cluster, or
   `localhost` if you are running the cluster locally.
2. From the top-right menu, select **Import**.
3. From the Import dialog, select the file containing the exported flows, or
   paste the exported flows from the clipboard.
4. Click **Import** to import the flows.

   ![ImportWindow](/images/production-guide/backup_recovery/import-export-node-red/import-nodes.png)
