---
title: "opcuasimulator"
content_type: task
description: |
    The technical documentation of the microservice opcuasimulator
weight: 5000
---

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but it is enabled by default.
{{% /notice %}}

## How it works

This microservice simulates data in four different topics by default, make sure to look at our [OPCUA simulator guide](/guides/getstarted/data-manipulation/creating-node-red-flow-with-simulated-opcua-data) to see how to utilize them to generate custom data.
You can read the documentation of the standalone application [here](https://github.com/amine-amaach/simulators/tree/main/ioTSensorsOPCUA).

With the standard configuration it simulates four different parameters around a set mean and standard deviation.
It publishes messages on an OPC UA server, you can look up the address in OpenLens when inspecting the pod logs.

If you want the simulated messaged to be processValues or other message types, just quickly adjust them via a Node-RED flow.
We have some templates in our [Node-RED repository](/guides/open-source/node-red/tutorial/node-red-flows-repo/).



## Configuration

This chapter explains all the variables used in the opcuasimulator. Be aware that in the UMH stack implementation of this microservice
many environment variables are set in its own config.yaml instead of the values.yaml which retrieves environment variables for other microservices.


| Variable name                      | Description                                                      | Type     | Possible values | Example value                                               |
|------------------------------------|------------------------------------------------------------------|----------|--|-------------------------------------------------------------|
| `USERIDs`                        | Maps of user name password combinations that can access the server, leave blank if you want no authentication                                 | `map` | all | `[{"Username" : "root", "Password" : "secret"}]`                                  |
| `SET_DELAY_BETWEEN_MESSAGES`       | delay between messages in seconds                                    | `int`    | positive numbers | 15    |
| `RANDOMIZE_DELAY_BETWEEN_MESSAGES` | Whether or not the duration between data points should be randomized | `bool`   | true, false | false      |
| `SIMULATORS`                       | Map with the specifications for all parameters                       | `map`    |valid maps with name, mean and standard deviation | `[{Name: Temperature, Mean: 5, StandardDeviation: 1}]`|
| `Name`                             | Name of the parameter | `string` | all     | `Temperature`, `Humidity`, `Density`, `Weight`
| `Mean`                             | mean value of the parameter | `float`    | positive floating point numbers     | 80.7   |
| `StandardDeviation`                | standard deviation of the parameter| `float`    | positive floating point numbers    |1.54|
|`HOST`|Main host name considered for the certificates, standard is os.Hostname|`string`|`localhost`|
| `CERTIFICATE`                      | Maps of hostnames and IPs | `map` | all | `"CERTIFICATE":{"Hosts":[], "IPS":[]}`
| `HOSTS`                            | list of additional hostnames | `list` | all | `"Hosts":["opcua"]`
| `IPS`                              | list of IPs| `list` | all | `"IPS":[]`