---
title: Benthos UMH
menuTitle: Benthos UMH
description: |
  Configure OPC-UA data sources to stream data to Kafka directly in the
  Management Console.
weight: 2000
draft: false
---

[Benthos](https://www.benthos.dev/docs/about) is a stream processing tool that
is designed to make common data engineering tasks such as transformations,
integrations, and multiplexing easy to perform and manage. It uses declarative,
unit-testable configuration, allowing users to easily adapt their data
pipelines as requirements change. Benthos is able to connect to a wide range of
sources and sinks, and can use different languages for processing and mapping
data.

[Benthos UMH](/docs/features/connectivity/benthos-umh/) is a custom extension of
Benthos that is designed to connect to OPC-UA servers and stream data into the
Unified Namespace.

## When should I use it?

OPC UA is a communication protocol coming from the OT industry, so integration
with IT tools is necessary to stream data from an OPC UA server. With Benthos
UMH, you can easily connect to an OPC UA server, define the nodes you want to
stream, and send the data to the Unified Namespace.

## What can I do with it?

Benthos UMH offers some benefits over mainline Benthos, including:

- **Management Console integration**: Configure and deploy any number of
  Benthos UMH instances directly from the Management Console.
- **OPC-UA support**: Connect to any OPC-UA server and stream data into the
  Unified Namespace.
- **Per-node configuration**: Define the nodes you want to stream and configure
  them individually.
- **Broad customization**: Use Benthos' extensive configuration options to
  customize your data pipeline.
- **Easy deployment**: Deploy Benthos UMH as a standalone Docker container or
  directly from the Management Console.
- **Fully open source**: Benthos UMH is fully open source and available on
  [Github](https://github.com/united-manufacturing-hub/benthos-umh).

## How can I use it?

### Standalone
To use benthos-umh in standalone mode with Docker, follow this instructions.
1. Create a new file called benthos.yaml with the provided content
    ``` yaml

    input:
    opcua:
        endpoint: 'opc.tcp://localhost:46010'
        nodeIDs: ['ns=2;s=IoTSensors']

    pipeline:
    processors:
        - bloblang: |
            root = {
            meta("opcua_path"): this,
            "timestamp_ms": (timestamp_unix_nano() / 1000000).floor()
            }

    output:
    mqtt:
        urls:
        - 'localhost:1883'
        topic: 'ia/raw/opcuasimulator/${! meta("opcua_path") }'
        client_id: 'benthos-umh'
    ```

2. Execute the docker run command to start a new benthos-umh container 
    ``` bash
    docker run --rm --network="host" -v '<absolute-path-to-your-file>/benthos.yaml:/benthos.yaml' ghcr.io/united-manufacturing-hub/benthos-umh:latest
    ```
    
### With the UMH's Management Console

If you want to integrate an OPC-UA server with the UMH, you can deploy the benthos-umh with the UMH's Management Console. 

#### Create a connection
1. After logging into the Management Console and selecting your instance, navigate to the **Data Connections** tab to view existing connections.
![Data Connections Overview](/images/getstarted/dataAcquisitionManipulation/dataConnectionsOverview.png?width=80%)

2. To add a new connection, click **Add Connection**, then select OPC UA Server. After that, enter the server details, including the unique name and address with protocol (opc.tcp://) and port (usually 4840).

    For testing with the OPC UA simulator, use:
    ``` text
    opc.tcp://united-manufacturing-hub-opcuasimulator-service:46010
    ```

    Test the connection, and if successful, click Add Connection.

#### Initialize the Connection
After adding a new connection, you must initialize it. This process creates a new benthos-umh deployment for data publishing to the UMH Kafka broker.

1. Navigate to **Data Sources** > **Uninitialized Connections** and initiate the connection.

    ![Initialize Connection](/images/getstarted/dataAcquisitionManipulation/initializeConnection.png?width=80%)

2. Enter authentication details (use Anonymous for no authentication, as with the OPC UA simulator).

3. Specify OPC UA nodes to subscribe to in a yaml file. For testing the OPC UA simulator, you can use:

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
        useCase: _historian
    ```

    Mandatory fields are `opcuaID`, `enterprise`, `tagName` and `useCase`.

{{% notice note %}}
Learn more about [Data Model](/docs/datamodel) in our documentation.
{{% /notice %}}

4. Review and confirm the nodes, then proceed with initialization. Successful initialization will be indicated by a green message.

5. The new data source will now appear in the **Data Sources** section.

    ![Data Sources Overview](/images/getstarted/dataAcquisitionManipulation/dataSourcesOverview.png?width=80%)


## What are the limitations?


## Where to get more information?
- Learn more about benthos-umh by visiting our [Github repository](https://github.com/united-manufacturing-hub/benthos-umh).
- Learn more about [Data Model](/docs/datamodel) in our documentation.