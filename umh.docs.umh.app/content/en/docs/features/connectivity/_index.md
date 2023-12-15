---
title: Connectivity
menuTitle: Connectivity
description: |
  Introduction to IIoT Connections and Data Sources Management in the
  United Manufacturing Hub.
weight: 1000
edition: community
no_list: true
---

In IIoT infrastructures, sometimes can be challenging to extract and contextualize
data from from various systems into the Unified Namespace, because there is no
universal solution. It usually requires lots of different tools, each one
tailored to the specific infrastructure, making it hard to manage and maintain.

With the United Manufacturing Hub and the Management Console, we aim to solve
this problem by providing a simple and easy to use tool to manage all the assets
in your factory.

{{% notice note %}}
For lack of a better term, when talking about a system that can be connected to
and that provides data, we will use the term **asset**.
{{% /notice %}}

## When should I use it?

Contextualizing data can present a variety of challenges, both technical and
at the organization level. The Connection Management functionality aims to reduce
the complexity that comes with these challenges.

Here are some common issues that can be solved with the Connection Management:

- It is hard to get an overview of all the data sources and their connections'
  status, as the concepts of "connection" and "data source" are often decoupled.
  This leads to list the connections' information into long spreadsheets, which
  are hard to maintain and troubleshoot.
- Handling uncommon communication protocols.
- Dealing with non-standard connections, like a 4-20 mA sensor or a USB-connected
  barcode reader.
- Advanced IT tools like [Apache Spark](https://spark.apache.org/) or
  [Apache Flink](https://flink.apache.org/) may be challenging for OT personnel
  who have crucial domain knowledge.
- Traditional OT tools often struggle in modern IT environments, lacking features
  like Docker compatibility, monitoring, automated backups, or high availability.

## What can I do with it?

![Connection Management](/images/features/connectivity/management-console-connection-management.png?width=80%)

The Connection Management functionality in the Management Console aims to
address those challenges by providing a simple and easy to use tool to manage
all the assets in your factory.

You can add, delete, and most importantly, visualize the status of all your
connections in a single place. For example, a periodic check is performed to
measure the latency of each connection, and the status of the connection is
displayed in the Management Console.

You can also add notes to each connection, so that you can keep all the documentation
in a single place.

![Connection Notes](/images/features/connectivity/management-console-connection-management-notes.png?)

You can then configure a data source for each connection, to start extracting
data from your assets. Once the data source is configured, specific information
about its status is displayed, prompting you in case of misconfigurations, data
not being received, or other any error that may occur.

## How can I use it?

Add new connections from the Connection Management page of the Management Console.
Then, configure a data source for each of them by choosing one of the available
tools, depending on the type of connection.

The following tools come with the United Manufacturing Hub and are recommended
for extracting data from your assets:

### Node-RED

[Node-RED](https://nodered.org/) is a leading open-source tool for IIoT
connectivity. We recommend this tool for prototyping and integrating parts of the
shop floor that demand high levels of customization and domain knowledge.

Even though it may be unreliable in high-throughput scenarios, it has a vast
global community that provides a wide range of connectors for different protocols
and data sources, while remaining very user-friendly with its visual programming
approach.

### Benthos UMH

<!-- TODO: write a page in the Architecture section about Benthos, and consider also a reference page -->

Benthos UMH is a custom extension of the [Benthos](https://www.benthos.dev/)
project. It allows you to connect assets that communicate via the OPC UA protocol,
and it is recommended for scenarios involving the extraction of large data volumes
in a standardized format.

It is a lightweight, open-source tool that is easy to deploy and manage. It is
ideal for moving medium-sized data volumes more reliably then Node-RED, but it
requires some technical knowledge.

### Other Tools

The United Manufacturing Hub also provides tools for connecting data sources
that uses other types of connections. For example, you can easily connect
[ifm IO-Link](/docs/features/connectivity/additionalconnectivity/ifm-retrofitting/)
sensors or [USB barcode readers](/docs/features/connectivity/additionalconnectivity/barcodereader-retrofitting/).

### Third-Party Tools

Virtually any existing connectivity solution can be integrated with the United
Manufacturing Hub. However, we recommend using the tools mentioned above, as
they are the most tested and reliable.

## What are the limitations?

Some of the tools still require some technical knowledge to be used. We are
working on improving the user experience and documentation to make them more
accessible.

## Where to get more information?

- Follow the [Get started guide](/docs/getstarted/) to learn how to connect
  your assets to the United Manufacturing Hub.
- Deep dive into the [Node-RED features](/docs/features/connectivity/node-red/).
- Explore [retrofitting with ifm IO-Link master and sensorconnect](/docs/features/connectivity/other-tools/ifm-retrofitting/).
- Learn how to [retrofit with USB barcodereader](/docs/features/connectivity/other-tools/barcodereader-retrofitting/).
