---
title: Node-RED
menuTitle: Node-RED
description: Connect devices on the shop floor using Node-RED with United Manufacturing Hub's Unified Namespace. Simplify data integration across PLCs, Quality Stations, and MES/ERP systems with a user-friendly UI.
weight: 1000
aliases:
  - /docs/features/data-connectivity-node-red/
---

One feature of the United Manufacturing Hub is to connect devices on the shopfloor such as PLCs, Quality Stations or
MES / ERP systems with the Unified Namespace using Node-RED.
Node-RED has a large library of nodes, which lets you connect various protocols. It also has a user-friendly UI
with little code, making it easy to configure the desired nodes.

![](/images/features/ifm-retrofitting/noderedDifferentProtocols.png?width=60%)

## When should I use it?

Sometimes it is necessary to connect a lot of different protocols (e.g Siemens-S7, OPC-UA, Serial, ...) and node-RED can be a maintainable
solution to connect all these protocols without the need for other data connectivity tools. Node-RED is largely known in
the IT/OT-Community making it a familiar tool for a lot of users.

## What can I do with it?

By default, there are connector nodes for common protocols:

- connect to MQTT using the MQTT node
- connect to HTTP using the HTTP node
- connect to TCP using the TCP node
- connect to IP using the UDP node

Furthermore, you can install packages to support more connection protocols. For example:

- connect to OPC-UA ([node-red-contrib-opcua](https://flows.nodered.org/node/node-red-contrib-opcua))
- connect to kafka ([node-red-contrib-kafkajs](https://flows.nodered.org/node/node-red-contrib-kafkajs))
- connect to Siemens-S7 ([node-red-contrib-s7](https://flows.nodered.org/node/node-red-contrib-s7))
- connect to serial ([node-red-node-serialport](https://flows.nodered.org/node/node-red-node-serialport))
- connect to modbus ([node-red-contrib-modbus](https://flows.nodered.org/node/node-red-contrib-modbus))
- connect to MC-protocol ([node-red-contrib-mcprotocol](https://flows.nodered.org/node/node-red-contrib-mcprotocol))
- connect to OMRON FINS Ethernet protocol ([node-red-contrib-omron-fins](https://flows.nodered.org/node/node-red-contrib-omron-fins))
- connect to EtherNet/IP Protocol ([node-red-contrib-cip-ethernet-ip](https://flows.nodered.org/node/node-red-contrib-cip-ethernet-ip))
- connect to PostgreSQL ([node-red-contrib-postgresql](https://flows.nodered.org/node/node-red-contrib-postgresql))
- connect to [SAP SQL Anywhere](https://learn.umh.app/course/connecting-to-sap-sql-anywhere-using-a-custom-node-red-instance/)

You can additionally contextualize the data, using function or other different nodes do manipulate the
received data.

## How can I use it?

Node-RED comes preinstalled as a microservice with the United Manufacturing Hub.

1. To access Node-RED, simply open the following URL in your browser:

```text
http://<instance-ip-address>:1880/nodered
```

2. Begin exploring right away! If you require inspiration on where to start, we provide a variety of guides to help you
   become familiar with various node-red workflows, including how to process data and align it with the UMH datamodel:

   - [Create a Node-RED Flow with Simulated OPC-UA Data](https://learn.umh.app/course/creating-a-node-red-flow-with-simulated-opc-ua-data/)
   - [Create a Node-RED flow with simulated PackML data](https://learn.umh.app/course/creating-a-node-red-flow-with-packml/)
   - Alternatively, visit [learning page](https://learn.umh.app/topic/node-red/) where you can find multiple best practices for using Node-RED

## What are the limitations?

- Most packages have no enterprise support. If you encounter any errors, you need to ask the community.
  However, we found that these packages are often more stable than the commercial ones out there,
  as they have been battle tested by way more users than commercial software.
- Having many flows without following a strict structure, leads in general to confusion.
- One additional limitation is "the speed of development of Node-RED". After a big Node-RED and JavaScript update
  dependencies most likely break, and those single community maintained nodes need to be updated.

## Where to get more information?

- Learn more about Node-RED and the United Manufacturing Hub by following our [Get started guide](/docs/getstarted/) .
- Learn more about [Best-practices & guides for Node-RED](https://learn.umh.app/topic/node-red/).
- Learn how to connect [Node-RED to SAP SQL Anywhere](https://learn.umh.app/course/connecting-to-sap-sql-anywhere-using-a-custom-node-red-instance/) with a custom docker instance.
- Checkout the [industrial forum](https://discourse.nodered.org/c/industrial/18) for Node-RED
