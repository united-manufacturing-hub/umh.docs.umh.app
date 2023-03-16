+++
title = "Data connectivity with Node-RED"
menuTitle = "Data connectivity with Node-RED"
description = ""
weight = 4
draft = false
+++

One feature of the UMH is to connect devices on the shopfloor such as PLCs, Quality Stations or MES / ERP systems with the Unified Namespace using Node-RED. 
Node-RED has a large library of nodes, which lets you connect various protocols. It also has a user-friendly UI
with little code, making it easy to configure the desired nodes.

![](/images/features/ifm-retrofitting/noderedDifferentProtocols.png?width=60%)

## When should I use it?

Sometimes it is necessary to connect a lot of different protocols (e.g Siemens-S7, OPC-UA, Serial, ...) and node-RED can be a maintainable
solution to connect all these protocols without the need for other data connectivity tools. Node-RED is largely known in 
the IT/OT-Community making it a familiar tool for a lot of users.

## What can I do with it?

By default, you can
- connect to MQTT using the MQTT node
- connect to HTTP using the HTTP node
- connect to TCP using the TCP node
- connect to IP using the UDP node

By installing additional packages, you can:
- connect to OPC-UA (node-red-contrib-opcua)
- connect to kafka (node-red-contrib-kafkajs)
- connect to Siemens-S7 (node-red-contrib-s7)
- connect to serial (node-red-node-serialport)
- connect to modbus (node-red-contrib-modbus had)
- connect to MC-protocol (node-red-contrib-mcprotocol)
- connect to OMRON FINS Ethernet protocol (node-red-contrib-omron-fins)
- connect to EtherNet/IP Protocol (node-red-contrib-cip-ethernet-ip)
- connect to PostgreSQL (node-red-contrib-postgresql)
- connect to SAP SQL Anywhere

You can additionally contextualize the data, using function or other different nodes do manipulate the 
received data.

## How can I use it?

Node-RED comes preinstalled as a microservice with the United Manufacturing Hub.

1. To access Node-RED navigate to **network**->**services** on the left-hand side in UMHLens. You can download UMHLens [here](https://github.com/united-manufacturing-hub/UMHLens/releases).
2. Change the namespace to **Namespace: united-manufacturing-hub** at the top right.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingServices.png?width=75%)

3. Click on **united-manufacturing-hub-nodered-service** and scroll down to **Connection** and forward the port.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingForwarding.png?width=75%)
4. Once Node-RED opens in the browser, add `nodered` to the URL to avoid the [cannot get error](https://learn.umh.app/course/how-to-fix-cannot-get-error-in-node-red/).
5. To install custom nodes, Click on the **Menu** button in the upper right-hand corner of the screen and select **Manage palette** from the drop-down menu.

   ![](/images/features/data-connectivity-node-red/nodered_dropdownMenu.png)
6. In the **Manage palette** menu, select the **Install** tab.

   ![](/images/features/data-connectivity-node-red/noderedManagePalette.png?width=70%)
7. Use the search bar to find the plugin/node that you want to install.
8. Click on the **Install** button next to the plugin/node to install it and wait for the installation to complete.
9. Now you can configure your
TODO: link to tutorial on how to Process the data and align it with the UMH datamodel (learn)



## What are the limitations?

- most packages have no enterprise support. If you encounter any errors, you need to ask the community. 
  However, we found that these packages are often more stable than the commercial ones out there, 
  as they have been battle tested by way more users than commercial software.
- having many flows without following a strict structure, leads in general to confusion.
- one additional limitation is "the speed of development of Node-RED". After a big Node-RED and JavaScript update
  dependencies most likely break, and those single community maintained nodes need to be updated.

## Where to get more information?

- Learn more about Node-RED and the United Manufacturing Hub by following our [Get started guide](/docs/getstarted/) .
- Learn more about [Best-practices & guides for Node-RED](https://learn.umh.app/topic/node-red/).
- Learn how to connect [Node-RED to SAP SQL Anywhere](https://learn.umh.app/course/connecting-to-sap-sql-anywhere-using-a-custom-node-red-instance/) with a custom docker instance.
- Checkout the [industrial forum](https://discourse.nodered.org/c/industrial/18) for Node-RED
