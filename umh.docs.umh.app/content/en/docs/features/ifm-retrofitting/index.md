+++
title = "Retrofitting with ifm IO-link gateways and sensorconnect"
menuTitle = "Retrofitting with ifm IO-link gateways and sensorconnect"
description = ""
weight = 4
draft = false
+++

[Retrofitting](https://learn.umh.app/blog/connectivity-retrofitting-the-shopfloor-with-plug-play-sensors/) older machines with sensors is sometimes the only-way to capture process-relevant information.
In this article, we will focus on retrofitting with [ifm IO-Link gateways](https://www.ifm.com/de/de/category/245) and 
[Sensorconnect]((/docs/architecture/microservices/core/sensorconnect/)), a microservice of the United Manufacturing Hub, that finds and reads out ifm IO-Link masters in the 
network and pushes sensor data to MQTT/Kafka for further processing.

![](/images/features/ifm-retrofitting/ifm_sensors.jpg?width=40%)

## When should I use it?

Retrofitting with ifm IO-Link gateways and using Sensorconnect is ideal when dealing with older machines that are not
equipped with any connectable hardware to read relevant information out of the machine itself. By placing sensors on 
the machine and connecting them with IO-Link gateways, required information can be gathered for valuable
insights. Sensorconnect helps to easily connect to all sensors correctly and properly capture the large 
amount of sensor data provided.

## What can I do with it?

With ifm IO-Link gateways and Sensorconnect, you can collect data from sensors and make it accessible for further use. 
Sensorconnect offers: 
- Automatic detection of ifm IO-Link masters in the network.
- Identification of [IO-Link](https://www.ifm.com/de/de/category/200) and alternative digital or analog sensors connected to gateways. 
Digital Sensors employ a voltage range from 10 to 30V DC, producing binary outputs of true or false. In contrast, analog sensors operate at 24V DC, with a current range spanning from 4 to 20 mA. Utilizing the appropriate converter, analog outputs can be effectively transformed into digital signals.
- Constant polling of data from the detected sensors.
- Interpreting the received data based on a [sensor database](https://io-link.com/en/IODDfinder/IODDfinder.php?thisID=137) containing thousands of entries.
- Sending data in JSON format to MQTT and Kafka for further data processing.


## How can I use it?

To use ifm IO-link gateways and [Sensorconnect](/docs/architecture/microservices/core/sensorconnect/) please follow these instructions:
  1. Ensure all IO-Link gateways are connected to the same network as your United Manufacturing Hub. 
  2. Retrofit the machines by integrating the desired sensors and establish a connection with ifm IO-Link gateways.
  3. Configure the Sensorconnect IP-range to either match the IP address using subnet notation /32, or, in cases involving multiple masters, configure it to scan an entire range, for example /24.
  4. Once completed, the data should be available in your Unified Namespace.

## What are the limitations?

- The current ifm firmware has a software bug, that will cause the IO-Link master to crash if it receives to many requests.
  To resolve this issue, you can either request an experimental firmware, which is available exclusively from ifm, or dis- and then re-connect the power to the IO-Link.

## Where to get more information?

- [GitHub UMH Community Repository](https://github.com/united-manufacturing-hub/community-repo)
- [Introduction into retrofitting](https://learn.umh.app/lesson/introduction-into-it-ot-retrofitting/)
- [Retrofitting the shopfloor with plug play sensors](https://learn.umh.app/blog/connectivity-retrofitting-the-shopfloor-with-plug-play-sensors/)
- [Documentation of Sensorconnect](/docs/architecture/microservices/core/sensorconnect/)