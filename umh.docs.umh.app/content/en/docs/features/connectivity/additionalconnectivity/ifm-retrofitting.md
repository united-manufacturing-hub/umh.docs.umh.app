---
title: Retrofitting with ifm IO-link master and sensorconnect
menuTitle: Retrofitting with ifm IO-link master and sensorconnect
description: Upgrade older machines with ifm IO-Link master and Sensorconnect for seamless data collection and integration. Retrofit your shop floor with plug-and-play sensors for valuable insights and improved efficiency.
weight: 1000
aliases:
  - /docs/features/ifm-retrofitting
---

[Retrofitting](https://learn.umh.app/blog/connectivity-retrofitting-the-shopfloor-with-plug-play-sensors/) older machines with sensors is sometimes the only-way to capture process-relevant information.
In this article, we will focus on retrofitting with [ifm IO-Link master](https://www.ifm.com/de/de/category/245) and
[Sensorconnect](/docs/reference/microservices/sensorconnect/), a microservice of the United Manufacturing Hub, that finds and reads out ifm IO-Link masters in the
network and pushes sensor data to MQTT/Kafka for further processing.

![](/images/features/ifm-retrofitting/ifm_sensors.jpg?width=40%)

## When should I use it?

Retrofitting with ifm IO-Link master such as the AL1350 and using Sensorconnect is ideal when dealing with older machines that are not
equipped with any connectable hardware to read relevant information out of the machine itself. By placing sensors on
the machine and connecting them with IO-Link master, required information can be gathered for valuable
insights. Sensorconnect helps to easily connect to all sensors correctly and properly capture the large
amount of sensor data provided.

## What can I do with it?

With ifm IO-Link master and Sensorconnect, you can collect data from sensors and make it accessible for further use.
Sensorconnect offers:

- Automatic detection of ifm IO-Link masters in the network.
- Identification of [IO-Link](https://www.ifm.com/de/de/category/200) and alternative digital or analog sensors connected to the master using converter such as the [DP2200](https://www.ifm.com/de/de/product/DP2200).
  Digital Sensors employ a voltage range from 10 to 30V DC, producing binary outputs of true or false. In contrast, analog sensors operate at 24V DC, with a current range spanning from 4 to 20 mA. Utilizing the appropriate converter, analog outputs can be effectively transformed into digital signals.
- Constant polling of data from the detected sensors.
- Interpreting the received data based on a [sensor database](https://io-link.com/en/IODDfinder/IODDfinder.php?thisID=137) containing thousands of entries.
- Sending data in JSON format to MQTT and Kafka for further data processing.

## How can I use it?

To use ifm IO-link gateways and [Sensorconnect](/docs/reference/microservices/sensorconnect/) please follow these instructions:

1. Ensure all IO-Link gateways are in the same network or accessible from your instance of the United Manufacturing Hub.
2. Retrofit the machines by connecting the desired sensors and establish a connection with ifm IO-Link gateways.
3. Configure the [Sensorconnect IP-range](/docs/reference/helm-chart/#sensor-connect) to either match the IP address using subnet notation /32, or, in cases involving multiple masters, configure it to scan an entire range, for example /24. To change the value, execute the following command with your IP range:
```bash
sudo helm upgrade --kubeconfig /etc/rancher/k3s/k3s.yaml  -n united-manufacturing-hub united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub --set _000_commonConfig.datasources.sensorconnect.iprange=[REPLACE_WITH_NEW_IPRANGE],_000_commonConfig.datasources.sensorconnect.enabled=true --version $(sudo helm ls --kubeconfig /etc/rancher/k3s/k3s.yaml  -n united-manufacturing-hub -o json | jq -r '.[0].app_version')
```
4. Once completed, the data should be available in your [Unified Namespace](/docs/features/datainfrastructure/unified-namespace/).

## What are the limitations?

- The current ifm firmware has a software bug, that will cause the IO-Link master to crash if it receives to many requests.
  To resolve this issue, you can either request an experimental firmware, which is available exclusively from ifm, or re-connect the power to the IO-Link gateway.

## Where to get more information?

- [GitHub UMH Community Repository](https://github.com/united-manufacturing-hub/community-repo)
- [Introduction into retrofitting](https://learn.umh.app/lesson/introduction-into-it-ot-retrofitting/)
- [Retrofitting the shopfloor with plug play sensors](https://learn.umh.app/blog/connectivity-retrofitting-the-shopfloor-with-plug-play-sensors/)
- [Documentation of Sensorconnect](/docs/reference/microservices/sensorconnect/)
