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

Furthermore, [in our tests](https://learn.umh.app/blog/our-open-source-docker-container-to-connect-opc-ua-with-the-unified-namespace/#testing-existing-solutions),
Benthos has proven more reliable than tools like Node-RED, when it comes to
handling large amounts of data.

## What can I do with it?

Benthos UMH offers some benefits, including:

- **Management Console integration**: Configure and deploy any number of
  Benthos UMH instances directly from the Management Console.
- **OPC-UA support**: Connect to any OPC-UA server and stream data into the
  Unified Namespace.
- **Report by exception**: By configuring the OPC-UA nodes in subscribe mode,
  you can only stream data when the value of the node changes.
- **Per-node configuration**: Define the nodes you want to stream and configure
  them individually.
- **Broad customization**: Use Benthos' extensive configuration options to
  customize your data pipeline.
- **Easy deployment**: Deploy Benthos UMH as a standalone Docker container or
  directly from the Management Console.
- **Fully open source**: Benthos UMH is fully open source and available on
  [Github](https://github.com/united-manufacturing-hub/benthos-umh).

## How can I use it?

### With the Management Console

The easiest way to use Benthos UMH is to deploy it directly from the Management
Console

{{% notice warning %}}
Currently, only OPC-UA data sources can be configured from the Management
Console. To use other data sources, you must deploy Benthos UMH in standalone
mode or use [Node-RED](/docs/features/connectivity/node-red/).
{{% /notice %}}

You first have to add a new connection to your OPC-UA server from the
**Connection Management** tab.

![Add Connection](/images/features/data-connectivity-benthos/connection-management.png?width=80%)

Afterwards, you can initialize the connection by pressing the **Play** button
next to the connection. Select the correct authentication method and enter the
OPC-UA nodes you want to stream.

Currently, the only method supported for configuring OPC-UA nodes is by
specifying a YAML file. You can find an example file below:

``` yaml
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

Mandatory fields are `opcuaID`, `enterprise`, `tagName` and `schema`. `opcuaID`
is the NodeID in OPC-UA and can also be a folder (see [README](https://github.com/united-manufacturing-hub/benthos-umh?tab=readme-ov-file#node-ids)
for more information). The remaining components are components of the resulting
topic / ISA-95 structure (see also our [datamodel](/docs/datamodel)). By default,
the schema will always be in _historian, and tagName is the keyname.

### Standalone

You can manually deploy Benthos UMH as part of the UMH stack by using the
provided Docker image and following the instructions in the
[README](https://github.com/united-manufacturing-hub/benthos-umh?tab=readme-ov-file#with-the-united-manufacturing-hub-kubernetes--kafka).

This way, you have full control over the configuration of Benthos UMH and can
use any data source or sink supported by Benthos, along with the full range of
processors and other configuration options.

Read the official [Benthos documentation](https://www.benthos.dev/docs/components/about)
for more information on how to use different components.

## What are the limitations?

While Benthos is great at handling large amounts of data, it does not allow for
the same level of flow customization as Node-RED. If you need to perform complex
data transformations or integrate with other systems, you should consider using
Node-RED instead.

Additionally, the Management Console currently only supports deploying Benthos
UMH with OPC-UA data sources. If you want to use other data sources, you must
deploy Benthos UMH in standalone mode or use Node-RED.

## Where to get more information?

- Learn more about Benthos UMH in the [Github repository](https://github.com/united-manufacturing-hub/benthos-umh).
- Explore the [Data Model](/docs/datamodel).
- Confront these features with [Node-RED](/docs/features/connectivity/node-red/).
