---
title: "Factoryinput"
content_type: task
description: |
    The technical documentation of the microservice factoryinput, which provides a REST endpoint for MQTT messages via HTTP requests.
weight: 7000
---

{{% notice warning %}}
This microservice is still in development and is not considered stable for production use
{{% /notice %}}

## How it works

Factoryinput provides a REST endpoint for MQTT messages via HTTP requests.

This microservice is typically accessed via [grafana-proxy](/docs/plugins/grafana-proxy)

## Configuration

This chapter explains all environment variables used in barcodereader.

| Variable name                | Description                                                                                           | Type      | Possible values | Example Values                                            |
|------------------------------|-------------------------------------------------------------------------------------------------------|-----------|-----------------|-----------------------------------------------------------|
| `CUSTOMER_NAME_{NUMBER}`     | Specifies a user for the REST API                                                                     | `string`  | all             | jeremy                                                    | 
| `CUSTOMER_PASSWORD_{NUMBER}` | Specifies the password for the user for the REST API                                                  | `string`  | all             | changeme                                                  | 
| `FACTORYINPUT_USER`          | Specifies the admin user for the REST API                                                             | `string`  | all             | jeremy                                                    |
| `FACTORYINPUT_PASSWORD`      | Specifies the password for the admin user for the REST API                                            | `string`  | all             | changeme                                                  |
| `VERSION`                    | Version of the API to host, currently 1 is the only valid value                                       | `integer` | all             | 1                                                         |
| `CERTIFICATE_NAME`           | Certificate for MQTT authorization or NO_CERT                                                         | `string`  | all             | NO_CERT                                                   |
| `BROKER_URL`                 | URL to the broker. Can be prepended with "ssl://" or "mqtt://" or needs to suffix the port with :1883 | `string`  | all             | tcp://united-manufacturing-hub-vernemq-local-service:1883 |
| `MY_POD_NAME`                | The pod name. Used for tracing, logging and MQTT client ID                                            | `string`  | all             | app-factoryinput-0                                        |    
| `MQTT_QUEUE_HANDLER`         | Number of queue workers to spawn. Default is 10.                                                      | `uint`    | 0-65535         | 10                                                        |
