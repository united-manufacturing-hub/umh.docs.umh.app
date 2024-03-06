---
title: "Migrate to Data Model V1"
content_type: task
description: |
    This page describes how to migrate your existing instances from the old Data Model to the new Data Model V1.
weight: 2500
edition: community
---

<!-- overview -->
In this guide, you will learn how to migrate your existing instances from the
[old Data Model](/docs/datamodel_old) to the [new Data Model V1](/docs/datamodel).

The old Data Model will continue to work, and all the data will be still available.

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

<!-- steps -->

## Upgrade Your Companion to the Latest Version

If you haven't already, upgrade your Companion to the latest version. You can
easily do this from the Management Console by selecting your Instance and
clicking on the "Upgrade" button.

## Upgrade the Helm Chart

The new Data Model was introduced in the 0.10 release of the Helm Chart. To upgrade
to the latest 0.10 release, you first need to update the Helm Chart to the latest
0.9 release and then upgrade to the latest 0.10 release.

There is no automatic way (yet!) to upgrade the Helm Chart, so you need to follow
the manual steps below.

First, after accessing your instance, find the Helm Chart version you are currently
using by running the following command:

```bash
sudo $(which helm) get metadata united-manufacturing-hub -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml | grep -e ^VERSION
```

Then, head to the [upgrading archive](/docs/production-guide/upgrading/archive)
and follow the instructions to upgrade from your current version to the latest
version, one version at a time.
