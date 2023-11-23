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

## Connect OPC UA data sources

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

## Connect MQTT data sources

MQTT data sources can be connected to UMH exclusively through Node-RED.

To access Node-RED's web interface, navigate to:

```text
http://<instance-ip-address>:1880/nodered
```

Replace `<instance-ip-address>` with your UMH instance's IP. Ensure you're on the
same network for access.

### Add the MQTT connection

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
umh.v1.pharma-genix.aachen.packaging.packaging_1.blister.PLC13.temperature._historian
```

To learn more about the UMH data-model, read the [documentation](/docs/architecture/datamodel).

Check **Allow Auto Topic Creation** in **Advanced Options** for automatic topic
creation if it doesn't exist.

Click **Done** and deploy.

{{% notice note %}}
Optional: Add a debug node for output visualization.
{{% /notice %}}

![Node-RED MQTT to Kafka](/images/getstarted/dataAcquisitionManipulation/noderedMqttKafka.png?width=80%)

## Connect Kafka data sources

## Connect HTTP data sources

## Creating Node-RED flow with simulated MQTT-Data

1. Access the Node-RED web interface through your local installation's device
   overview by selecting the **open** button on the Node-RED popup. You can
   access popups by clicking on the corresponding microservice tile.

2. To access the simulated raw data via MQTT, you need to add an MQTT broker.
   From the left-hand column, drag an **mqtt-in** node, an **mqtt-out** node, and
   a **debug** node into your flow and connect the **mqtt-in** and to the
   **debug** node.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqMan1.png)

3. Double-click on the **mqtt-in** node and click
   on the **pencil button** on the right  of the **Server** field. Use the 
  service name **united-manufacturing-hub-mqtt** as **Server** (or the name 
  located in the Management Console **Useful Information**-tab). Leave the
   port as autoconfigured and click on **Add** to save your changes.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/usefulInfoMgmt.png?width=50%)
4. To view all incoming messages from a specific topic, type `ia/#` under 
   **Topic** and click on **Done**.


   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManiaRaw.png?width=75%)
  
  {{% notice info %}}
In brokers like MQTT or Kafka, data is structured hierarchically in **topics**.
These topics categorize data into specific groups for efficient management.
If you subscribe to a topic, you receive every message that is published to it.
In the UMH data-model, the topics are defined in this format:

- **MQTT:** `ia/<customerID>/<location>/<AssetID>/<message>`
- **Kafka:** `ia.<customerID>.<location>.<AssetID>.<message>`

`customerID` represents the enterprise, `location` signifies the
factory from which the data originates, `AssetID` denotes the specific machine
generating the data, and the final segment `message` is the name of the
message or data.
{{% /notice %}}


5. To apply the changes, click on **Deploy** located at the top right of the 
   screen. Once the changes have been deployed, you can view the debug 
   information by clicking on **Debug-Messages** located under **Deploy**. 

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManDebugDeploy.png)

  {{% notice info %}}
  Messages sent to the `raw` topic are not stored in the UMH database and are
  not processed by the UMH stack. You can use them to build your own data
  processing pipelines like in this example. For additional information, 
  refer to the
  [data-model documentation](https://umh.docs.umh.app/docs/architecture/datamodel/#raw-data)
  {{% /notice %}}

6. In this column, you can view all incoming messages and their respective
   topics. The incoming topics follow this format:
   `ia/raw/development/ioTSensors/`. To keep it simple, this tutorial will be
   only using the temperature topic, but feel free to choose any
   topic you'd like. Copy the temperature topic
   `ia/raw/development/ioTSensors/Temperature`, open the **mqtt-in** node,
   paste the copied topic in the **Topic** field, click on **Done**, and then
   press **Deploy** again to apply the changes.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewTopic.png)

7. To format the incoming message according to the UMH data-model, add a
   **function** node, an **mqtt-out** and an **mqtt-in** to your flow. 
   Connect the nodes in the following order:
   **mqtt-in → function → mqtt-out** and the second flow: **mqtt-in → debug**.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewNodes.png)

{{% notice info %}}
Incoming messages are not following the UMH data-model. To contextualize and
format them correctly, you can use the different message types. This is needed,
to ensure that the data is correctly processed by the UMH stack and other 
consumers.

In the documentation, you can find the complete
[list](https://umh.docs.umh.app/docs/architecture/datamodel/messages/)
of all available message types and the respective topics.
{{% /notice %}}


8. Open the **function** node and paste in the following:

   ```jsx
   msg.payload = {
    
       "timestamp_ms": Date.now(), 
       "temperature": msg.payload
   }
   
   return msg;
   ```
   Now click on **Done**, open the **mqtt-out** node and paste 
   `ia/factoryinsight/Aachen/testing/processValue`
   in the **Topic** field and click on **Done**. To apply the changes, click 
   on **Deploy**. Now the message is correctly formatted into the data-model,
   specifically into a
   [processValue](https://umh.docs.umh.app/docs/architecture/datamodel/messages/processvalue/)
   message. 


  {{% notice info %}}
  We are creating a new object, an array, with two keys `timestamp_ms` and
  `temperature` and their corresponding values `Date.now()` and 
  `msg.payload`. The last value, `msg.payload`, is referring to the **incoming**
  message. Since it is only carrying a single value, one does not need to 
  further specify it. 
  
  We also created a new topic in the **mqtt-out** node, where the messages 
  will be sent to. The topic ends with the key **processValue** which is used
  whenever a custom process value with unique name has been prepared. The
  value is numerical. You can learn more about our message 
  structure [here](/docs/architecture/datamodel/messages/).
  {{% /notice %}}

9. Open the second **mqtt-in** node, connected to the **debug** node, and set
   the topic to `ia/factoryinsight/Aachen/testing/processValue`, to receive all 
   the new messages. Make sure to select the created broker. Click on **Deploy** 
   to save the changes. The flows should now look like this:

![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNodeCompl.png)

10. You should now see the converted message under **Debug-messages**. To clear
   any previous messages, click on the **trash bin** icon.
    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManDebugWindow.png)

11. Congratulations, you have successfully converted the incoming message and
   exported it via MQTT. However, since we are currently only exporting the 
   temperature without actually working with the data, let's create a function
   that counts the critical temperature exceedances.

12. Drag another **function-node** into your page, open it and navigate to
   **On Start**.

![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManOnStartNew.png)


13. Paste in the following code, which will only run on start:

    ```jsx
    flow.set("count", 0);
    flow.set("current", 0)
    ```

14. Then click on **On-Message** and paste in the following and click **done**:

    ```jsx
    flow.set("current",msg.payload);
    
    if (flow.get("current") > 47) {
        flow.set("count", flow.get("count") + 1);
    
        msg.payload = {
            "timestamp_ms":Date.now(),
            "TemperatureWarning":flow.get("count")
        }
        return msg;
    }
    ```

    The pasted in code will work for each new message as shown in the diagram below.
    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManTemperatureWarning.png)

15. Finally, connect the function-node like shown below and click on **deploy**.
    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewFunction2.png)

16. If the incoming value of temperature is now greater than 47, you will see
   another message consisting of **TemperatureWarning** and a **timestamp** in 
   debug-messages.

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManGreaterThan.png)

## {{% heading "troubleshooting" %}}

### I Can't Connect an OPC UA Data Souurce to the Management Console

## What's next?

  Continue with the tutorial in the Management Console. The next chapter will
  be about the use of Grafana to [display the formatted data](https://umh.docs.umh.app/docs/getstarted/datavisualization/) to proceed.
