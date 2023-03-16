---
title: "Upgrade to v{{ .Name }}"
content_type: upgrading
description: "This page describes how to upgrade the United Manufacturing Hub
to version {{ .Name }}"
weight: 1000
---

This page describes how to upgrade the United Manufacturing Hub to version
{{ .Name }}. Before upgrading, remember to backup the
[database](/docs/production-guide/backup_recovery/backup-timescale/),
[Node-RED flows](/docs/production-guide/backup_recovery/import-export-node-red/),
and your cluster configuration.

## Add Helm repo in {{% resource type="lens" name="name" %}}

Check if the UMH Helm repository is added in {{% resource type="lens" name="name" %}}.
To do so, from the top-left menu, select **FIle** > **Preferences** (or press `CTRL + ,`).
Click on the **Kubernetes** tab and check if the **Helm Chart** section contains
the `https://repo.umh.app` repository.

If it doesn't, click the **Add Custom Helm Repo** button and fill in the following
values:

- Helm repo name: {{% resource type="helm" name="repo" %}}
- URL: {{% resource type="helm" name="repo-url" %}}

Then click **Add**.

<!-- Add here any steps needed before deleting the deployments and statefulsets -->

## Clear Workloads

Some workloads need to be deleted before upgrading. This process _do not_ delete
any data. If a workload is missing, it means that it was not enabled in your
cluster, therefore you can skip it.

To delete a resource, you can select it using the box on the left of the
resource name and click the **-** button on the bottom right corner.

1. Open the **Workloads** tab.
2. From the **Deployment** section, delete the following deployments:
   - {{% resource type="deployment" name="barcodereader" %}}
   - {{% resource type="deployment" name="factoryinsight" %}}
   - {{% resource type="deployment" name="kafkatopostgresql" %}}
   - {{% resource type="deployment" name="mqttkafkabridge" %}}
   - {{% resource type="deployment" name="mqttsimulator" %}}
   - {{% resource type="deployment" name="opcuasimulator" %}}
3. From the **StatefulSet** section, delete the following statefulsets:
   - {{% resource type="statefulset" name="mqttbridge" %}}
   - {{% resource type="statefulset" name="mqttbroker" %}}
   - {{% resource type="statefulset" name="nodered" %}}
   - {{% resource type="statefulset" name="sensorconnect" %}}

<!-- Add here any steps needed before upgrading the Helm Chart -->

## Upgrade Helm Chart

Now everything is ready to upgrade the Helm chart.

1. Navigate to the **Helm** > **Releases** tab.
2. Select the {{% resource type="helm" name="release" %}} release and click
   **Upgrade**.
3. In the **Helm Upgrade** window, make sure that the `Upgrade version` field
   contains the version you want to upgrade to.
4. You can also change the values of the Helm chart, if needed.
   <!-- Add here any changes needed to the values.yaml -->
5. Click **Upgrade**.

The upgrade process can take a few minutes. The upgrade is complete when the
**Status** field of the release is Deployed.

<!-- Add here any steps needed after upgrading the Helm Chart -->