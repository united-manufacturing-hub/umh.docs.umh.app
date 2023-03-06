---
title: "Kafka to Blob"
content_type: microservices
description: |
    The technical documentation of the kafka-to-blob microservice,
    which stores raw images from Kafka to a blob storage.
weight: 0
---

<!-- overview -->

{{< notice warning >}}
This microservice is still in development and is not considered stable for production use
{{< /notice >}}

## {{% heading "howitworks" %}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="kafkatoblob" >}}`
- Secret: `{{< resource type="secret" name="kafkatoblob" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name            | Description                                                                                                  | Type   | Allowed values  | Default                                                     |
| ------------------------ | ------------------------------------------------------------------------------------------------------------ | ------ | --------------- | ----------------------------------------------------------- |
| `BUCKET_NAME`            | The name of the bucket to store the images in                                                                | string | Any             | umh                                                         |
| `DEBUG_ENABLE_FGTRACE`   | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library. Not reccomended for production | string | `true`, `false` | `false`                                                     |
| `KAFKA_BASE_TOPIC`       | The base topic for Kafka                                                                                     | string | Any             | ia                                                          |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                               | string | Any             | {{< resource type="service" name="kafka" >}}:9092           |
| `KAFKA_LISTEN_TOPIC`     | The topic to listen to for new images. It can be a regular expression                                        | string | Any             | ^ia\\\\..+\\\\.rawImage                                     |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                   | string | Any             | ""                                                          |
| `KAKFA_USE_SSL`          | Enables the use of SSL for the kafka connection                                                              | string | `true`, `false` | `false`                                                     |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                  | string | Any             | united-manufacturing-hub-kafkastatedetector                 |
| `MINIO_ACCESS_KEY`       | Access key for the MinIO server                                                                              | string | Any             | ""                                                          |
| `MINIO_SECRET_KEY`       | Secret key for the MinIO server                                                                              | string | Any             | ""                                                          |
| `MINIO_SECURE`           | Whether to use TLS for the MinIO connection                                                                  | string | `true`, `false` | `true`                                                      |
| `MINIO_URL`              | URL of the MinIO server                                                                                      | string | Any             | umhminio-hl.united-manufacturing-hub.svc.cluster.local:9000 |
| `SERIAL_NUMBER`          | Serial number of the cluster. Used for tracing                                                               | string | Any             | defalut                                                     |
| `SSL_CERT_FILE`          | Path to the SSL certificate file                                                                             | string | Any             | /certs/kubernetes-ca.pem                                    |
{{< /table >}}
