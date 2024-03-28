---
title: UMH Lite
menuTitle: UMH Lite
description: Understand the purpose and features of the UMH Lite, as well as the differences between UMH Lite and UMH Classic.
weight: 2000
edition: community
aliases:

---

The UMH Lite is a stripped-down version of the classic United Manufacturing Hub.
It allows you to extract data from your shop floor and send it to your own data
infrastructure, as well as perform network monitoring.

## When should I use it?

If the UMH Classic seems a bit much and all you currently need is a way to get
your data from the shop floor to your existing data infrastructure, you are in
the right place. The UMH Lite allows you to gather data and send it to your own
data infrastructure. It does not offer most of the features of the UMH Classic:
you will not install Grafana or Kafka, and you will not have a Unified
Namespace. However, you will be able to monitor the connection health of your
network and spot errors with a single glance.

## What can I do with it?

### Differences between UMH Lite and Classic

The UMH Lite does not offer all features of the UMH Classic. In the table below,
you can find a comparison between both, and check if the UMH Lite fulfills your
needs.

| Feature                   | Classic | Lite |
|---------------------------|:-------:|:----:|
| Historian                 |    ✓    |      |
| Analytics                 |    ✓    |      |
| Data Visualization        |    ✓    |      |
| UNS (Kafka & MQTT)        |    ✓    |      |
| Alerting                  |    ✓    |      |
| Connectivity: OPC UA      |    ✓    |  ✓   |
| Connectivity: Node-RED    |    ✓    |      |
| Network Monitoring        |    ✓    |  ✓   |
| UMH Data Model v1         |    ✓    |  ✓   |
| Tag Browser for your UNS  |    ✓    |      |

### Connect devices and add protocol converters

You can connect external devices like a PLC with an OPC UA server to a running
UMH Lite instance and contextualize the data from it with a [protocol
converter](https://umh.docs.umh.app/docs/features/connectivity/benthos-umh/).
For contextualization, you have to use the
[UMH Data Model v1](https://umh.docs.umh.app/docs/datamodel/messages/).

### Send data to your own infrastructure

All the data that your instance is gathering is sent to your own data
infrastructure. You can configure a target MQTT broker in the instance settings
by clicking on it in the Management Console.

### Monitor your network health

By using the UMH Lite in conjunction with the Management Console, you can spot
errors in the network. If a connection is faulty, the Management Console will
mark it.

### Convert to a UMH Classic

Should you find the UMH Lite insufficient and require the features offered by
UMH Classic, you can upgrade through the Management Console. This change will 
preserve the configurations of your devices and protocol converters: Their data 
continues to be forwarded to your initial MQTT broker, while also becoming 
accessible within your new Unified Namespace and database. Any protocol
converters introduced post-upgrade will also support the original MQTT broker as
an additional output. You can manually remove the original MQTT broker as an
output after the upgrade. Once removed, data will no longer be forwarded to the
initial MQTT broker.


## How can I use it?

To add a new UMH Lite instance, simply follow the regular 
[installation process](https://umh.docs.umh.app/docs/getstarted/installation/)
and select UMH Lite instead of UMH Classic. You can follow the next steps in
the linked guide to learn how to connect devices and add a protocol converter.

## What are the limitations?

The UMH Lite is a very basic version and only offers you the gathering and
contextualization of your data as well as the monitoring of the network. Other
features like a historian, data visualization, and a Unified Namespace are only
available by using the UMH Classic.
Additionally, converting to a UMH Classic requires an SSH connection, similar
to what is needed during the initial installation.


## Where to get more information?

- Learn how to [install a UMH Lite](https://umh.docs.umh.app/docs/getstarted/installation/).
- Learn how to [gather your data](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/).
- Read about our [Data Model](https://umh.docs.umh.app/docs/datamodel/messages/) to keep your data organized and contextualized.
