---
title: "Customize the United Manufacturing Hub Installation"
content_type: task
description: |
  This page describes how to customize the United Manufacturing Hub installation.
weight: 10
---

<!-- overview -->

When you install the United Manufacturing Hub, it is deployed with default settings,
that are mostly suitable for a learning environment. However, if you want to use
the United Manufacturing Hub in a production environment, you might want to customize
the installation.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Customize the United Manufacturing Hub installation via {{% resource type="lens" name="name" %}}

Independently of the installation method you choose, you can customize the United
Manufacturing Hub installation by changing the Helm chart values.

1. Open {{< resource type="lens" name="name" >}} and navigate to the **Helm** > **Releases**
   page.
2. Click on the **Upgrade** button
3. Edit the values in the `_000_commonConfig_` section.

You can also edit the values in the subsequent sections, but be aware that you
should really know what you are doing, as you might break the installation.

To get more information about the values you can change, see the
[Helm chart documentation](https://learn.umh.app/docs/core/helmchart/).

## Customize the configuration before the installation {#customize-values}

If you want to save a specific configuration, maybe to reuse it in different
installation, or you want to test some particular combination of settings but
want to start from a fresh cluster each time, you can create your custom
configuration file and use it during the installation.

1. Create a file named `values.yaml`
2. Add your custom configuration, following the
   [Helm chart documentation](/docs/architecture/helm-chart/).
3. Use the `values.yaml` file during the installation by adding the `--values` flag:

    ```powershell
    helm install {{% resource type="helm" name="release" %}} {{% resource type="helm" name="repo" %}}/united-manufacturing-hub -n {{% resource type="ns" name="umh" %}} --values values.yaml
    ```

4. You can also use the `values.yaml` file to customize the installation after
   the installation is complete. To do so, run the following command:

    ```powershell
    helm upgrade {{% resource type="helm" name="release" %}} {{% resource type="helm" name="repo" %}}/united-manufacturing-hub -n {{% resource type="ns" name="umh" %}} --values values.yaml
    ```

Here is an example for a configuration that enables sensorconnect, disables
the simulators and sets the number of replicas of factoryinsight to 1:

```yaml
_000_commonConfig_:
  sensorconnect:
    enabled: true
  iotsensorsmqtt:
      enabled: false
  opcuasimulator:
      enabled: false
  packmlmqttsimulator:
      enabled: false
      
factoryinsight:
  replicas: 1
```

Now you can use the same file in multiple installations, in order to have the
same configuration in each one.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access the Database](/docs/production-guide/administration/access-database)
- See [Change the Language in Factoryinsight](/docs/production-guide/administration/change-factoryinsight-language)
