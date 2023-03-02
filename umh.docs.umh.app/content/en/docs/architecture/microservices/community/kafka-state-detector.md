---
title: "Kafka-State-Detector"
content_type: task
draft: true
description: |
    This page has the technical information for the kafka-state-detector.
weight: 11
---

<!--- erstmal in der draft behalten --->

**This microservice is still in development and is not considered stable for production use**

## Environment variables

| Variable name            | Description                                                                                                                              | Type     | Possible values | Example values |
|--------------------------|------------------------------------------------------------------------------------------------------------------------------------------|----------|-----------------|----------------|
| `ACTIVITY_ENABLED`       | Activates the activity detection                                                                                                         | `bool`   | true, false     | false          |
| `ANOMALY_ENABLED`        | Activates the anomaly detection                                                                                                          | `bool`   | true, false     | false          |
| `KAFKA_BOOTSTRAP_SERVER` | URL of the Kafka broker used, port is required                                                                                           | `string` | all             | localhost:9092 |
| `KAFKA_SSL_KEY_PASSWORD` | Key password to decode the SSL private key                                                                                               | `string` | any             | changeme       |
| `LOGGING_LEVEL`          | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any             | `DEVELOPMENT`  |
| `MEMORY_REQUEST`         | Allowed memory for message cache                                                                                                         | `string` | any             | 1Gi            |
| `SERIAL_NUMBER`          | Serial number of the cluster (used for tracing)                                                                                          | `string` | all             | development    |
| `MICROSERVICE_NAME`      | Name of the microservice (used for tracing)                                                                                              | `string` | all             | barcodereader  |

