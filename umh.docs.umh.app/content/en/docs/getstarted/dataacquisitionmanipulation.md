---
title: "3. Data Acquisition and Manipulation"
menuTitle: "3. Data Acquisition and Manipulation"
description: |
  Learn how to connect various protocol converters to the UMH and format data into the
  UMH data model.
weight: 3000
---

The United Manufacturing Hub excels in its ability to integrate diverse
protocol converters and standardize data into a unified model, enabling
seamless integration of existing data infrastructure for analysis and
processing.

Protocol converters can be connected to the UMH through [Benthos UMH](/docs/features/connectivity/benthos-umh/),
which supports various protocols including OPC UA, as well as other types through the
**Universal Protocol Converter** feature available in the Management Console.

The UMH includes 3 pre-configured data simulators for testing connections:

- [OPC UA Simulator](/docs/architecture/microservices/community/opcua-simulator/)
- [MQTT Simulator](/docs/architecture/microservices/community/mqtt-simulator/)
- [PackML Simulator](/docs/architecture/microservices/community/packml-simulator/)

## Connect OPC UA Servers

OPC UA, often complex, can be streamlined using our Benthos-based OPC UA connector
accessible from the Management Console.

### Visualize Network Devices or External Services

In the **Network View**, you can visualize the network devices a UMH instance is connected to.
This view provides the latest status of both the instances and the network devices, including
external services.

First, let’s define what we mean by network devices and external services. A network device refers
exclusively to any physical device located on the shop floor that is assigned an IP address. This
includes machinery, sensors, and any hardware components that communicate over the network.

External services, on the other hand, encompass both virtual devices and services accessed beyond
the local network. Virtual devices, such as software systems that have network capabilities but are
not physically housed on the shop floor, fall into this category because they require network
interaction. Additionally, on-premises and cloud-hosted applications like ERP systems equipped with
REST interfaces also fall under external services.

**Network devices** encompass physical devices with IP addresses as well as virtual devices that
may exist in cloud environments or services accessed over the network, such as ERP systems with
REST interfaces. **External services** refer to any services accessed externally, whether they
are hosted on-premises or in the cloud.

![Network View](/images/getstarted/dataAcquisitionManipulation/networkViewDevice.png?width=80%)

You can also monitor the status of each UMH instance and the network devices it's connected to.
If a device is marked in red, it indicates an unhealthy connection, this could be due to various
reasons such as high latency or being unreachable. While green indicates a healthy connection.

### Add the Network Device/Service

To add a new network device or external service, navigate to the **Component View** and access
the **Protocol Converter** tab. Here, you'll find all your network devices/services alongside their status,
including more detailed information and configuration options for both devices and protocol converters.

![Protocol Converters](/images/getstarted/dataAcquisitionManipulation/protocolConverters.png?width=80%)

**Uninitialized Network Devices/Services** are established but not yet configured as protocol
converters, while **Initialized Network Devices/Services** are fully configured.

The health status reflects the UMH-data source connection, not data transmission status.

To add one, click **Add Device or External Service**.

Enter the required server details, which include the unique name, IP address and port number.
Optionally, you can also attach some notes, which can be useful for documentation purposes.

For testing with the OPC UA simulator, enter the following details:

- **Name**: OPC UA Simulator
- **IP Address**: united-manufacturing-hub-opcuasimulator-service
- **Port**: 46010

Test the connection, and if successful, click **Save Network Device/Service** to save and deploy it.

### Configure the Protocol Converter

Back at **Protocol Converters**, your new device should be listed in the table, and surely you'll notice that it's health is reported as `Not configured`.

At this point, it's worth discussing what initializing a device means and why it's important.

New devices are created in an "uninitialized" state, meaning they are not yet configured as protocol converters, hence the `Not configured` health status.
So for them to be actually useful, they need to be initialized, which will fully configure them as protocol converters and create a new Benthos deployment for data publishing to the UMH Kafka broker.

Initialize it by pressing the "play" button under the `Actions` column.

Enter authentication details (use _Anonymous_ for no authentication, as with the
OPC UA simulator).

Specify OPC UA nodes to subscribe to in a yaml file, following the ISA95 standard:

```yaml
nodes:
  - opcuaID: ns=2;s=Pressure
    enterprise: pharma-genix
    site: aachen
    area: packaging
    line: packaging_1
    workcell: blister
    originID: PLC13
    tagName: machineState
    schema: _historian
```

Mandatory fields are `opcuaID`, `enterprise`, `tagName` and `schema`.

{{% notice note %}}
Learn more about [Data Modeling in the Unified Namespace](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/)
in the Learning Hub.
{{% /notice %}}

Review and confirm the nodes, then proceed with initialization. Successful
initialization will be indicated by a green message.

The device's health status should now be marked as `Healthy` and display the
current message rate. You can also check the tooltip for more details.

## Connect MQTT Servers

This guide will cover two methods for integrating MQTT data: using the
Management Console's Universal Protocol Converter (UPC) for a streamlined
approach, and using Node-RED as an alternative method.

### Using the Management Console

The Management Console features a **Universal Protocol Converter**, which works with
[Benthos UMH](/docs/features/connectivity/benthos-umh/) under the hood to connect and
process data from a wide variety of protocols, including MQTT.

#### Add the Network Device/Service

Similar to OPC UA, you need to add the MQTT broker as a network device/service.
Navigate to the **Component View** and access the **Protocol Converter** tab.
Click **Add Device or External Service**, and enter the following details for
the MQTT simulator:

- **Name**: MQTT Simulator
- **IP Address**: united-manufacturing-hub-mqtt.united-manufacturing-hub.svc.cluster.local
- **Port**: 1883

Test the connection, and if successful, save it.

#### Configure the Protocol Converter

Back in the **Protocol Converters** tab, your new MQTT broker should be listed.
Initialize it by pressing the "play" button under the `Actions` column. When
prompted to select a protocol, choose the **Universal Protocol Converter**.

In the Benthos configuration page, you need to define the `input` and `processor`
configurations in YAML format. To simplify this process, you can use the provided
sample configuration for MQTT, which offers an easier starting point. Click on the
**MQTT** button under the "Supported Protocols" section and apply it.

This configuration connects to the UMH MQTT broker, subscribes to IoT sensor data
topics, and assigns the data as weather information for the site `cologne` in the
**Unified Namespace**.

{{% notice info %}}
If you are testing with the UMH MQTT simulator, the sample configuration will work
out of the box. For other MQTT brokers, you may need to adjust the configuration.
{{% /notice %}}

Press **Save** to deploy your configuration.

If you've followed the steps correctly, the MQTT broker should now be connected
and processing data.

#### Tag Browser

You can view the data in the **Tag Browser**. The data is structured according to
the ISA95 standard and displayed in a tree structure for easy navigation.

![Tag Browser](/images/getstarted/dataAcquisitionManipulation/tagBrowserHumidity.png?width=80%)

### Using Node-RED (Optional)

Alternatively, you can use Node-RED to connect to the MQTT server and format data
into the UMH data model. Same as before, we'll use the UMH MQTT simulator for this
guide.

To access Node-RED's web interface, navigate to:

```text
http://<instance-ip-address>:1880/nodered
```

Replace `<instance-ip-address>` with your UMH instance's IP. Ensure you're on the
same network for access.

#### Add the MQTT Connection

In Node-RED, find the mqtt-in node from the node palette and drag it into your
flow. Double-click to configure and click the **pencil button** next to the
**Server** field.

Enter your MQTT broker's details:

- **Server**: united-manufacturing-hub-mqtt.united-manufacturing-hub.svc.cluster.local
- **Port**: 1883

{{% notice info %}}
For the purpose of this guide, we'll use the UMH MQTT broker, even though the
data coming from it is already bridged to Kafka by the
[MQTT Kafka Bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/).
Since the simulated data is using the old Data Model, we'll use Node-RED to
convert it to the new Data Model.
{{% /notice %}}

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

#### Format Incoming Messages

Use a function node to format raw data. Connect it to the mqtt-in node and paste
this script:

```js
msg.payload = {
  timestamp_ms: Date.now(),
  temperature: msg.payload,
};
return msg;
```

Finalize with **Done**.

Then, connect a JSON node to the function node to parse the object into a string.

{{% notice note %}}
This function transforms the payload into the correct format for the UMH data model.
{{% /notice %}}

#### Send Formatted Data to Kafka

For this guide, we'll send data to the UMH Kafka broker.

Ensure you have node-red-contrib-kafkajs installed. If not, see
[How to Get Missing Plugins in Node-RED](https://learn.umh.app/course/how-to-get-missing-plugins-in-node-red/).

Add a kafka-producer node, connecting it to the JSON node. Configure as follows:

1.  Open the configuration menu by double-click on the kafka-producer node.
    After that, click on the edit button.

        ![Node-RED Kafka Producer](/images/getstarted/dataAcquisitionManipulation/noderedKafkaProducer.png)

2.  Change the fields of `Brokers` and `Client ID` as follows:

    - **Brokers**: united-manufacturing-hub-kafka:9092
    - **Client ID**: nodered

    ![Node-RED Kafka Broker Configuration](/images/getstarted/dataAcquisitionManipulation/noderedKafkaBrokerConfigure.png)

    Click on **Update** to save.

3.  Structure Kafka topics according to UMH data model, following the ISA95 standard:

    ```text
    umh.v1.<enterprise>.<site>.<area>.<line>.<workcell>.<originID>.<schema>.<tagName>
    ```

    - `umh.v1`: obligatory versioning prefix
    - `enterprise`: The company's name
    - `site`: The facility's location
    - `area`: The specific production's area
    - `line`: The production line
    - `workcell`: The workcell in the production line
    - `originID`: The data source ID
    - `schema`: The schema of your data
    - `tagName`: Arbitrary tags dependent context

    The enterprise and schema fields are required.
    To learn more about the UMH data-model, read the [documentation](/docs/architecture/datamodel).

    For example, if you want to structure a topic for the temperature in celsius
    from the PLC, which

    - is running in a factory of Pharma-Genix in Aachen.
    - is running in `blister` workcell in the packaging line 1 in the packaging area.
    - has the ID `PLC13`.

    and you want to use `_historian` schema, then the topic should look like

    ```text
    msg.topic = umh.v1.pharma-genix.aachen.packaging.packaging_1.blister.PLC13._historian.temperatureCelsius
    ```

    Add this topic to the script in the function node, which created in
    [Format Incoming Messages](/docs/getstarted/dataacquisitionmanipulation/#format-incoming-messages)
    section.

    ![Node-RED Kafka Topic](/images/getstarted/dataAcquisitionManipulation/noderedKafkaProducerTopic.png)

    Alternatively, you can set the topic to the kafka-producer node directly.

4.  Click **Done** and deploy.

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

{{% notice info %}}
If you have followed the guide, the kafka client should already be configured and
automatically selected.
{{% /notice %}}

Enter your Kafka broker's details:

- **Brokers**: united-manufacturing-hub-kafka:9092
- **Client ID**: nodered

Click **Add** to save.

![Connect Kafka to Node-RED](/images/getstarted/dataAcquisitionManipulation/noderedKafkaConnection.png?width=80%)

Set the subscription topic. For demonstration, we'll use the topic created earlier:

```text
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister.PLC13._historian.temperatureCelsius
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
const payloadObj = JSON.parse(msg.payload.value);
const celsius = payloadObj.temperature;
const fahrenheit = (celsius * 9) / 5 + 32;

msg.payload = {
  timestamp_ms: Date.now(),
  temperature: fahrenheit,
};

return msg;
```

Finalize with **Done**.

Then, connect a JSON node to the function node to parse the object into a string.

### Send Formatted Data Back to Kafka

Now, we'll route the transformed data back to the Kafka broker, in a different
topic.

Add a kafka-producer node, connecting it to the JSON node. Use the same
Kafka client as earlier, and the same topic for output:

```text
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister.PLC13._historian.temperatureFahrenheit
```

For more on UMH data modeling, consult the [documentation](/docs/datamodel).

Press **Done** and deploy.

{{% notice note %}}
Consider adding a debug node for visualizing output data.
{{% /notice %}}

![Node-RED Kafka to Kafka](/images/getstarted/dataAcquisitionManipulation/noderedKafkaKafka.png?width=80%)

## {{% heading "whatsnext" %}}

Next, we'll dive into [Data Visualization](/docs/getstarted/datavisualization),
where you'll learn to create Grafana dashboards using your newly configured data
sources. This next chapter will help you visualize and interpret your data effectively.
