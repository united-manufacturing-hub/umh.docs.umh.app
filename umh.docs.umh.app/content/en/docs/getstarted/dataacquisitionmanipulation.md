---
title: "2. Data Acquisition and Manipulation"
menuTitle: "2. Data Acquisition and Manipulation"
description: |
  Learn how to connect your UMH to an OPC UA server and format data into the UMH data model.
weight: 3000
---

Once your UMH instance is up and running, you can follow this guide to learn
how to connect the instance to an OPC UA server. For this example we will use
the OPC UA simulator that is provided by your instance.

## Connect to external devices

You can connect your UMH instances to external devices using a variety of
protocols. This is done in the Management Console and consists of two steps.
First you connect to the device and check that your instance can reach it. The
second step is to create a protocol converter for the connection, in which you
define the data you want to collect and how it should be structured in your
unified namespace.

## Establishing a Connection
<!-- Can be shown, once the OPC UA simulator is preconfigured as a connection.
{{% notice note %}}
To allow you to experience the UMH as quickly as possible, the
connection to the internal OPC UA simulator is already pre-configured.
This section is therefore included for reference only and you can
continue with **Configuring a Protocol Converter** below.
{{% /notice %}}
This note can be used once the OPC UA Simulator is a pre-configured connection.
-->

1. To create a new connection, navigate to the **Connections** section in the
left hand menu and click on the **+ Add Connection** button in the top right
hand corner.

2. Under **General Settings** select your instance and give the connection a
  name. Enter the address and port of the device you want to connect to. To
  connect to the OPC UA Simulator, use
    - **IP:** united-manufacturing-hub-opcuasimulator-service
    - **Port:** 46010

   You can also set additional location fields to help you keep track of your
   of your connections. The fields already set by the selected instance are
   inherited and cannot be changed.

3. Once everything is set up, you can click **Save & Deploy**. The instance
will now attempt to connect to the device on the specified IP and port. If
there is no error, it will be listed in the **Connections** section.
  
   Click on the connection to view its details, to edit click on the
   **Configuration** button in the side panel.

## Add the Protocol Converter

1. To access the data from the OPC UA Simulator you need to add a
**Protocol Converter** to the connection. Click on the connection to
the OPC UA Simulator in the **Connections** table, then open
**Protocol Converter** in the side pane and click on the
**+ Add Protocol Converter** button.

2. First you need to select the protocol used to communicate with the device,
in this case **OPC UA**. This can be found under **General**.

3. **Input:** Many of the required details are already set, based on the
connection details. For this tutorial we are going to subscribe to two tags
on the OPC UA server. Copy the code below and replace the current `nodeIDs:`
with it.

   ```yaml
    nodeIDs:
      - ns=2;s=Pressure
      - ns=2;s=Temperature
   ```

   The **Input** should now look like this. Note that the indentation is
   important.

   ```yaml
    opcua:
      endpoint: opc.tcp://united-manufacturing-hub-opcuasimulator-service.united-manufacturing-hub.svc.cluster.local:46010
      username: ""
      password: ""
      subscribeEnabled: true
      useHeartbeat: true
      nodeIDs:
        - ns=2;s=Pressure
   ```

4. **Processing:** In this section you can manipulate the incoming data and
sort it into the desired asset. The auto-generated configuration will sort
each tag into the same asset based on the location used for the connection,
while the tag name will be based on the name of the tag on the OPC UA server.
  
   Further information can be found in the **OPC UA Processor** section next to
   the **Processing** field, for example how to create individual assets for
   each tag.

5. **Output:** The output section is generated entirely automatically by the
Management Console.

6. Now click on **Save & Deploy**. Your Protocol Converter will be added.

7. To view the data, navigate to the **Tag Browser** on the left. Here, you can
see all your tags. The tree on the left is build from the asset of each tag,
you can navigate it by clicking on the asset parts.

{{% notice note %}}
Find out more about [Data Modelling in the Unified Namespace](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/)
in the Learning Hub.
{{% /notice %}}

## {{% heading "whatsnext" %}}

Next, we'll dive into [Data Visualisation](/docs/getstarted/datavisualization),
where you'll learn how to create Grafana dashboards using your newly configured
data sources. The next chapter will help you visualise alize and interpret your data
effectively.
