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

You do not need to back up and restore your data for this upgrade. 

{{% notice note %}}
To get more information, please refer to [the release note](https://docs.timescale.com/about/latest/release-notes/past-releases/)
and [the upgrade guide](https://docs.timescale.com/self-hosted/latest/upgrades/minor-upgrade/#plan-your-upgrade)
of TimescaleDB.
{{% /notice %}}

## Upgrade TimescaleDB


