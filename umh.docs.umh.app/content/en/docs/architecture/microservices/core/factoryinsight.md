---
title: "Factoryinsight"
content_type: concept
description: |
    This section contains the description of the Factoryinsight microservice of
    the United Manufacturing Hub.
weight: 10
---

<!-- overview -->

Factoryinsight is a microservice that provides a set of APIs to access the
data from the database. It is particularly useful to calculate the Key
Performance Indicators (KPIs) of the factories.

## {{% heading "howitworks" %}}

Factoryinsight exposes REST APIs to access the data from the database or calculate
the KPIs. By default, it's only accessible from the internal network of the
cluster, but it can be configured to be
[accessible from the external network](/docs/administration/access-factoryinsight-outside-cluster/).

The APIs require authentication, that can be ehither a Basic Auth or a Bearer
token. Both of these can be found in the Secret `{{< resource type="secret" name="factoryinsight" >}}`.

### API documentation

{{< swaggerui src="/openapi/factoryinsight.yaml" >}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="factoryinsight" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="factoryinsight" >}}` at
    port 80
  - External : [Access factoryinsight outside the cluster](/docs/administration/access-factoryinsight-outside-cluster/)
- Secret: `{{< resource type="secret" name="factoryinsight" >}}`

## {{% heading "configuration" %}}

TODO: describe how to configure

### {{% heading "envvars" %}}

The following environment variables can be set to configure Factoryinsight:

{{< table caption="Environment variables" >}}
| Variable name                | Description                                                                                               | Type   | Allowed values          | Default                                                                             |
| ---------------------------- | --------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | ----------------------------------------------------------------------------------- |
| `CUSTOMER_NAME_{NUMBER}`     | Specifies a user for the REST API. Multiple users can be set                                              | string | Any                     | ""                                                                                  |
| `CUSTOMER_PASSWORD_{NUMBER}` | Specifies the password of the user for the REST API                                                       | string | Any                     | ""                                                                                  |
| `DRY_RUN`                    | If enabled, data wont be stored in database                                                               | bool   | `true`, `false`         | `false`                                                                             |
| `FACTORYINSIGHT_PASSWORD`    | Specifies the password for the admin user for the REST API                                                | string | Any                     | _Random UUID_                                                                       |
| `FACTORYINSIGHT_USER`        | Specifies the admin user for the REST API                                                                 | string | Any                     | factoryinsight                                                                      |
| `INSECURE_NO_AUTH`           | If enabled, no authentication is required for the REST API                                                | bool   | `true`, `false`         | `false`                                                                             |
| `LOGGING_LEVEL`              | Defines which logging level is used, mostly relevant for developers.                                      | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                                                          |
| `POSTGRES_DATABASE`          | Specifies the database name that should be used                                                           | string | Any                     | factoryinsight                                                                      |
| `POSTGRES_HOST`              | Specifies the database DNS name or IP address                                                             | string | Any                     | united-manufacturing-hub                                                            |
| `POSTGRES_PASSWORD`          | Specifies the database password that should be used                                                       | string | Any                     | changeme                                                                            |
| `POSTGRES_PORT`              | Specifies the database port for postgreSQL                                                                | int    | Valid port number       | 5432                                                                                |
| `POSTGRES_USER`              | Specifies the database user that should be used                                                           | string | Any                     | factoryinsight                                                                      |
| `REDIS_PASSWORD`             | Password for accessing redis sentinel                                                                     | string | Any                     | _Random UUID_                                                                       |
| `REDIS_URI`                  | URI for accessing redis sentinel                                                                          | string | Any                     | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `REDIS_URI2`                 | Backup URI for accessing redis sentinel                                                                   | string | Any                     | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `REDIS_URI3`                 | Backup URI for accessing redis sentinel                                                                   | string | Any                     | united-manufacturing-hub-redis-node-0.united-manufacturing-hub-redis-headless:26379 |
| `VERSION`                    | The version of the API used                                                                               | int    | Any                     | 2                                                                                   |
| `SERIAL_NUMBER`              | Serial number of the cluster (used for tracing)                                                           | string | Any                     | development                                                                         |
| `MICROSERVICE_NAME`          | Name of the microservice (used for tracing)                                                               | string | Any                     | united-manufacturing-hub-factoryinsight                                             |
| `DEBUG_ENABLE_FGTRACE`       | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production | string | `true`, `false`         | `false`                                                                             |
{{< /table >}}
