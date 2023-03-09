+++
title =  "Importing and exporting Node-RED flows"
description = "Learn how to import and export Node-RED flows"
+++


## Exporting Node-RED Flows

To export Node-RED flows, please follow the steps below:

1. If you want to export only a few nodes from a flow, select all the nodes you need. If you want to export all nodes in a flow, skip this step.
2. In Node-RED, click on the three bars on the right side and then click on "Export."

   ![CommandMenu](/images/production-guide/backup_recovery/import-export-node-red/command-menu.png)

3. In the export window, select the format in which you want to export the flow (the default is JSON), and click on **Download**.

   ![ExportWindow](/images/production-guide/backup_recovery/import-export-node-red/export-nodes.png)

{{< notice info >}}
This will not export secrets, such as MQTT credentials, certificates, ...
{{< /notice >}}


## Importing Node-RED Flows

To import Node-RED flows, please follow the steps below:

1. In Node-RED, click on the three bars on the right side and then click on "Import."

   ![CommandMenu](/images/production-guide/backup_recovery/import-export-node-red/command-menu.png)

2. Then, decide in which flow you want the nodes to be pasted - a new flow or the current one.

   ![ImportWindow](/images/production-guide/backup_recovery/import-export-node-red/import-nodes.png)
