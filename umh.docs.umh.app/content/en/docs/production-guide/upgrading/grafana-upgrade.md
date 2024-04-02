---
title: "Upgrading Grafana on UMH"
content_type: task
description: |
    This page describes how to upgrade Grafana on your existing instances.
weight: 2600
---

<!-- overview -->
In this guide, you will learn how to upgrade Grafana v9.5.5 to v10.4.0 (UMH v0.13.6 to the latest). 
You can find a change log in [What's new in Grafana v10.4](https://grafana.com/docs/grafana/latest/whatsnew/whats-new-in-v10-4/).

{{% notice warning %}}
This upgrade introduces several breaking changes that may require new configurations, 
yet it maintains backward compatibility. 
Please refer to [Breaking changes in Grafana](https://grafana.com/docs/grafana/latest/breaking-changes/).
{{% /notice %}}

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

## Back up Grafana

This section explains how to back up your Grafana deployment on your UMH instance.

### Back up ConfigMap, Secret, and Deployment

The following steps save the current configuration of grafana. 

1. Run the following command to back up the ConfigMap.
    ```bash
    sudo $(which kubectl) get configmaps -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml  -l app.kubernetes.io/name=grafana -o yaml > grafana-configs-backup.yaml
    ```

2. The following command saves the Secret of grafana.
    ```bash
    sudo $(which kubectl) get secret grafana-secret -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml  -o yaml > grafana-secret-backup.yaml
    ```

3. Back up the Deployment with the following command.
    ```bash
    sudo $(which kubectl) get deployment  -n united-manufacturing-hub -l app.kubernetes.io/name=grafana --kubeconfig /etc/rancher/k3s/k3s.yaml  -o yaml > grafana-deployment-backup.yaml
    ```

If you want to back up configuration files directly, refer to [this page](https://grafana.com/docs/grafana/latest/upgrade-guide/upgrade-v10.4/#back-up-the-grafana-configuration-file).
### Back up plugins

Copy the files of installed plugins by running the following command.

```bash
sudo kubectl exec -n united-manufacturing-hub $(sudo $(which kubectl) get pods --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -l app.kubernetes.io/name=grafana -o jsonpath="{.items[0].metadata.name}") --kubeconfig /etc/rancher/k3s/k3s.yaml -- tar cf - "/var/lib/grafana/plugins" | tar xf -
```

### Back up the Grafana database

The UMH does not require this step by default since the data is stored in our data storage. 
If you use your own database, refer to
[this upgrade guide](https://grafana.com/docs/grafana/latest/upgrade-guide/upgrade-v10.4/#back-up-the-grafana-database) to back up. 

## Upgrade Grafana
You can upgrade your instance by using Management Console, and it upgrades also Grafana. 
After the upgrade, you can restore your settings from the backup files.

### Restore configurations

1. Restore ConfigMap from `grafana-configs-backup.yaml`.
    ```bash
    sudo $(which kubectl) apply -f grafana-configs-backup.yaml -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml 
    ```

2. Restore Secret from `grafana-secret-backup.yaml`.
    ```bash
    sudo $(which kubectl) apply -f grafana-secret-backup.yaml -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml 
    ```

3. Restore Deployment from `grafana-deployment-backup.yaml`.
    ```bash
    sudo $(which kubectl) apply -f grafana-deployment-backup.yaml -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
    ```

{{% notice note %}}
This upgrade keeps your plugins, databases, and also dashboards, so you do not have to restore them.
{{% /notice %}}