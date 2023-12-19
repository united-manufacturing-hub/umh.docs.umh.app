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

Enable RBAC by upgrading the value in the Helm chart.

To do so, run the following command:

```bash
sudo $(which helm) upgrade --set mqtt_broker.rbacEnabled=true united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub -n united-manufacturing-hub --reuse-values --version $(sudo $(which helm) get metadata united-manufacturing-hub -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -o json | jq '.version') --kubeconfig /etc/rancher/k3s/k3s.yaml
```

Now all MQTT connections require password authentication with the following defaults:

- Username: `node-red`
- Password: `INSECURE_INSECURE_INSECURE`

## Change default credentials

1. Open a shell inside the Pod:

   ```bash
   sudo $(which kubectl) exec -it {{< resource type="pod" name="mqttbroker" >}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -- /bin/sh
   ```

2. Navigate to the installation directory of the RBAC extension.

   ```bash
   cd extensions/hivemq-file-rbac-extension/
   ```

3. Generate a password hash with this command.

   ```bash
   java -jar hivemq-file-rbac-extension-<version>.jar -p <password>
   ```

   - Replace `<version>` with the version of the HiveMQ CE extension. If you are
     not sure which version is installed, you can press `Tab` after typing
     `java -jar hivemq-file-rbac-extension-` to autocomplete the version.
   - Replace `<password>` with your desired password. Do not use any whitespaces.
4. Copy the output of the command. It should look similar to this:

   ```bash
   $2a$10$Q8ZQ8ZQ8ZQ8ZQ8ZQ8ZQ8Zu
   ```

5. Exit the shell by typing `exit`.
6. Edit the ConfigMap to update the password hash.

    ```bash
    sudo $(which kubectl) edit configmap {{< resource type="configmap" name="mqttbroker-credentials" >}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
    ```

    This command will open the default text editor with the ConfigMap contents.
    Change the value inbetween the `<password>` tags with the password hash
    generated in step 4.

    {{< notice tip >}}
    You can use a different password for each different microservice. Just
    remember that you will need to update the configuration in each one
    to use the new password.
    {{< /notice >}}

7. Save the changes.
8. Recreate the Pod:

    ```bash
    sudo $(which kubectl) delete pod {{< resource type="pod" name="mqttbroker" >}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
    ```

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- [Setting up HiveMQ PKI](/docs/production-guide/security/setup-pki-mqtt-broker/)
