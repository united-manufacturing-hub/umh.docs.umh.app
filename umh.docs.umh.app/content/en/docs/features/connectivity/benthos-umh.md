---
title: Benthos UMH
menuTitle: Benthos UMH
description: |
  Configure protocol converters to stream data to the Unified Namespace directly in the Management Console.
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

Benthos UMH is valuable for integrating different protocols with the Unified Namespace.
With it, you can configure various protocol converters, define the data you want to
stream, and send it to the Unified Namespace.

Furthermore, [in our tests](https://learn.umh.app/blog/our-open-source-docker-container-to-connect-opc-ua-with-the-unified-namespace/#testing-existing-solutions),
Benthos has proven more reliable than tools like Node-RED, when it comes to
handling large amounts of data.

## What can I do with it?

Benthos UMH offers some benefits, including:

- **Management Console integration**: Configure and deploy any number of protocol converters via
  Benthos UMH directly from the Management Console.
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
Console.

After adding your network device or service, you can initialize the protocol
converter. Simply click on the **Play** button next to the network device/service
at the **Protocol Converters** tab.
From there, you'll have two options to choose from when configuring the
protocol converter:

- **OPC-UA**: Select this option if you specifically need to configure
  OPC-UA protocol converters. It offers direct integration with OPC-UA servers
  and improved data contextualization. This is particularly useful when you need
  to assign tags to specific data points within the Unified Namespace. You'll be
  asked to define OPC-UA nodes in YAML format, detailing the nodes you want to stream
  from the OPC-UA server.

- **Universal Protocol Converter**: Opt for this choice if you need to configure
  protocol converters for various supported protocols other than OPC-UA. This option
  will prompt you to define the Benthos input and processor configuration in YAML format.

For OPC-UA, ensure your YAML configuration follows the format below:

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

Required fields are `opcuaID`, `enterprise`, `tagName` and `schema`. `opcuaID`
is the NodeID in OPC-UA and can also be a folder (see [README](https://github.com/united-manufacturing-hub/benthos-umh?tab=readme-ov-file#node-ids)
for more information). The remaining components are components of the resulting
topic / ISA-95 structure (see also our [datamodel](/docs/datamodel)). By default,
the schema will always be in \_historian, and tagName is the keyname.

### Standalone

Benthos UMH can be manually deployed as part of the UMH stack using the provided Docker
image and following the instructions outlined in the [README](https://github.com/united-manufacturing-hub/benthos-umh?tab=readme-ov-file#with-the-united-manufacturing-hub-kubernetes--kafka).

For more specialized use cases requiring precise configuration, standalone deployment
offers full control over the setup. However, this manual approach is more complex
compared to using the Universal Protocol Converter feature directly from the
Management Console.

Read the official [Benthos documentation](https://www.benthos.dev/docs/components/about)
for more information on how to use different components.

## What are the limitations?

Benthos UMH excels in scalability, making it a robust choice for complex setups
managing large amounts of data. However, its initial learning curve may be steeper
due to its scripting language and a more hands-on approach to configuration.

As an alternative, Node-RED offers ease of use with its low-code approach and the
popularity of JavaScript. It's particularly easy to start with, but as your setup grows,
it becomes harder to manage, leading to confusion and loss of oversight.

## Where to get more information?

- Learn more about Benthos UMH in the [Github repository](https://github.com/united-manufacturing-hub/benthos-umh).
- Explore the [Data Model](/docs/datamodel).
- Confront these features with [Node-RED](/docs/features/connectivity/node-red/).
