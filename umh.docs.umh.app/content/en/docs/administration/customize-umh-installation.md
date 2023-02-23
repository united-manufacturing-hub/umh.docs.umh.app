---
title: "Customize the United Manufacturing Hub Installation"
content_type: task
description: |
  This page describes how to customize the United Manufacturing Hub installation.
weight: 50
---

<!-- overview -->

When you install the United Manufacturing Hub, it is deployed with default settings,
that are mostly suitable for a learning environment. However, if you want to use
the United Manufacturing Hub in a production environment, you might want to customize
the installation.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Customize the United Manufacturing Hub installation via {{< resource type="lens" name="name" >}}

Independently of the installation method you choose, you can customize the United
Manufacturing Hub installation by changing the Helm chart values.

To do so after installing the United Manufacturing Hub, you can open {{< resource type="lens" name="name" >}} and
navigate to the **Helm** > **Releases** page. Then, click on the **Upgrade**
button and edit the values in the `_000_commonConfig_` section.

You can also edit the values in the following sections, but be aware that you
should really know what you are doing, as you might break the installation.

To get more information about the values you can change, see the
[Helm chart documentation](https://learn.umh.app/docs/core/helmchart/).

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}