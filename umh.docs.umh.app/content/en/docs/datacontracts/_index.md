---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes how messages flow in the UMH, which message goes where, how it has to look like and how you can build your own structures."
weight: 1725
---

## What are Data Contracts

Data Contracts are formal agreements that define the structure, format, and rules for data exchanged between components within a Unified Namespace (UNS) architecture. They specify metadata, data models, and service levels to ensure that all systems interact consistently and reliably. By establishing clear guidelines for data sharing, Data Contracts facilitate seamless integration and prevent disruptions caused by changes in data formats or structures.

In short, they define where a messages goes, what structure it has to follow, how it gets there, what happens on its arrival, based on rules set by either us as defaults, or the user.

### Example Historian

To give you an easy example just think about the `_historian` schema you probably already have used.
The Historian Data Contract governs the data flow from your machines to the data base by enforcing rules and providing services:

- **Protocol Converter**: You have to use a protocol Converter to send your data from your machine to your UNS.
- **Topic sturcture**: You have to use the correct topic structure and include the `_historian` schema.
- **Message format**: The payload has to follow the correct message format, and inlcude a timestamp.
- **Bridges**: The Historian Data Contract features two bridges, that bridge your data from MQTT to Kafka and vice versa.
- **Kafka to Postgres**: If your message follows the set rules, Kafka will write it into the data base.

The rules make sure that the data can be processed by Kafka, is stored in the data base tables without causing errors and that the data can be read by other programs as they know what data to expect.
The bridges allow seamless data flow via MQTT without additional configuration.

{{% notice note %}}
If this has sparked your interest, or you want to read more about reasons why we use this approach, we recommend reading the aricle about [Data Modeling in the UNS](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/) on our learn page.
<!-- Add link to Jeremys upcoming article, once it is released. -->
{{% /notice %}}

## Components of a Data Contract

In this section will provide a brief overview of the most relevant components of a Data Contract.
For specific details check out the pages about the [Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/) and how to create your own [Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts).

### Topic structure

As mentioned in the example, messages in the UMH have to follow a specific ISA95 compliant structure to be processed.
The structure itself can be divided in several sections.

{{<mermaid theme="neutral" >}}
flowchart LR
    umh --> v1
    v1 --> enterprise
    enterprise -->|Optional| site
    site -->|Optional| area
    area -->|Optional| productionLine
    productionLine -->|Optional| workCell
    workCell -->|Optional| originID
    originID -->|Optional| _schema["_schema (Ex: _historian, _custom)"]
    _schema -->_opt["Schema dependent context"]

    classDef mqtt fill:#00dd00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_schema mqtt;
    classDef optional fill:#77aa77,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID optional;
    
    enterprise -.-> _schema
    site -.-> _schema
    area -.-> _schema
    productionLine -.-> _schema
    workCell -.-> _schema

    click _schema href "#_schema"
    click umh href "#versioning-prefix"
    click v1 href "#versioning-prefix"
{{</ mermaid >}}

You can check if your topics are correct in the validator below.

{{% topic_decoder %}}

#### Prefix

The first section is the obligatory prefix: `umh.v1.`.
It ensures that the structure can evolve over time without causing confusion or compatibility issues.

#### Location

The next section is the Location, which consists of six parts.
You might be familiar with this structure as it is used by your instances and connections.
Here, the `enterprise` field is obligatory.

{{% notice note %}}
When you create a protocol converter, it will use the location of the instance and connection to prefill the topic, but you can add the unsued ones or change prefilled parts.
{{% /notice %}}

#### Schemas

After the Location section you have to specify a schema.
In general tells the UMH what to do with incoming messages, and what rules to apply to them, so what Data Contract is used for the message.
Due to its high importance the schema is highlighted with an underscore.

Currently there is one default schema in the UMH: `_historian`, for more in depth information check out the [Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/) page.

To add your own custom schemas you have to add a Data Contract.
To learn how to add your own check out the page about [Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts).

#### Schema dependent content

Depending on the used schema the next parts of the topic can differ.
For example in the `_historian` schema your can either directly attach your payload or continue to group tags. More details can be found in the Historian Data Contract page.

#### Allowd Characters

Topics can consist of any letters (`a-z`, `A-Z`), numbers (`0-9`) and therein symbols (`-` & `_`).
Be careful to avoid `.`, `+`, `#` or `/` as these are special symbols in Kafka or MQTT.

Be aware that our topics are case-sensitive, therefore `umh.v1.ACMEIncorperated` is **not** the same as `umh.v1.acmeincorperated`.

### Payload structure

A Data Contract can include setting rules for the payload.
For example in the Historian Data Contract you have to include a timestamp in milliseconds and a key value pair.

This is individual for each Data Contract.

### Data Flow Components

Data Flow Components can be of three different types, which are based on [BenthosUMH](https://github.com/united-manufacturing-hub/benthos-umh).

#### Protocol Converter

The Data Flow Component you are probably already familiar with is used to get data from various sources to your instances.
They format data into the correct payload structure and send them to the correct topics.

#### Bridges

Bridges are interposed between the two message brokers in the Unified Namespace, Kafka and MQTT.
They function as the connection between both, allowing you to send messages to the MQTT broker and find them in Kafka as well, or to access data in Kafka from MQTT.
The default Bridges are the two between MQTT and Kafka.
Setting up a Custom Data Contract always includes addting two new Brdiges.

#### Custom Data Flow Components

To suit everybodys needs and allow stream processing of messages you can add Data Flow Components.
In contrast to Protocol Converters or Bridges, you have full controll over the configuration.
Thus they have to be manually enabled by switching to Advanced Mode in the Management Console Settings.

## Summary Historian

As elaborated above, the Historian Data Contract is the only default Data Contract in the UMH.
Its purpose is to make sure data meant to be stored in the data base follow the correct format.

## (Summary Analytics) // probably deactivated

## Summary Custom Data Contract
