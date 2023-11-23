---
title: "3. Data Acquisition and Manipulation"
menuTitle: "3. Data Acquisition and Manipulation"
description: |
   Learn how to connect various data sources to the UMH and format data into the
   UMH data model.
weight: 3000
---

The United Manufacturing Hub excels in its ability to integrate diverse data
sources and standardize data into a unified model, enabling seamless integration
of existing data infrastructure for analysis and processing.

Currently, data sources can be connected to the UMH through Benthos for OPC UA
and [Node-RED](/docs/architecture/microservices/core/node-red/) for other types.

The UMH includes 3 pre-configured data simulators for testing connections:

- [OPC UA Simulator](/docs/architecture/microservices/community/opcua-simulator/)
- [MQTT Simulator](/docs/architecture/microservices/community/mqtt-simulator/)
- [PackML Simulator](/docs/architecture/microservices/community/packml-simulator/)

## Connect OPC UA Data Sources

OPC UA, often complex, can be streamlined using our Benthos-based OPC UA connector
accessible from the Management Console.

### Create a Connection with the Management Console

After logging into the Management Console and selecting your instance, navigate
to the **Data Connections** tab to view existing connections.

![Data Connections Overview](/images/getstarted/dataAcquisitionManipulation/dataConnectionsOverview.png?width=80%)

**Uninitialized Connections** are established but not yet configured as data
sources, while **Initialized Connections** are fully configured.***h

The health status reflects the UMH-data source connection, not data transmission status.

To add a new connection, click **Add Connection**. Currently, the only option is
OPC UA Server. Enter the server details, including the unique name and address
with protocol (`opc.tcp://`) and port (usually `4840`).

For testing with the OPC UA simulator, use:

```text
opc.tcp://united-manufacturing-hub-opcuasimulator-service:46010
```

![OPC UA Connection Details](/images/getstarted/dataAcquisitionManipulation/addConnectionDetails.png?width=80%)

Test the connection, and if successful, click **Add Connection**.

### Initialize the Connection

After adding, you must initialize the connection. This creates a new Benthos
deployment for data publishing to the UMH Kafka broker.

Navigate to **Data Sources** > **Uninitialized Connections** and initiate the
connection.

![Initialize Connection](/images/getstarted/dataAcquisitionManipulation/initializeConnection.png?width=80%)

Enter authentication details (use _Anonymous_ for no authentication, as with the
OPC UA simulator).

Specify OPC UA nodes to subscribe to in a yaml file, following the ISA95 standard:

```yaml
  nodes:
    - opcuaID: ns=2;s=Pressure,
      enterprise: pharma-genix,
      site: aachen,
      area: packaging,
      line: packaging_1,
      workcell: blister,
      originID: PLC13,
      tagName: machineState,
      usecase: _historian
```

Mandatory fields are `opcuaID`, `enterprise`, `tagName` and `useCase`.

{{% notice note %}}
Learn more about [Data Modeling in the Unified Namespace](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/)
in the Learning Hub.
{{% /notice %}}

Review and confirm the nodes, then proceed with initialization. Successful
initialization will be indicated by a green message.

The new data source will now appear in the **Data Sources** section.

![Data Sources Overview](/images/getstarted/dataAcquisitionManipulation/dataSourcesOverview.png?width=80%)

## Connect MQTT Data Sources

MQTT data sources can be connected to UMH exclusively through Node-RED.

To access Node-RED's web interface, navigate to:

```text
http://<instance-ip-address>:1880/nodered
```

Replace `<instance-ip-address>` with your UMH instance's IP. Ensure you're on the
same network for access.

### Add the MQTT Connection

In Node-RED, find the mqtt-in node from the node palette and drag it into your
flow. Double-click to configure and click the **pencil button** next to the
**Server** field.

Enter your MQTT broker's details:

- **Server**: united-manufacturing-hub-mqtt
- **Port**: 1883

(For UMH MQTT Simulator, use the settings above.)

Click **Add** to save.

![Connect MQTT to Node-RED](/images/getstarted/dataAcquisitionManipulation/noderedMqttConnection.png?width=80%)

Define the subscription topic. For example,
`ia/raw/development/ioTSensors/Temperature` is used by the MQTT Simulator.

To test, link a debug node to the mqtt-in node and deploy. Open the debug pane
by clicking on the **bug** icon on the top right of the screen to view messages
from the broker.

![MQTT Debug Connection](/images/getstarted/dataAcquisitionManipulation/noderedMqttDebugConnection.png)

{{% notice note %}}
Explore [Unified Namespace](/docs/features/unified-namespace) for details on topic structuring.
{{% /notice %}}

### Format Incoming Messages

Use a function node to format raw data. Connect it to the mqtt-in node and paste
this script:

```jsx
msg.payload = String(msg.payload)
msg.key = "temperatureCelsius"

return msg;
```

Finalize with **Done**.

{{% notice note %}}
This function transforms the payload into a string, meeting Kafka's data requirements.
{{% /notice %}}

### Send Formatted Data to Kafka

For this guide, we'll send data to the UMH Kafka broker.

Ensure you have node-red-contrib-kafkajs installed. If not, see
[How to Get Missing Plugins in Node-RED](https://learn.umh.app/course/how-to-get-missing-plugins-in-node-red/).

Add a kafka-producer node, connecting it to the function node. Configure as follows:

- **Broker**: united-manufacturing-hub-kafka:9092
- **Client ID**: nodered

**Update** to save.

Structure Kafka topics according to UMH data model:

```text
umh.v1.<enterprise>.<site>.<area>.<line>.<workcell>.<originID>.<tagName>.<usecase>
```

Example topic for this tutorial:

```text
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister
```

To learn more about the UMH data-model, read the [documentation](/docs/architecture/datamodel).

Click **Done** and deploy.

{{% notice note %}}
Optional: Add a debug node for output visualization.
{{% /notice %}}

![Node-RED MQTT to Kafka](/images/getstarted/dataAcquisitionManipulation/noderedMqttKafka.png?width=80%)

## Connect Kafka Data Sources

Kafka data sources can be integrated with UMH exclusively through Node-RED.

To access Node-RED's web interface, navigate to:

```text
http://<instance-ip-address>:1880/nodered
```

Replace `<instance-ip-address>` with your UMH instance's IP, ensuring you're on the
same network for access.

Before proceeding, make sure the node-red-contrib-kafkajs plugin is installed.
For installation guidance, see
[How to Get Missing Plugins in Node-RED](https://learn.umh.app/course/how-to-get-missing-plugins-in-node-red/).

### Add the Kafka Connection

In Node-RED, locate the kafka-consumer node and drag it into your flow.
Double-click to configure and click the pencil button beside the **Server** field.

Enter your Kafka broker's details:

- **Server**: united-manufacturing-hub-kafka
- **Port**: 9092

Click **Add** to save.

![Connect Kafka to Node-RED](/images/getstarted/dataAcquisitionManipulation/noderedKafkaConnection.png?width=80%)

Set the subscription topic. For demonstration, we'll use the topic created earlier:

```text
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister
```

Link a debug node to the kafka-consumer node, deploy, and observe messages in the
debug pane.

![Kafka Debug Connection](/images/getstarted/dataAcquisitionManipulation/noderedKafkaDebugConnection.png?width=30%)

{{% notice note %}}
For topic structuring guidelines, refer to [Unified Namespace](/docs/features/unified-namespace).
{{% /notice %}}

### Format Incoming Messages

Since the data is already processed from the previous step, use a function node
to convert the temperature from Celsius to Fahrenheit. Connect it to the
kafka-consumer node and paste the following script:

```jsx
if (msg.payload.key != "temperatureCelsius") {
    return null;
}
var celsius = Number(msg.payload.value)
var fahrenheit = (celsius * 9 / 5) + 32

msg.payload = String(fahrenheit)
msg.key = "temperatureFahrenheit" // Save using a different key

return msg;
```

This script selectively processes messages with the temperatureCelsius key,
converting the value to Fahrenheit.

Finalize with **Done**.

### Send Formatted Data Back to Kafka

Now, we'll route the transformed data back to the same UMH Kafka broker topic,
showcasing contextualized data sharing within the same topic by altering the key.

Add a kafka-producer node, connecting it to the function node. Use the same
Kafka client as earlier, and the same topic for output:

```text
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister
```

For more on UMH data modeling, consult the [documentation](/docs/architecture/datamodel).

Press **Done** and deploy.

{{% notice note %}}
Consider adding a debug node for visualizing output data.
{{% /notice %}}

![Node-RED Kafka to Kafka](/images/getstarted/dataAcquisitionManipulation/noderedKafkaKafka.png?width=80%)

## {{% heading "troubleshooting" %}}

### I Can't Connect an OPC UA Data Souurce to the Management Console

## What's next?

  Continue with the tutorial in the Management Console. The next chapter will
  be about the use of Grafana to [display the formatted data](https://umh.docs.umh.app/docs/getstarted/datavisualization/) to proceed.
