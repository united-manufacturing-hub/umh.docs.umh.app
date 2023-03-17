---
title: "Change VerneMQ ACL Configuration"
content_type: task
description: |
    This page describes how to change the ACL configuration to allow more users
    to publish to the MQTT broker
weight: 50
maximum_version: 0.9.5
---

<!-- overview -->

<!-- steps -->

## Change VerneMQ ACL configuration

1. Open {{< resource type="lens" name="name" >}}
2. Navigate to **Helms** > **Releases**.
3. Select the {{< resource type="helm" name="release" >}} release and click **Upgrade**.
4. Find the `_000_commonConfig.infrastrucutre.mqtt` section.
5. Update the `AclConfig` value to allow unrestricted access, for example:

    ```yaml
    AclConfig: |
      pattern # allow all
    ```

6. Click **Upgrade** to apply the changes.

You can find more information about the ACL configuration in the
[VerneMQ documentation](https://docs.vernemq.com/configuring-vernemq/file-auth#managing-the-acl-entries).
