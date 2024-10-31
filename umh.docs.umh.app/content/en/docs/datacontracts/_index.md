---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes how messages flow in the UMH, which message goes where, how it has to be formatted and how you can create your own structures."
weight: 1725
---

## What are Data Contracts

Data Contracts are formal agreements that define the structure, format, and
rules for data exchanged between components within a Unified Namespace (UNS)
architecture. They specify metadata, data models, and service levels to ensure
that all systems interact consistently and reliably. By establishing clear
guidelines for data exchange, Data Contracts facilitate seamless integration
and prevent disruptions caused by changes in data formats or structures.

In short, they define where a message is going, what structure it must follow,
how it gets there, and what happens when it arrives, based on defined rules and
services.

### Example Historian

To give you a simple example, just think about the `_historian' schema. Perhaps
without realizing it, you have already used the Historian Data Contract by using
this schema. The Historian Data Contract governs the flow of data from your
machines to the database by enforcing rules and providing services:

- **Protocol Converter**: You must use a protocol converter to send your data
from your machine to your UNS.
- **Topic structure**: You must use the correct topic structure and include the
`_historian` schema.
- **Message format**: The payload must be JSON and follow the correct message
format, such as including a timestamp.
- **Data Bridges**: The Historian Data Contract includes two Data Bridges that
move your data from MQTT to Kafka and vice versa.
- **Kafka to Postgres**: This is a special microservice of UMH that allows
Kafka to write data to the database.

These rules ensure that the data can be written to the database without causing
errors, and that the data can be read by other programs that know what data to
expect. The Data Bridges enable seamless data flow via MQTT without any
additional configuration.

{{% notice note %}}
If you want a lot more information and really dive into the reasons for this
approach, we recommend our article about
[Data Modeling in the UNS](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/)
on our Learn page.
<!-- Add link to Jeremys upcoming article, once it is released. -->
{{% /notice %}}

## Components of a Data Contract

Data Contracts have several components and rules. This section provides a
high-level overview of these key elements. The specifics can vary greatly
between Data Contracts; therefore, detailed information about the
[Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
and [Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts/)
is provided on their respective pages.

### Topic structure

As mentioned in the example, messages in the UMH must follow a specific ISA-95
compliant structure in order to be processed. The structure itself can be
divided into several sections.

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

The first section is the mandatory prefix: `umh.v1.` It ensures that the
structure can evolve over time without causing confusion or compatibility
problems.

#### Location

The next section is the Location, which consists of six parts:
`enterprise.site.area.productionLine.workCell.originID`.

You may be familiar with this structure as it is used by your instances and
connections. Here the `enterprise` field is mandatory.

{{% notice note %}}
When you create a Protocol Converter, it uses the Location of the instance and
the connection to prefill the topic, but you can add the unused ones or change
the prefilled parts.
{{% /notice %}}

#### Schemas

After the Location section, you need to specify a schema. In general, the
schema tells the UMH what to do with incoming messages, what rules to apply to
them, or can be used for Data Flow Components to process these messages instead
of others. In short, it specifies the data contract to be used.

Due to its importance, the schema is highlighted with an underscore.

There is currently one default schema in the UMH: `_historian`; for more
detailed information, see the
[Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
page.

To add your own custom schemas, you need to add a
[Custom Data Contract](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts).

#### Schema dependent content

Depending on the schema used, the next parts of the topic may differ. For
example, in the `_historian' schema, you can either attach your payload
directly or continue to group tags. See the Historian Data Contract page
for more details.

#### Allowed Characters

Topics can consist of any letters (`a-z`, `A-Z`), numbers (`0-9`), and the
symbols (`-` & `_`). Be careful to avoid `.`, `+`, `#`, or `/` as these are
special symbols in Kafka or MQTT.

Note that our topics are case-sensitive, so `umh.v1.ACMEIncorporated` is
**not** the same as `umh.v1.acmeincorporated`.

### Payload structure

A Data Contract can include payload rules. For example, in the Historian Data
Contract, you must include a timestamp in milliseconds and a key-value pair.

These requirements are unique to each data contract.

### Data Flow Components

Data Flow Components can be of three different types: Protocol Converter, Data
Bridge, or Custom Data Flow Component. All are based on
[BenthosUMH](https://github.com/united-manufacturing-hub/benthos-umh).

#### Protocol Converter

You have probably already created a Protocol Converter and are familiar with
its purpose. You use them to get data from different sources into your
instances. You format the data into the correct payload structure and send it
to the correct topics.

#### Data Bridges

Data Bridges are placed between the two message brokers in the Unified
Namespace, Kafka and MQTT, and allow messages to be passed between them.
The default Data Bridges are the two between MQTT and Kafka for the `_historian'
schema. Each Data Bridge is unidirectional and specific to one schema.

#### Custom Data Flow Components

To meet everyone's needs and enable stream processing, you can add Custom Data
Flow Components (creative naming is our passion). Unlike Protocol Converters or
ata Bridges, you have full control over their configuration, which makes them
incredibly versatile, but also complicated to set up. As a result, they must be
manually enabled by switching to Advanced Mode in the Management Console Settings.

### Other Data Contracts

Data Contracts can build on existing contracts. For example, if you want to
calculate KPIs, you can send the raw data to `_historian`, process it with a
Custom Data Flow Component, and publish it to a new schema. The new Data
Contract uses the Historian to collect data from the machines and store it in
the database.

## Summary Historian

As explained above, the Historian Data Contract is the only standard Data
Contract in the UMH. Its purpose is to ensure that the data to be stored in the
database follows the correct format. For all information about the specifics of
this Data Contract, see the
[Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
page.

## Summary Custom Data Contract

Since we can never fully address every use case of the UMH, you can also create
custom use cases to meet your specific needs. You can set up your own Data
Bridges, add custom schemas, and configure Data Flow Components specific to
your use case. For example, if you want to automatically calculate KPIs based
on data from your production and other services, this is the way to go. Since
there is a lot to cover, this has its own
[Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts)
page.
