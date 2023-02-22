+++
title =  "Enabling RBAC for MQTT Broker"
description = "This article explains how to enable [Role-Based Access Control](https://en.wikipedia.org/wiki/Role-based_access_control) (_RBAC_) for the MQTT broker."
minimum_version = "0.9.10"
+++

## Enabling RBAC

1. Go to the **Releases** tab in Lens.
2. Select the release and click **Upgrade**. This opens the values file.
3. Find the `mqtt_broker` section.
4. Locate the `rbacEnabled` parameter and change its value from `false` to `true`.
5. Click **Upgrade**.


Now all MQTT connections require password authentication with the following defaults:

- Username: `node-red`
- Password: `INSECURE_INSECURE_INSECURE`


## Changing the default credentials

1. Open the shell of the HiveMQ pod in Lens.
2. Navigate to the installation directory of the RBAC extension.

   ```bash
   cd extensions/hivemq-file-rbac-extension/
   ```

3. Generate a password hash with this command.

   ```bash
    java -jar hivemq-file-rbac-extension-<version>.jar -p <password>
    ```

    Please replace `password` with your desired password without any whitespaces, and replace the version of the HiveMQ CE extension with `version`.
    If you're not sure which version is installed, you can press `Tab` after typing `java -jar hivemq-file-rbac-extension-` to cycle through the available versions.

4. Copy the generated hash.
5. Open the `united-manufacturing-hub-hivemqce-extension` ConfigMap.

   ![RbacConfigMap](/images/production-guide/security/hivemq-rbac/rbac-configmap.png)

6. Replace the password hash with the one generated in step 3.
7. Save the changes.