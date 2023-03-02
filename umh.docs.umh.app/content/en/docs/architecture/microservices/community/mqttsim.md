---
title: "iotsensorsmqtt"
content_type: task
description: |
    The technical documentation of the microservice iotsensorsmqtt
weight: 2000
---

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but it is enabled by default.
{{% /notice %}}

## How it works

This microservice simulates data in three different topics, make sure to look at our Node-RED flows to see how to utilize them to generate custom data.
You can read the documentation of the standalone application [here](https://github.com/amine-amaach/simulators/tree/main/ioTSensorsMQTT).

With the standard configuration it simulates three different parameters around a set mean and standard deviation.
It publishes messages on the topic `ia/raw/development/ioTSensors/#` wherein # is the parameter.

If you want the simulated messaged to be processValues or other message types, just quickly adjust them via a Node-RED flow.
We have some templates in our [Node-RED repository](/guides/open-source/node-red/tutorial/node-red-flows-repo/).

## Configuration

This chapter explains all the variables used in IoTSensorsMQTT. Be aware that in the UMH stack implementation of this microservice
many environment variables are set in its own config.yaml instead of the values.yaml which retrieves environment variables for other microservices.


| Variable name                      | Description                                                      | Type     | Possible values | Example value                                               |
|------------------------------------|------------------------------------------------------------------|----------|--|-------------------------------------------------------------|
| `SERVER_URL`                       | Server URL of the MQTT server                                        | `string` | valid MQTT server address | `mqtt://united-manufacturing-hub-vernemq-local-service:1883` |
| `SERVER_USER`                      | User authentication if enabled on the server                         | `string` | any | `jeremy`                                                    |
| `SERVER_PWD`                       | Specifies the user of the REST API                                   | `string` | any | `changeme`                                                  |
| `CLIENT_ID`                        | The Client ID for broker connection                                  | `string` | all | `IoTSensorsMQTT-Simulator`                                  |
| `SET_DELAY_BETWEEN_MESSAGES`       | delay between messages in seconds                                    | `int`    | positive numbers | 15    |
| `RANDOMIZE_DELAY_BETWEEN_MESSAGES` | Whether or not the duration between data points should be randomized | `bool`   | true, false | false      |
| `SIMULATORS`                       | Map with the specifications for all parameters                       | `map`    |valid maps with name, mean and standard deviation | `[{Name: Temperature, Mean: 5, StandardDeviation: 1}]`|
| `Name`                             | Name of the parameter | `string` | all     | `Temperature`, `Humidity`, `Density`, `Weight`
| `Mean`                             | mean value of the parameter | `float`    | positive floating point numbers     | 80.7   |
| `StandardDeviation`                | standard deviation of the parameter| `float`    | positive floating point numbers    |1.54|
