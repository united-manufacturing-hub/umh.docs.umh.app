---
title: "Custom Data Contracts"
menuTitle: "Custom Data Contracts"
description: "In addition to the standard data contracts provided, you can add your own."
weight: 2000
draft: true
wip: true
---

This section focuses on Custom Data Contracts.
If you are not familiar with Data Contracts, you should first read the
[Data Contracts / API]({{< ref "/docs/datacontracts" >}}).
We are currently working on a blog post that will explain the concept of Custom Data Contracts in more detail.

## Why Custom Data Contracts

The only Data Contract that exists per default in the UMH is the Historian Data Contract.
Custom Data Contracts let you add additional functionalities to your UMH, like automatically calculate KPIs or further processing of data.

## Example of a custom Data Contract

One example for a Custom Data Contract is the automated interaction of MES and PLCs.
Every time a machine stops, the latest order ID from the MES needs to be automatically written into the PLC.

We begin by utilizing the existing `_historian` data contract to continuously send and store the latest order ID from the MES in the UNS.

Additionally, a custom schema (for example, `_action`) is required to handle action requests and responses, enabling commands like writing data to the PLC.
The next step is to implement Protocol Converters to facilitate communication between systems.
For ingoing messages, a Protocol Converter fetches the latest order ID from the MES and publishes it to the UNS using the `_historian` data contract.

For outgoing messages, another Protocol Converter listens for action requests in the manually added `_action` data contract and executes them by getting the last order ID from the UNS and writing the order ID to the PLC.

Protocol Converters can be seen as an interface between the UMH and external systems.

Finally, we have to set up a **Custom Data Flow Component** as a stream processor that monitors the UNS for specific conditions, such as a machine stoppage. When such a condition is detected, it generates an action request in the `_action` data contract for the output protocol converter to process.

Additionally, we have to add Data Bridges for the `_action` schema.
In these you enforce a specific topic and payload structure.

The combination of the Historian Data Contract, the additional `_action` schema, custom Data Bridges, the two Protocol Converters and the stream processor and enforcement of payload and topic structure from this new Data Contract.

## Topic Structure in Custom Data Contracts

The topic structure follows the same rules as specified in the [Data Contracts / API]({{< ref "/docs/datacontracts#topic-structure" >}}) page, until the schema-dependent content.

The schema-dependent content depends on your configuration of the deployed custom Data Bridges.

### Add custom schema

More information about custom schemas will be added here when the feature is ready to use.

<!-- To add a custom schema, you simply have to use it in a topic.
If it is directly send to Kafka, for example with a Protocol Converter, it will appear in the tag browser.
If you want to send it via MQTT, you have to add a Bridge first, as only the `_historian` schema is bridged automatically.
How you can add custom Data Bridges is explained in detail below. -->


<!-- ## Payload Structure

## Data Flow Components

### Data Bridges

#### Add custom Brdiges

### Protocol Converters

#### Custom Protocol Converters

For example the Outgoing PC from the example above

#### Verified Protocols

### Custom Data Flow Components -->
