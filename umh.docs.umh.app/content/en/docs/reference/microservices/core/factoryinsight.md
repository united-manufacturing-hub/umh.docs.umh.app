---
title: "Factoryinsight"
content_type: microservices
description: |
    The technical documentation of the Factoryinsight microservice, which exposes
    a set of APIs to access the data from the database.
weight: 0
aliases:
  - /docs/architecture/microservices/core/factoryinsight/
---

<!-- overview -->

Factoryinsight is a microservice that provides a set of REST APIs to access the
data from the database. It is particularly useful to calculate the Key
Performance Indicators (KPIs) of the factories.

## {{% heading "howitworks" %}}

Factoryinsight exposes REST APIs to access the data from the database or calculate
the KPIs. By default, it's only accessible from the internal network of the
cluster, but it can be configured to be
[accessible from the external network](/docs/production-guide/administration/access-factoryinsight-outside-cluster/).

The APIs require authentication, that can be either a Basic Auth or a Bearer
token. Both of these can be found in the Secret `{{< resource type="secret" name="factoryinsight" >}}`.

### API documentation

{{< swaggerui src="/openapi/factoryinsight.yaml" >}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="factoryinsight" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="factoryinsight" >}}` at
    port 80
  - External : [Access factoryinsight outside the cluster](/docs/production-guide/administration/access-factoryinsight-outside-cluster/)
- Secret: `{{< resource type="secret" name="factoryinsight" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure Factoryinsight manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `factoryinsight` section of the Helm
chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                | Description                                                                                                  | Type   | Allowed values          | Default                                                    |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------ | ------ | ----------------------- | ---------------------------------------------------------- |
| `CUSTOMER_NAME_{NUMBER}`     | Specifies a user for the REST API. Multiple users can be set                                                 | string | Any                     | ""                                                         |
| `CUSTOMER_PASSWORD_{NUMBER}` | Specifies the password of the user for the REST API                                                          | string | Any                     | ""                                                         |
| `DEBUG_ENABLE_FGTRACE`       | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not recommended for production | string | `true`, `false`         | `false`                                                    |
| `DRY_RUN`                    | If enabled, data wont be stored in database                                                                  | bool   | `true`, `false`         | `false`                                                    |
| `FACTORYINSIGHT_PASSWORD`    | Specifies the password for the admin user for the REST API                                                   | string | Any                     | _Random UUID_                                              |
| `FACTORYINSIGHT_USER`        | Specifies the admin user for the REST API                                                                    | string | Any                     | factoryinsight                                             |
| `INSECURE_NO_AUTH`           | If enabled, no authentication is required for the REST API. Not recommended for production                   | bool   | `true`, `false`         | `false`                                                    |
| `LOGGING_LEVEL`              | Defines which logging level is used, mostly relevant for developers                                          | string | PRODUCTION, DEVELOPMENT | PRODUCTION                                                 |
| `MICROSERVICE_NAME`          | Name of the microservice. Used for tracing                                                                   | string | Any                     | united-manufacturing-hub-factoryinsight                    |
| `POSTGRES_DATABASE`          | Specifies the database name to use                                                                           | string | Any                     | factoryinsight                                             |
| `POSTGRES_HOST`              | Specifies the database DNS name or IP address                                                                | string | Any                     | united-manufacturing-hub                                   |
| `POSTGRES_PASSWORD`          | Specifies the database password to use                                                                       | string | Any                     | changeme                                                   |
| `POSTGRES_PORT`              | Specifies the database port                                                                                  | int    | Valid port number       | 5432                                                       |
| `POSTGRES_USER`              | Specifies the database user to use                                                                           | string | Any                     | factoryinsight                                             |
| `REDIS_PASSWORD`             | Password to access the redis sentinel                                                                        | string | Any                     | _Random UUID_                                              |
| `REDIS_URI`                  | The URI of the Redis instance                                                                                | string | Any                     | {{< resource type="service" name="cache-headless" >}}:6379 |
| `SERIAL_NUMBER`              | Serial number of the cluster. Used for tracing                                                               | string | Any                     | default                                                    |
| `VERSION`                    | The version of the API used. Each version also enables all the previous ones                                 | int    | Any                     | 2                                                          |
{{< /table >}}
