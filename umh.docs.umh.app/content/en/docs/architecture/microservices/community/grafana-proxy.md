---
title: "Grafana Proxy"
content_type: task
description: |
    This page has the technical documentation of the microservice grafana-proxy, which as the name suggests proxies request to backend services.
weight: 11
---

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

## How it works

## Configuration

| Variable name             | Description                                                                                                                              | Type     | Possible values               | Example value                                          |
|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------|----------|-------------------------------|--------------------------------------------------------|
| `FACTORYINPUT_BASE_URL`   | Specifies the DNS name /IP address to connect to factoryinput                                                                            | `string` | all DNS names or IP addresses | `http://united-manufacturing-hub-factory-service`      |
| `FACTORYINPUT_KEY`        | ?                                                                                                                                        | ``       |||
| `FACTORYINPUT_USER`       | Specifies the user of the REST API                                                                                                       | `string` | all                           | jeremy                                                 |
| `FACTORYINSIGHT_BASE_URL` | Specifies the DNA name / IP address to connect to factoryinsight                                                                         | `string` | all DNS names or IP addresses | http://united-manufacturing-hub-factoryinsight-service |
| `LOGGING_LEVEL`           | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used | `string` | any                           | `DEVELOPMENT`                                          |
