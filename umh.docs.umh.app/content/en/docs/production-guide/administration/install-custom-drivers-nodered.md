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

1. From the StatefulSets section in {{< resource type="lens" name="name" >}}, click on **{{% resource type="statefulset" name="nodered" %}}**
   to open the details page.
2. {{< include "statefulset-edit.md" >}}
3. Press `Ctrl+F` and search for `securityContext`.
4. Set the values of the `runAsUser` field to 0, of `fsGroup` to 0, and of
   `runAsNonRoot` to false.

   ```yaml
   ...
          securityContext:
            runAsUser: 0
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      securityContext:
        runAsUser: 0
        runAsNonRoot: false
        fsGroup: 0
   ...
   ```

5. Click **Save**.

## Install the packages

1. From the Pods section in {{< resource type="lens" name="name" >}}, click on **{{% resource type="pod" name="nodered" %}}**
   to open the details page.
2. {{< include "pod-shell.md" >}}
3. Install the packages with `apk`:

   ```bash
   apk add <package>
   ```

   For example, to install `unixodbc`:

   ```bash
   apk add unixodbc
   ```

   You can find the list of available packages [here](https://pkgs.alpinelinux.org/packages).

4. Exit the shell.

## Revert the security context

For security reasons, you should revert the security context after you install
the packages.

1. From the StatefulSets section in {{< resource type="lens" name="name" >}}, click on **{{% resource type="statefulset" name="nodered" %}}**
   to open the details page.
2. {{< include "statefulset-edit.md" >}}
3. Set the values of the `runAsUser` field to 1000, of `fsGroup` to 1000, and of
   `runAsNonRoot` to true.

   ```yaml
   ...
          securityContext:
            runAsUser: 1000
      restartPolicy: Always
      terminationGracePeriodSeconds: 30
      dnsPolicy: ClusterFirst
      securityContext:
        runAsUser: 1000
        runAsNonRoot: true
        fsGroup: 1000
   ...
   ```

4. Click **Save**.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}
