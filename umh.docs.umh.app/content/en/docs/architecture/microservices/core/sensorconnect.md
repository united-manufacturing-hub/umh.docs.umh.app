+++
title = "sensorconnect"
menuTitle = "sensorconnect"
chapter = false
weight = 5
draft = false
description = "The technical documentation of the microservice sensorconnect, which reads out sensor values through ifm gateways."
+++

The microservice sensorconnect automatically detects ifm gateways in the specified network and reads out their sensor values 
in the highest possible data frequency (or the chosen data frequency). It provides plug-and-play access to [IO-Link](https://io-link.com) 
sensors connected to [ifm gateways](https://ifm.com/us/en/category/245_010_010). Digital input mode is also supported. 
A typical setup contains multiple sensors connected via LAN to your server infrastructure. The sensorconnect microservice 
constantly monitors a given IP range for gateways. Once a gateway is found, it automatically starts requesting, receiving 
and processing sensor data in short intervals. The received data is preprocessed based on a database including thousands of
sensor definitions. And because we strongly believe in open industry standards, sensorconnect brings the data via MQTT or Kafka
to your preferred software solutions (for example, features of the United Manufacturing Hub or the cloud).

## Underlying functionality

Sensorconnect downloads relevant IODD files automatically after installation from the [IODDfinder webpage](https://io-link.com/en/IODDfinder/IODDfinder.php?thisID=137).
If an unknown server is connected later, sensorconnect will automatically download the file. We will also provide a folder to manually deposit IODD-files, 
if the automatic download doesn't work (e.g. no internet connection).

#### REST API POST requests from sensorconnect to the gateways

Sensorconnect scans the IP range for new ifm gateways (used to connect the IO-Link devices to). To do that, sensorconnect
iterates through all the possible IP addresses in the specified IP address range ("http://"+url, `payload`, timeout=0.1).
It stores the IP addresses with the product codes and the individual serial numbers. 

**Scanning with the following `payload`: (Information send during a POST request to the ifm gateways)**

```JSON
{
  "code":"request",
  "cid":-1, // The cid (Client ID) can be chosen.
  "adr":"/getdatamulti",
  "data":{
    "datatosend":[
      "/deviceinfo/serialnumber/","/deviceinfo/productcode/"
      ]
    }
}
```

**Example answer from gateway**

```JSON
{
    "cid": 24,
    "data": {
        "/deviceinfo/serialnumber/": {
            "code": 200,
            "data": "000201610192"
        },
        "/deviceinfo/productcode/": {
            "code": 200,
            "data": "AL1350"
        }
    },
    "code": 200
}
```

All port modes of the connected gateways are requested. Depending on the productcode, the total number of ports on the gateway can be determined and iterated through.

**Requesting port modes with following payload: (information sent during a POST request to the ifm gateways)**

```JSON
{
  "code":"request",
  "cid":-1,
  "adr":"/getdatamulti",
  "data":{
    "datatosend":[
      "/iolinkmaster/port[1]/mode",
      "/iolinkmaster/port<i>/mode" //looping through all ports on gateway
      ]
    }
}
```

**Example answer from gateway**

```JSON
{
    "cid": -1,
    "data": {
        "/iolinkmaster/port[1]/mode": {
            "code": 200,
            "data": 3
        },
        "/iolinkmaster/port[2]/mode": {
            "code": 200,
            "data": 3
        }
    }
}
```

If the mode == 1: port_mode = "DI" (Digital Input)

If the mode == 2: port_mode = "DO" (Digital Output)

If the mode == 3: port_mode = "IO_Link"

All values of accessible ports are requested as fast as possible (ifm gateways act as a bottleneck). 

**Requesting IO_Link port values with following payload: (information sent during a POST request to the ifm gateways)**


```JSON
{
  "code":"request",
  "cid":-1,
  "adr":"/getdatamulti",
  "data":{
    "datatosend":[
      "/iolinkmaster/port[1]/iolinkdevice/deviceid",
      "/iolinkmaster/port[1]/iolinkdevice/pdin",
      "/iolinkmaster/port[1]/iolinkdevice/vendorid",
      "/iolinkmaster/port[1]/pin2in",
      "/iolinkmaster/port[<i>]/iolinkdevice/deviceid",//looping through all connected ports on gateway
      "/iolinkmaster/port[<i>]/iolinkdevice/pdin",
      "/iolinkmaster/port[<i>]/iolinkdevice/vendorid",
      "/iolinkmaster/port[<i>]/pin2in"
      ]
  }
}
```

**Example answer from gateway**

```JSON
{
    "cid": -1,
    "data": {
        "/iolinkmaster/port[1]/iolinkdevice/deviceid": {
            "code": 200,
            "data": 278531
        },
        "/iolinkmaster/port[1]/iolinkdevice/pdin": {
            "code": 200,
            "data": "0101" // This string contains the actual data from the sensor. In this example it is the data of a buttonbar. The value changes when one button is pressed. Interpreting this value automatically relies heavily on the IODD file of the specific sensor (information about which partition of the string holds what value (type, value name etc.)).
        },
        "/iolinkmaster/port[1]/iolinkdevice/vendorid": {
            "code": 200,
            "data": 42
        },
        "/iolinkmaster/port[1]/pin2in": {
            "code": 200,
            "data": 0
        }
    },
    "code": 200
}
```

#### IODD file management

Based on the vendorid and the deviceid (extracted out of the received data from the ifm gateway), sensorconnect looks in its persistent storage if an IODD file is available. If there is no IODD file stored in the specific sensor, it tries to download a file online and saves it. If this also is not possible, sensorconnect doesn't preprocess the pdin data entry and forwards it as is. 

#### Data interpretation (key:pdin) with IODD files

The IODD files are in xml format and often contain multiple thousand You can find extensive documentation on the (IO-Link website)[https://io-link.com/en/Download/Download.php]. Especially relevant areas of the IODD files are for our use case:

- IODevice/DocumentInfo/version:     version of IODD files.
- IODevice/ProfileBody/DeviceIdentity:  deviceid, vendorid, etc.
- IODevice/DeviceFunction/ProcessDataCollection/ProcessData/ProcessDataIn: contains information about the data structure received from the sensor. Datatypes and data references are given.
- IODevice/DeviceFunction/DatatypeCollection: if used, contains datatypes references by the ProcessDataCollection.
- IODevice/ExternalTextCollection: contains translation for textIDs

#### Digital input data management

The gateways are also able to receive digital input data (not IO-Link). This data is also requested and forwarded. 

#### Data delivery to MQTT or Kafka

For delivery of the data, sensorconnect converts the data into a JSON containing the preprocessed data, timestamps, 
serialnumbers etc. and sends in via MQTT to the MQTT broker or via Kafka to the Kafka broker. 
You can change the environment variables to choose your preferred protocol. 

## Environment variables

| Variable name                              | Description                                                                                                                                                   | Type                                | Possible values     | Example value                                                                                                                                    |
|--------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------|---------------------|--------------------------------------------------------------------------------------------------------------------------------------------------|
| `ADDITIONAL_SLEEP_TIME_PER_ACTIVE_PORT_MS` | Additional allotted sleep time between pollings for each additional active port, defaults to 0.0                                                              | `float`                             | any                 | 0.0                                                                                                                                              |
| `ADDITIONAL_SLOWDOWN_MAP`                  | JSON map of values, allows to slow down and speed up the polling time of specific sensors                                                                     | `JSON`                              | any valid JSON map  | [{"serialnumber":"000200610104","slowdown_ms":-10},{"url":"http://192.168.0.13","slowdown_ms":20},{"productcode":"AL13500","slowdown_ms":20.01}] |
| `DEVICE_FINDER_TIMEOUT_SEC`                | Time in s for an HTTP timeout, defaults to 1 s                                                                                                                | `int`                               | any                 | 1                                                                                                                                                |
| `DEVICE_FINDER_TIME_SEC`                   | Time in s before finding new devices, defaults to 20 s                                                                                                        | `int`                               | any                 | 20                                                                                                                                               |
| `IODD_FILE_PATH`                           | IODD file path                                                                                                                                                | `string`                            | any valid unix path | /ioddfiles                                                                                                                                       |
| `IP_RANGE`                                 | IP range sensor connect is scanning in for sensors                                                                                                            | `string`                            | any                 | 192.169.0                                                                                                                                        |
| `KAFKA_BOOTSTRAP_SERVER`                   | URL of the kafka broker, port is required                                                                                                                     | `string`                            | valid URLs          | kafka:9092                                                                                                                                       |
| `KAFKA_SSL_KEY_PASSWORD`                   | Password for the SSL key                                                                                                                                      | `string`                            | any                 | password                                                                                                                                         |
| `LOGGING_LEVEL`                            | Defines which logging level is used, mostly relevant for developers. If logging level is not `DEVELOPMENT`, default logging will be used                      | `string`                            | any                 | `DEVELOPMENT`                                                                                                                                    |
| `LOWER_POLLING_TIME_MS`                    | Time in milliseconds to define the lower bound of time between sensor polling, defaults to 20 ms                                                              | `int`                               | any                 | 20                                                                                                                                               |
| `MAX_SENSOR_ERROR_COUNT`                   | Amount of errors before a sensor is temporarily disabled, defaults to 50                                                                                      | `int`                               | any                 | 50                                                                                                                                               |
| `MQTT_BROKER_URL`                          | The MQTT broker URL                                                                                                                                           | `string`                            | IP, DNA name        | united-manufacturing-hub-vernemq-local-service:1883                                                                                              |
| `MQTT_CERTIFICATE_NAME`                    | Set to NO_CERT to allow non-encrypted MQTT access                                                                                                             | `string`                            | any, NO_CERT        | NO_CERT                                                                                                                                          |
| `MQTT_PASSWORD`                            | Password for the MQTT broker                                                                                                                                  | `string`                            | any                 | password                                                                                                                                         |
| `MY_POD_NAME`                              | Name of the docker pod, used for identification at the MQTT broker                                                                                            | `string`                            | any                 | MQTT-Kafka-Bridge                                                                                                                                |
| `POLLING_SPEED_STEP_DOWN_MS`               | Time in ms subtracted from polling interval time after a successful polling, defaults to 1 ms                                                                 | `int`                               | any                 | 1                                                                                                                                                |
| `POLLING_SPEED_STEP_UP_MS`                 | Time in ms added to polling interval time after a failed polling, defaults to 20 ms                                                                           | `int`                               | any                 | 20                                                                                                                                               |
| `SENSOR_INITIAL_POLLING_TIME_MS`           | Allotted time before sensorconnect begins retrieving sensor data, should be higher than `LOWER_POLLING_TIME_MS`, defaults to 100 ms                           | `int`                               | any                 | 100                                                                                                                                              |
| `SUB_TWENTY_MS`                            | Set to 1 to allow `LOWER_POLLING_TIME_MS` of under 20 ms. This is not recommended as it might lead to the gateway becoming unresponsive until a manual reboot | `int`                               | 1, any              | 1                                                                                                                                                |
| `TRANSMITTERID`                            | ID of the sensorconnect, part of the topic structure                                                                                                          | `string`                            | all                 | ifmgateway1                                                                                                                                      |
| `UPPER_POLLING_TIME_MS`                    | Time in milliseconds to define the upper bound of time between sensor polling, defaults to 1000 ms                                                            | `int`                               | any                 | 1000                                                                                                                                             |
| `USE_KAFKA`                                | If enabled, uses Kafka to broker messages                                                                                                                     | (true or 1 both enables it)`string` | `true`, `1`,any     | `1`                                                                                                                                              |
| `USE_MQTT`                                 | If enabled, uses MQTT to broker messages(true or 1 both enables it)                                                                                           | `string`                            | `true`,`1`, any     | `1`                                                                                                                                              |
| `SERIAL_NUMBER`                            | Serial number of the cluster (used for tracing)                                                                                                               | `string`                            | all                 | development                                                                                                                                      |
| `MICROSERVICE_NAME`                        | Name of the microservice (used for tracing)                                                                                                                   | `string`                            | all                 | barcodereader                                                                                                                                    |
| `DEBUG_ENABLE_FGTRACE`                     | Enables the use of the [fgtrace](https://github.com/felixge/fgtrace) library, do not enable in production                                                     | `string`                            | `true`, `1`, any    | `1`                                                                                                                                              |
