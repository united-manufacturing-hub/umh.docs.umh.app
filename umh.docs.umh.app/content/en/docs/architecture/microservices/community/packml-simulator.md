---
title: "packmlsimulator"
content_type: task
description: |
    The technical documentation of the microservice packmlsimulator
weight: 6000
---

{{% notice warning %}}
This microservice is a community contribution and is not part of the main stack of the United Manufacturing Hub, but it is enabled by default.
{{% /notice %}}

## How it works

This microservice simulates a PackML machine which sends and receives MQTT messages, make sure to look at our Node-RED flows to see how to utilize them to generate custom data.
You can read the documentation of the standalone application [here](https://github.com/Spruik/PackML-MQTT-Simulator).
Make sure to look at our [PACKML simulator guide](/guides/getstarted/data-manipulation/creating-node-red-flow-with-packml-data) to see how to utilize them to generate custom data.

The simulator requires a running MQTT server accessible for the simulator.

If you want the simulated messages to be converted into processValues or other message types, just quickly adjust them via a Node-RED flow.
We have some templates in our [Node-RED repository](/guides/open-source/node-red/tutorial/node-red-flows-repo/).

Using docker you can build a container with the following command:
```bash
docker run -it -e SITE=Site -e AREA=Area -e LINE=Line -e MQTT_URL=mqtt://broker.hivemq.com -m 30m spruiktec/packml-simulator
```

Make sure to adjust the site, area, line and MQTT URL to change it to fit your setup.

In combination with the United Manufacturing Hub, it will build by default with all the other pods. You can adjust the environment variables
in the values.yaml

## Configuration

### Environment variables
This chapter explains all the variables used in PackMLSimulator.


| Variable name                      | Description                                                      | Type     | Possible values | Example value                                               |
|------------------------------------|------------------------------------------------------------------|----------|--|-------------------------------------------------------------|
| `MQTT_URL`                       | Server URL of the MQTT server                                        | `string` | valid MQTT server address | `mqtt://united-manufacturing-hub-vernemq-local-service:1883` |
| `MQTT_PORT`                      | Port of the MQTT server, if blank the library will determine it on its own                         | `string` | a valid port | `8008`                                                    |
| `MQTT_USERNAME`                       | Name of the MQTT user with subscribe and publish permission, can be left empty if the server does not manage permissions.                               | `string` | any | `user`                                                  |
| `MQTT_PASSWORD`                        | Password of the MQTT user with sub and pub permission, can be left empty if username was left empty.                                  | `string` | all | `changeme`                                  |
| `MQTT_CLIENT_ID`       | Client id to use when connecting to the broker                              | `string`    | any | `mqttconnect`   |
| `CLIENT_TYPE` | Which payload specifications should be used | `string`   | mqtt, sparkplugb | mqtt      |
| `SPARKPLUG_GROUP_ID`                       | If you use Sparkplug B specifications, it defines the group ID her, if undefined the simulator instead copies the SITE environment variable                   | `string`    |any | `shopflooralpha`|
| `SPARKPLUG_EDGE_NODE`                             | If you use Sparkplug B specifications, it defines the edge node ID, if undefined the simulator instead copies the AREA environment variable | `string` | all     | `bands`
| `TICK`                             | Tick speed in ms, if undefined it defaults to 1000| `int`    | positive numbers     | 1000   |
| `SITE`                | ISA-95 site name of the line, parent topic in the MQTT `Site` is default value| `string`    | any    |`aachen`|
| `AREA`                | ISA-95 area name of the line, middle topic in the MQTT `Area` is default value| `string`    | any    |`dcc`|
| `LINE`                | ISA-95 line name of the line, parent topic in the MQTT `Line` is default value| `string`    | any    |`bands`|

### Commands

You interface with the simulated machines by sending MQTT it subscribes to. In the following image the state model is described and below are specifications
for the messages you need to send to control the simulated machine and send it from one state to another.

![Grafana through MQTT stack flow](/images/microservices-community/PackML-StateModel.png)

Available commands

| Topic                                                                         | Values  | Function                                                  |
|-------------------------------------------------------------------------------|---------|-----------------------------------------------------------|
| `<SITE>/<AREA>/<LINE>/Command/Clear`                                          | 1, 0    | Clear Command                                             |
| `<SITE>/<AREA>/<LINE>/Command/Reset`                                          | 1, 0    | Reset Command                                             |
| `<SITE>/<AREA>/<LINE>/Command/Start`                                          | 1, 0    | Start Command                                             |
| `<SITE>/<AREA>/<LINE>/Command/Hold`                                           | 1, 0    | Hold Command                                              |
| `<SITE>/<AREA>/<LINE>/Command/Unhold`                                         | 1, 0    | Unhold Command                                            |
| `<SITE>/<AREA>/<LINE>/Command/Complete`                                       | 1, 0    | Complete Command                                          |
| `<SITE>/<AREA>/<LINE>/Command/Stop`                                           | 1, 0    | Stop Command                                              |
| `<SITE>/<AREA>/<LINE>/Command/Abort`                                          | 1, 0    | Abort Command                                             |
| `<SITE>/<AREA>/<LINE>/Command/UnitMode`                                       | String  | Unit Mode Command (`Production`, `Manual`, `Maintenance`) |
| `<SITE>/<AREA>/<LINE>/Command/MachSpeed`                                      | Decimal | Machine Speed Command                                     |
| `<SITE>/<AREA>/<LINE>/Command/Parameter/*n*/ID`                               | Integer | Parameter *n* ID                                          |
| `<SITE>/<AREA>/<LINE>/Command/Parameter/*n*/Name`                             | String  | Parameter *n* Name                                        |
| `<SITE>/<AREA>/<LINE>/Command/Parameter/*n*/Unit`                             | String  | Parameter *n* Unit                                        |
| `<SITE>/<AREA>/<LINE>/Command/Parameter/*n*/Value`                            | Decimal | Parameter *n* Value                                       |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/ID`                                 | Integer | Product *n* ID                                            |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/ProcessParameter/*j*/ID`            | Integer | Product *i* Process Parameter *j* ID                      |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/ProcessParameter/*j*/Name`          | Integer | Product *i* Process Parameter *j* Name                    |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/ProcessParameter/*j*/Unit`          | Integer | Product *i* Process Parameter *j* Unit                    |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/ProcessParameter/*j*/Value`         | Integer | Product *i* Process Parameter *j* Value                   |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/Ingredient/*j*/ID`                  | Integer | Product *i* Ingredient *n* ID                             |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/Ingredient/*j*/Parameter/*k*/ID`    | Integer | Product *i* Ingredient *j* Parameter *k* ID               |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/Ingredient/*j*/Parameter/*k*/Name`  | Integer | Product *i* Ingredient *j* Parameter *k* Name             |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/Ingredient/*j*/Parameter/*k*/Unit`  | Integer | Product *i* Ingredient *j* Parameter *k* Unit             |
| `<SITE>/<AREA>/<LINE>/Command/Product/*i*/Ingredient/*j*/Parameter/*k*/Value` | Integer | Product *i* Ingredient *j* Parameter *k* Value            |

Available statuses

| Topic                                                                        | Values  | Function                                                  |
|------------------------------------------------------------------------------|---------|-----------------------------------------------------------|
| `<SITE>/<AREA>/<LINE>/Status/StateCurrent`                                   | String  | Current PackML State                                      |
| `<SITE>/<AREA>/<LINE>/Status/StateCurrentStr`                                | Integer | Current PackML State as String                            |
| `<SITE>/<AREA>/<LINE>/Status/UnitMode`                                       | Integer | Current PackML Model                                      |
| `<SITE>/<AREA>/<LINE>/Status/UnitModeStr`                                    | String  | Current PackML Model as String                            |
| `<SITE>/<AREA>/<LINE>/Status/CurMachSpeed`                                   | Decimal | Current Machine Speed                                     |
| `<SITE>/<AREA>/<LINE>/Status/MachSpeed`                                      | Decimal | Current Machine Speed Setpoint                            |
| `<SITE>/<AREA>/<LINE>/Status/Parameter/*n*/ID`                               | Integer | Parameter *n* ID                                          |
| `<SITE>/<AREA>/<LINE>/Status/Parameter/*n*/Name`                             | String  | Parameter *n* Name                                        |
| `<SITE>/<AREA>/<LINE>/Status/Parameter/*n*/Unit`                             | String  | Parameter *n* Unit                                        |
| `<SITE>/<AREA>/<LINE>/Status/Parameter/*n*/Value`                            | Decimal | Parameter *n* Value                                       |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/ID`                                 | Integer | Product *n* ID                                            |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/ProcessParameter/*j*/ID`            | Integer | Product *i* Process Parameter *j* ID                      |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/ProcessParameter/*j*/Name`          | Integer | Product *i* Process Parameter *j* Name                    |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/ProcessParameter/*j*/Unit`          | Integer | Product *i* Process Parameter *j* Unit                    |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/ProcessParameter/*j*/Value`         | Integer | Product *i* Process Parameter *j* Value                   |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/Ingredient/*j*/ID`                  | Integer | Product *i* Ingredient *n* ID                             |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/Ingredient/*j*/Parameter/*k*/ID`    | Integer | Product *i* Ingredient *j* Parameter *k* ID               |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/Ingredient/*j*/Parameter/*k*/Name`  | Integer | Product *i* Ingredient *j* Parameter *k* Name             |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/Ingredient/*j*/Parameter/*k*/Unit`  | Integer | Product *i* Ingredient *j* Parameter *k* Unit             |
| `<SITE>/<AREA>/<LINE>/Status/Product/*i*/Ingredient/*j*/Parameter/*k*/Value` | Integer | Product *i* Ingredient *j* Parameter *k* Value            |

Available Admin Statuses

| Topic                                                        | Values  | Function                                                  |
|--------------------------------------------------------------|---------|-----------------------------------------------------------|
| `<SITE>/<AREA>/<LINE>/Admin/MachDesignSpeed`                 | String  | Current PackML State                                      |
| `<SITE>/<AREA>/<LINE>/Admin/ProdConsumedCount/*i*/ID`        | String  | Consumed Counter ID                                       |
| `<SITE>/<AREA>/<LINE>/Admin/ProdConsumedCount/*i*/Name`      | String  | Consumed Counter Name                                     |
| `<SITE>/<AREA>/<LINE>/Admin/ProdConsumedCount/*i*/Unit`      | String  | Consumed Counter Units                                    |
| `<SITE>/<AREA>/<LINE>/Admin/ProdConsumedCount/*i*/Count`     | String  | Consumed Counter Count since reset                        |
| `<SITE>/<AREA>/<LINE>/Admin/ProdConsumedCount/*i*/AccCount`  | String  | Consumed Counter Total Count                              |
| `<SITE>/<AREA>/<LINE>/Admin/ProdProcessedCount/*i*/ID`       | String  | Processed Counter ID                                      |
| `<SITE>/<AREA>/<LINE>/Admin/ProdProcessedCount/*i*/Name`     | String  | Processed Counter Name                                    |
| `<SITE>/<AREA>/<LINE>/Admin/ProdProcessedCount/*i*/Unit`     | String  | Processed Counter Units                                   |
| `<SITE>/<AREA>/<LINE>/Admin/ProdProcessedCount/*i*/Count`    | String  | Processed Counter Count since reset                       |
| `<SITE>/<AREA>/<LINE>/Admin/ProdProcessedCount/*i*/AccCount` | String  | Processed Counter Total Count                             |
| `<SITE>/<AREA>/<LINE>/Admin/ProdDefectiveCount/*i*/ID`       | String  | Defective Counter ID                                      |
| `<SITE>/<AREA>/<LINE>/Admin/ProdDefectiveCount/*i*/Name`     | String  | Defective Counter Name                                    |
| `<SITE>/<AREA>/<LINE>/Admin/ProdDefectiveCount/*i*/Unit`     | String  | Defective Counter Units                                   |
| `<SITE>/<AREA>/<LINE>/Admin/ProdDefectiveCount/*i*/Count`    | String  | Defective Counter Count since reset                       |
| `<SITE>/<AREA>/<LINE>/Admin/ProdDefectiveCount/*i*/AccCount` | String  | Defective Counter Total Count                             |





