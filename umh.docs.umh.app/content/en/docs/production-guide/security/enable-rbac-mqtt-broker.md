---
title:  Enable RBAC for the MQTT Broker
content_type: task
description: |
    This page describes how to enable Role-Based Access Control (RBAC) for the
    MQTT broker.
weight: 50
minimum_version: 0.9.10
aliase:
    - /docs/production-guide/security/hivemq-rbac/
---

<!-- overview -->

<!-- steps -->

## Enable RBAC

1. Open {{< resource type="lens" name="name" >}}
2. Navigate to **Helm** > **Releases**.
3. Select the {{< resource type="helm" name="release" >}} release and click **Upgrade**.
4. Find the `mqtt_broker` section.
5. Locate the `rbacEnabled` parameter and change its value from `false` to `true`.
6. Click **Upgrade**.

Now all MQTT connections require password authentication with the following defaults:

- Username: `node-red`
- Password: `INSECURE_INSECURE_INSECURE`

## Change default credentials

1. Open {{< resource type="lens" name="name" >}}
2. Navigate to **Workloads** > **Pods**.
3. Select the {{< resource type="pod" name="mqttbroker" >}} Pod.
4. {{< include "pod-shell" >}}
5. Navigate to the installation directory of the RBAC extension.

   ```bash
   cd extensions/hivemq-file-rbac-extension/
   ```

6. Generate a password hash with this command.

   ```bash
   java -jar hivemq-file-rbac-extension-<version>.jar -p <password>
   ```

   - Replace `<version>` with the version of the HiveMQ CE extension. If you are
     not sure which version is installed, you can press `Tab` after typing
     `java -jar hivemq-file-rbac-extension-` to autocomplete the version.
   - Replace `<password>` with your desired password. Do not use any whitespaces.
7. Copy the output of the command. It should look similar to this:

   ```bash
   $2a$10$Q8ZQ8ZQ8ZQ8ZQ8ZQ8ZQ8Zu
   ```

8. Navigate to **Config** > **ConfigMaps**.
9. Select the {{< resource type="configmap" name="mqttbroker-credentials" >}} ConfigMap.
10. Click the **Edit** button to open the ConfigMap editor.
11. In the `data.credentials.xml` section, replace the strings inbetween the
    `<password>` tags with the password hash generated in step 7.
12. Click **Save** to apply the changes.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- [Setting up HiveMQ PKI](/docs/production-guide/security/setup-pki-mqtt-broker/)
