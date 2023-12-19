---
title: "Install Custom Drivers in NodeRed"
content_type: task
description: |
  This page describes how to install custom drivers in NodeRed.
weight: 23
---

<!-- overview -->

NodeRed is running on Alpine Linux as non-root user. This means that you can't
install packages with `apk`. This tutorial shows you how to install packages
with proper security measures.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Change the security context

From the instance's shell, execute this command:

```bash
sudo $(which kubectl) patch statefulset {{% resource type="statefulset" name="nodered" %}} -n united-manufacturing-hub -p '{"spec":{"template":{"spec":{"securityContext":{"runAsUser":0,"runAsNonRoot":false,"fsGroup":0}}}}}' --kubeconfig /etc/rancher/k3s/k3s.yaml
```

## Install the packages

1. Open a shell in the {{% resource type="pod" name="nodered" %}} pod with:

      ```bash
      sudo $(which kubectl) exec -it {{% resource type="pod" name="nodered" %}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -- /bin/sh
      ```

2. Install the packages with `apk`:

   ```bash
   apk add <package>
   ```

   For example, to install `unixodbc`:

   ```bash
   apk add unixodbc
   ```

   You can find the list of available packages [here](https://pkgs.alpinelinux.org/packages).

3. Exit the shell by typing `exit`.

## Revert the security context

For security reasons, you should revert the security context after you install
the packages.

From the instance's shell, execute this command:

```bash
sudo $(which kubectl) patch statefulset {{% resource type="statefulset" name="nodered" %}} -n united-manufacturing-hub -p '{"spec":{"template":{"spec":{"securityContext":{"runAsUser":1000,"runAsNonRoot":true,"fsGroup":1000}}}}}' --kubeconfig /etc/rancher/k3s/k3s.yaml
```

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}
