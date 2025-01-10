---
title: "Advanced Installation"
content_type: task
description: |
    Additional requirements and considerations when installing the United Manufacturing Hub on a virtual machine.
weight: 40
---

<!-- overview -->

This page describes advanced requirements and considerations when installing the United Manufacturing Hub.
It is meant to be an additinal guide for the [Installation guide](/docs/getstarted/installation) page.

## Storage Configuration

When setting up your virtual machine for UMH:

**Partition Layout**
   - The default Rocky Linux installation typically creates a large `/home` partition
   - During OS installation, you may use custom partitioning to ensure the root partition (`/`) has sufficient space (<span id="storage-requirements"></span>)

**Install location**
   - The kubernetes data directory is stored in `/var/lib/rancher/k3s` by default.
   - This can be overridden by setting the `K3S_DATA_DIR` environment variable. See [Kubernetes Configuration Variables](#kubernetes-configuration-variables) for more information.


## Virtual Machine Configuration

There are some specific settings that are recommended for the virtual machine:

**Networking**
   - Use a bridged network adapter
   - NAT or host-only adapters will prevent external connections to your instance
   - The VM must be able to:
     - Access the internet for installation and updates
     - Communicate with other devices on your network
     - Accept incoming connections from clients

**Advanced Requirements**

1. **CPU Configuration**
   - Enable CPU virtualization extensions (VT-x/AMD-V) on the host
   - Allocate physical CPU cores rather than virtual cores when possible
   - For production environments, reserve the CPU resources

2. **Memory Settings**
   - Use static memory allocation rather than dynamic/balloon drivers
   - Reserve the memory in the hypervisor to prevent memory swapping

3. **Other Settings**
   - Disable unnecessary virtual hardware (like sound cards, USB controllers)
   - Use paravirtualized drivers when available for better performance


## General Script Control Variables

For advanced users, the following variables can be used to control the behavior of the script:

| Environment Variable          | Script Variable              | Default Value  | Description                                                                                                                                                           |
|-------------------------------|------------------------------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `AUTO_SELECT_EXTERNAL_IP`     | `auto_select_external_ip`    | `false`        | If `true`, automatically pick the first non-loopback network interface and set `EXTERNAL_IP`/`EXTERNAL_IP_INTERFACE`/`EXTERNAL_IP_GATEWAY` based on it.              |
| `GENERAL_IGNORE_ERRORS`       | `ignore_errors`              | `false`        | If `true`, the script will ignore errors and continue, mainly used for troubleshooting.                                                                               |
| `GENERAL_TIMEOUT`             | `TIMEOUT`                    | `120`          | Time in seconds to wait for a process before timing out (default: 2 minutes).                                                                                         |
| `GENERAL_INTERVAL`            | `INTERVAL`                   | `5`            | Interval in seconds to check a process status (default: every 5 seconds).                                                                                             |
| `GENERAL_RETRIES`             | `RETRIES`                    | `10`           | Number of retries for certain checks (default: 10).                                                                                                                   |
| `UNINSTALL`                   | `UNINSTALL`                  | `false`        | If `true`, the script will uninstall the UMH, Companion, and Kubernetes instead of installing them.                                                                   |
| `EXTERNAL_IP`                 | `EXTERNAL_IP`                | (unset)        | Manually set the external IP of the machine.                                                                                                                          |
| `EXTERNAL_IP_INTERFACE`       | `EXTERNAL_IP_INTERFACE`      | (unset)        | Manually set the network interface associated with `EXTERNAL_IP`.                                                                                                     |
| `EXTERNAL_IP_GATEWAY`         | `EXTERNAL_IP_GATEWAY`        | (unset)        | Manually set the default gateway associated with `EXTERNAL_IP_INTERFACE`.                                                                                             |
| `DNS_SERVER`                  | `DNS_SERVER`                 | (unset)        | Manually set the DNS server to be used by mgmtcompanion.                                                                                                              |

---

## Tooling Installation Variables

| Environment Variable              | Script Variable                    | Default Value                           | Description                                                                                                                |
|-----------------------------------|------------------------------------|-----------------------------------------|----------------------------------------------------------------------------------------------------------------------------|
| `TOOL_K3S_VERSION`                | `INSTALL_K3S_VERSION`              | `v1.29.5+k3s1`                          | Specifies the version of k3s to be installed.                                                                              |
| `TOOL_K3S_SELINUX_VERSION`        | `INSTALL_K3S_SELINUX_VERSION`      | `k3s-selinux-1.5-1.el9.noarch.rpm`      | Specifies the version (or RPM) of k3s SELinux policy to install on RHEL systems.                                           |
| `TOOL_KUBECTL_VERSION`            | `INSTALL_KUBECTL_VERSION`          | `v1.29.5`                               | Specifies the version of `kubectl` to be installed.                                                                        |
| `TOOL_HELM_VERSION`               | `INSTALL_HELM_VERSION`             | `v3.13.2`                               | Specifies the version of `helm` to be installed.                                                                           |
| `TOOL_K3S_CUSTOM_TLS_SAN`         | `CUSTOM_TLS_SAN`                   | (unset)                                 | Custom TLS Subject Alternative Names for k3s. For example, `IP addresses` or a domain name for TLS certificates.           |
| `TOOL_K3S_KUBECONFIG`             | `KUBECONFIG`                       | `/etc/rancher/k3s/k3s.yaml`             | Path to the kubeconfig file to be used by `kubectl`, `helm`, etc.                                                         |

---

## Kubernetes Configuration Variables

| Environment Variable    | Script Variable          | Default Value                       | Description                                                                                                                         |
|-------------------------|--------------------------|-------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------|
| `KUBE_NODE_NAME`        | `NODE_NAME`             | Uses the system’s hostname          | Node name in the Kubernetes cluster.                                                                                                |
| `AUTO_PATCH_HOSTNAME`   | `auto_patch_hostname`    | `false`                             | If `true`, automatically sets the system hostname to `NODE_NAME` without user confirmation.                                         |
| (Set internally)        | `INSTALL_K3S_EXEC`       | (constructed dynamically)           | Internal variable to pass additional flags (like `--tls-san`) during k3s installation. This is auto-generated; not usually set directly. |
| `K3S_DATA_DIR`                | `K3S_DATA_DIR`                      | k3s default (`/var/lib/rancher/k3s` or `${HOME}/.rancher/k3s` if not root)                | Specifies the data directory for k3s by setting the [`--data-dir`](https://docs.k3s.io/cli/server#data) flag.  |


---

## Speedtest Configuration Variables

| Environment Variable          | Script Variable    | Default Value   | Description                                                                                                                      |
|-------------------------------|--------------------|-----------------|----------------------------------------------------------------------------------------------------------------------------------|
| `SPEEDTEST_MIN_DOWNLOAD`      | `MIN_DOWNLOAD`     | `50000000`      | Minimum download speed in bits per second (default: 50 Mbps).                                                                    |
| `SPEEDTEST_MIN_UPLOAD`        | `MIN_UPLOAD`       | `10000000`      | Minimum upload speed in bits per second (default: 10 Mbps).                                                                      |
| `SPEEDTEST_MIN_PING`          | `MIN_PING`         | `50`            | Maximum ping in milliseconds (default: 50).                                                                                      |
| (Script-internal)             | `MEASURED_UPLOAD`  | `0`             | Automatically set by script after running speed test; not typically set by the user.                                            |
| (Script-internal)             | `MEASURED_DOWNLOAD`| `0`             | Automatically set by script after running speed test; not typically set by the user.                                            |
| (Script-internal)             | `MEASURED_PING`    | `0`             | Automatically set by script after running speed test; not typically set by the user.                                            |

---

## UMH Installation Variables

| Environment Variable    | Script Variable         | Default Value                                            | Description                                                                                                                              |
|-------------------------|-------------------------|----------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------|
| `UMH_SKIP_INSTALL`      | `skip_umh_install`      | `false`                                                  | If `true`, skips the installation of the United Manufacturing Hub (UMH).                                                                 |
| `UMH_FORCE_OVERWRITE`   | `force_umh_overwrite`   | `false`                                                  | If `true`, forces overwriting an existing UMH installation without prompting the user.                                                   |
| `UMH_VERSION`           | `UMH_VERSION`           | `0.27.0`                                                 | Specifies which version of the UMH chart to install.                                                                                      |
| `UMH_HELM_CHART_URL`    | `UMH_HELM_CHART_URL`    | `https://management.umh.app/helm/umh`                    | The URL of the UMH Helm chart repository.                                                                                                 |
| `ALLOW_HELM_PRERELEASE` | `ALLOW_HELM_PRERELEASE` | `false`                                                  | If `true`, allows Helm to install pre-release versions of UMH.                                                                            |
| `IS_LITE_INSTALL`       | `IS_LITE_INSTALL`       | `false`                                                  | If `true`, installs a “lite” version of UMH; forcibly sets `skip_umh_install` to true.                                                   |
| `IS_FULL_INSTALL`       | `IS_FULL_INSTALL`       | `true`                                                   | True if installing the “full” version of UMH. Note that it becomes `false` if `IS_LITE_INSTALL` is `true`.                                |

---

## Management Companion Installation Variables

| Environment Variable                       | Script Variable                              | Default Value                       | Description                                                                                                                                                                |
|--------------------------------------------|----------------------------------------------|-------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `MGMT_AUTH_TOKEN`                          | `AUTH_TOKEN`                                 | (unset)                             | **Required**. A 64-character hex string (256-bit) used by the Management Companion for authentication.                                                                     |
| `MGMT_INSECURE_TLS_SKIP_CERTIFICATE_CHECK` | `insecure_tls_skip_certificate_check`         | `false`                             | If `true`, skip TLS certificate checks. Useful in development or if you have a proxy intercepting traffic.                                                                 |
| `MGMT_CUSTOM_URL`                          | `CUSTOM_MGMT_URL`                            | `https://management.umh.app`        | A custom management URL for specialized setups.                                                                                                                            |
| `MGMT_CUSTOM_IMAGE_VERSION`                | `IMAGE_VERSION`                              | `latest`                            | Custom version tag for the Management Companion Docker image (e.g., `staging`).                                                                                            |
| `MGMT_SKIP_INSTALL`                        | `skip_companion_install`                     | `false`                             | If `true`, skips the installation of the Management Companion.                                                                                                              |
| `MGMT_SKIP_RHEL_SHA1_SIGNATURES`           | `SKIP_RHEL_SHA1_SIGNATURES`                  | `false`                             | On RHEL-based systems, if `true`, does not temporarily enable SHA1 signatures (needed for some older packages).                                                            |
| `MGMT_CONFIG_DEBUG_DISABLE_BACKEND_CONNECTION` | `MGMT_CONFIG_DEBUG_DISABLE_BACKEND_CONNECTION` | `false`                             | Disables the backend connection for debugging.                                                                                                                             |
| `MGMT_API_URL`                             | `API_URL`                                    | `$CUSTOM_MGMT_URL/api`             | API endpoint used by the Management Companion to communicate with the UMH backend.                                                                                         |
| `MGMT_STATIC_URL`                          | `STATIC_URL`                                 | `$CUSTOM_MGMT_URL/static`           | URL for static resources (Kubernetes YAML files, etc.).                                                                                                                     |
| `MGMT_CONFIGMAP_URL`                       | `CONFIGMAP_URL`                              | `$STATIC_URL/kubernetes/configmap.yaml`    | Location of the companion’s ConfigMap YAML.                                                                                                                         |
| `MGMT_SECRET_URL`                          | `SECRET_URL`                                 | `$STATIC_URL/kubernetes/secret.yaml`        | Location of the companion’s Secret YAML.                                                                                                                            |
| `MGMT_STATEFULSET_URL`                     | `STATEFULSET_URL`                            | `$STATIC_URL/kubernetes/statefulset.yaml`   | Location of the companion’s StatefulSet YAML.                                                                                                                       |
| `MGMT_ROLE_URL`                            | `ROLE_URL`                                   | `$STATIC_URL/kubernetes/role.yaml`          | Location of the companion’s Role YAML.                                                                                                                             |
| `MGMT_ROLE_BINDING_URL`                    | `ROLE_BINDING_URL`                           | `$STATIC_URL/kubernetes/rolebinding.yaml`    | Location of the companion’s RoleBinding YAML.                                                                                                                      |
| `MGMT_PVC_URL`                             | `PVC_URL`                                    | `$STATIC_URL/kubernetes/pvc.yaml`           | Location of the companion’s PVC YAML.                                                                                                                              |
| `MGMT_KUBELET_URL`                         | `KUBELET_URL`                                | `$STATIC_URL/kubernetes/kubelet-config.yaml` | Location of the Kubelet configuration YAML.                                                                                                                        |
| `MGMT_REGISTRIES_URL`                      | `REGISTRIES_URL`                             | `$STATIC_URL/kubernetes/registries.yaml`     | Custom Docker registry configuration for k3s.                                                                                                                       |

---

## Location Variables

| Environment Variable        | Script Variable            | Default Value | Description                                                       |
|-----------------------------|----------------------------|---------------|-------------------------------------------------------------------|
| `LOCATION_ENTERPRISE`       | `LOCATION_ENTERPRISE`      | (unset)       | Enterprise name/location for site identification.                 |
| `LOCATION_SITE`             | `LOCATION_SITE`            | (unset)       | Site name/location for site identification.                       |
| `LOCATION_AREA`             | `LOCATION_AREA`            | (unset)       | Area name/location for site identification.                       |
| `LOCATION_LINE`             | `LOCATION_LINE`            | (unset)       | Production line name/location for site identification.            |
| `LOCATION_WORKCELL`         | `LOCATION_WORKCELL`        | (unset)       | Workcell name/location for site identification.                   |

---

## Additional Installation Options

| Environment Variable      | Script Variable         | Default Value | Description                                                                                                                                      |
|---------------------------|-------------------------|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| `SILENT`                  | `SILENT`                | `false`       | If `true`, the script proceeds without interactive confirmations (all prompts default to “yes”).                                                 |
| `SKIP_HARDWARE_TEST`      | `SKIP_HARDWARE_TEST`    | `false`       | If `true`, skip hardware checks (CPU cores, memory, disk space, SSE4.2). Useful for dev or limited resource machines.                             |
| `DISABLE_HARDWARE_STATUS_CHECK` | `DISABLE_HARDWARE_STATUS_CHECK` | `false` | If `true`, skip or ignore hardware checks in the status messages.                                                                                |

---

## Release Channel

| Environment Variable | Script Variable   | Default Value | Description                                                                             |
|----------------------|-------------------|---------------|-----------------------------------------------------------------------------------------|
| `RELEASE_CHANNEL`    | `RELEASE_CHANNEL` | `stable`      | Channel to use for UMH updates/notifications. Options: `enterprise`, `stable`, `nightly`|

---

## Helm Flags

| Environment Variable    | Script Variable          | Default Value  | Description                                                                                                       |
|-------------------------|--------------------------|----------------|-------------------------------------------------------------------------------------------------------------------|
| (Set internally)        | `CHART_VERSION`          | `UMH_VERSION`  | Used by the script to pass `--version` to Helm when installing the UMH chart.                                     |
| `SAME_TOPIC_EXPERIENCE` | `SAME_TOPIC_EXPERIENCE`  | `false`        | If `true`, uses the same Kafka topic across certain analytics solutions (internal optional feature).              |

---

## Environment Variables for Testing and Troubleshooting

These variables let you run only portions of the script for debugging:

| Environment Variable       | Default | Description                                                                     |
|----------------------------|---------|---------------------------------------------------------------------------------|
| `INSTALL_HELM`            | `false` | If `true`, **only** executes the Helm installation portion of the script.       |
| `UNINSTALL_HELM`          | `false` | If `true`, **only** executes the Helm uninstallation portion of the script.     |
| `INSTALL_KUBECTL`         | `false` | If `true`, **only** executes the kubectl installation portion of the script.    |
| `UNINSTALL_KUBECTL`       | `false` | If `true`, **only** executes the kubectl uninstallation portion of the script.  |
| `INSTALL_KUBERNETES`      | `false` | If `true`, **only** installs k3s (and does pre-checks).                          |
| `UNINSTALL_KUBERNETES`    | `false` | If `true`, **only** uninstalls k3s (and does relevant cleanup).                 |

---

## Other Internal Variables

Below variables are set or used internally and typically do **not** need to be overridden:

- `temp_dir` (Defaults to `/tmp/mgmt-installer`)  
- `SENTRY_DSN` (Used for error reporting to Sentry)  
- `INSTALL_HELM` / `UNINSTALL_HELM` (See testing & troubleshooting table)  
- `INSTALL_KUBECTL` / `UNINSTALL_KUBECTL` (See testing & troubleshooting table)  
- `INSTALL_KUBERNETES` / `UNINSTALL_KUBERNETES` (See testing & troubleshooting table)

---

### How to Override Variables

To override any variable, simply export it before running the script, or prepend it on the command line. For example:

```bash
export UMH_VERSION="0.28.1"
export MGMT_AUTH_TOKEN="0123456789abcdef..."
export SILENT="true"
./install.sh
```

Or in a single line:

```bash
export UMH_VERSION="0.28.1" && export MGMT_AUTH_TOKEN="0123456789abcdef..." && export SILENT="true" && ./install.sh
```
