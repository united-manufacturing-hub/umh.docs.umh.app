---
title: "Grafana"
content_type: microservices
description: |
    The technical documentation of the grafana microservice,
    which is a web application that provides visualization and analytics capabilities.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="grafana" >}}`
- Service:
  - External LoadBalancer: `{{< resource type="service" name="grafana" >}}` at
    port 8080
- ConfigMap: `{{< resource type="configmap" name="grafana" >}}`
- Secret: `{{< resource type="secret" name="grafana" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="grafana" >}}`

## {{% heading "configuration" %}}

Grafana is configured through its user interface. The default credentials are
found in the {{< resource type="secret" name="grafana" >}} Secret.

The Grafana installation that is provided by the United Manufacturing Hub is
shipped with a set of preinstalled plugins:

- ACE.SVG by Andrew Rodgers
- Button Panel by CloudSpout LLC
- [Button Panel](/docs/architecture/microservices/grafana-plugins/factoryinput-panel/) by UMH Systems Gmbh
- Discrete by Natel Energy
- Dynamic Text by Marcus Olsson
- FlowCharting by agent
- Pareto Chart by isaozler
- Pie Chart (old) by Grafana Labs
- Timepicker Buttons Panel by williamvenner
- [UMH Datasource](/docs/architecture/microservices/grafana-plugins/umh-datasource) by UMH Systems Gmbh
- UMH Datasource v2 by UMH Systems Gmbh
- Untimely by factry
- Worldmap Panel by Grafana Labs

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                               | Description                                                                     | Type   | Allowed values       | Default                                                 |
| ------------------------------------------- | ------------------------------------------------------------------------------- | ------ | -------------------- | ------------------------------------------------------- |
| `FACTORYINSIGHT_APIKEY`                     | The API key to use to authenticate to the Factoryinsight API                    | string | Any                  | _Base64 encoded string_                                 |
| `FACTORYINSIGHT_BASEURL`                    | The base URL of the Factoryinsight API                                          | string | Any                  | {{< resource type="service" name="factoryinsight" >}}   |
| `FACTORYINSIGHT_CUSTOMERID`                 | The customer ID to use to authenticate to the Factoryinsight API                | string | Any                  | factoryinsight                                          |
| `FACTORYINSIGHT_PASSWORD`                   | The password to use to authenticate to the Factoryinsight API                   | string | Any                  | _Random UUID_                                           |
| `GF_PATHS_DATA`                             | The path where Grafana will store its data                                      | string | Any                  | /var/lib/grafana/data                                   |
| `GF_PATHS_LOGS`                             | The path where Grafana will store its logs                                      | string | Any                  | /var/log/grafana                                        |
| `GF_PATHS_PLUGINS`                          | The path where Grafana will store its plugins                                   | string | Any                  | /var/lib/grafana/plugins                                |
| `GF_PATHS_PROVISIONING`                     | The path where Grafana will store its provisioning configuration                | string | Any                  | /etc/grafana/provisioning                               |
| `GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS` | List of plugin identifiers to allow loading even if they lack a valid signature | string | Comma separated list | umh-datasource,umh-factoryinput-panel,umh-v2-datasource |
| `GF_SECURITY_ADMIN_PASSWORD`                | The password of the admin user                                                  | string | Any                  | _Random UUID_                                           |
| `GF_SECURITY_ADMIN_USER`                    | The username of the admin user                                                  | string | Any                  | admin                                                   |
{{< /table >}}
