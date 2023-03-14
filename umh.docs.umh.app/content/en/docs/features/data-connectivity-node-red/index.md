+++
title = "Data connectivity with Node-RED"
menuTitle = "Data connectivity with Node-RED"
description = ""
weight = 4
draft = false
+++

Node-red has a large library of nodes, which lets you connect various protocols. It also has a user-friendly UI 
with little code, making it easy to configure the desired nodes. 

![](/images/features/ifm-retrofitting/noderedDifferentProtocols.png?width=60%)

## When should I use it?

Sometimes it is necessary to connect a lot of different protocols (e.g Siemens-S7, OPC-UA, Serial, ...) and node-red can be a maintainable
solution to connect all these protocols without the need for other data connectivity tools. Node-RED is largely known in 
the IT/OT-Community making it a familiar tool for a lot of users.

## What can I do with it?

By default, you can
- connect to MQTT using the MQTT node
- connect to HTTP using the HTTP node

By installing additional packages, you can:
- connect to OPC-UA (node-red-contrib-opcua)
- connect to kafka (node-red-contrib-kafkajs)
- connect to Siemens-S7 (node-red-contrib-s7)
- connect to serial (node-red-node-serialport)

You can additionally contextualize the data, using function or other different nodes do manipulate the 
received data.

## How can I use it?

Node-red comes preinstalled as a microservice with the umh. Follow our [get started](/docs/getstarted/) guide, 
to connect with node-red and create your first flow. We also have many [best practises & guides for Node-RED](https://learn.umh.app/topic/node-red/).

## What are the limitations?

- most packages have no enterprise support. If you encounter any errors, you need to ask the community. 
  However, we found that these packages are often more stable than the commercial ones out there, 
  as they have been battle tested by way more users than commercial software.
- having many flows without following a strict structure, leads to confusion for other users

## Where to get more information?

- [get started with the umh](/docs/getstarted/)
- [Best-practices & guides for Node-RED](https://learn.umh.app/topic/node-red/)