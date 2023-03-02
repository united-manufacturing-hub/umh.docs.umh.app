---
title: "Kafka-to-Blob"
content_type: task
description: |
    This page has the technical documentation for the microservice kafka-to-blob, which saves raw images from Kafka to blob storage.
weight: 3000
---

{{% notice note %}}
This microservice is only community supported, which means that you might encounter issues when working with it.
{{% /notice %}}

## How it works

Kafka-to-blob is a microservice that saves images from kafka to blob storage.

It can store raw image data.

💡This microservices requires that the Kafka Topic `umh.v1.kafka.newTopic` exits. In Version > 0.9.12 this happens automatically.

## Configuration

| Variable name            | Description                                                                                                                              | Type     | Possible values        | Example value                                               |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------|----------|------------------------|-------------------------------------------------------------|
| `BUCKET_NAME`            | The bucket to store the images in                                                                                                        | `string` | all                    | umh                                                         |
| `KAFKA_BASE_TOPIC`       | Set this if you want to automatically create the topic                                                                                   | `string` | valid kafka topics     | ia                                                          |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                                           | `string` | all                    | localhost:9092                                              |
| `KAFKA_LISTEN_TOPIC`     | The kafka topic to listen to                                                                                                             | `string` | all valid kafka topics | ia.factoryinsight.testfactory.testmachine.rawimage          |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                                               | `string` | any                    | changeme                                                    |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any                    | `DEVELOPMENT`                                               |
| `MINIO_ACCESS_KEY`       | The access key of the minio server                                                                                                       | `string` | all                    | changeme                                                    |
| `MINIO_SECRET_KEY`       | The secret key of the minion server                                                                                                      | `string` | all                    | changeme                                                    |
| `MINIO_SECURE`           | Uses https if true, http if false                                                                                                        | `bool`   | true, false            | true                                                        |
| `MINIO_URL`              | The URL of the minio server                                                                                                              | `string` | all                    | umhminio-hl.united-manufacturing-hub.svc.cluster.local:9000 |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                                          | `string` | all                    | development                                                 |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                                              | `string` | all                    | barcodereader                                               |

