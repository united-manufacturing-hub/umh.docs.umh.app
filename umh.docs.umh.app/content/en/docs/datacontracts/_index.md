---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes how messages flow in the UMH, which message goes where, how it has to be formatted and how you can create your own structures."
weight: 1725
aliases:
  - /docs/datamodel/
  - /docs/datamodel/messages/
  - /docs/datamodel/messages/_analytics/
  - /docs/datamodel/messages/_historian/
  - /docs/datamodel/database/
  - /docs/datamodel/database/historian/_analytics/
  - /docs/datamodel/database/historian/_historian/
  - /docs/datamodel/states/
  - /docs/datamodel/states/active/
  - /docs/datamodel/states/unknown/
  - /docs/datamodel/states/material/
  - /docs/datamodel/states/process/
  - /docs/datamodel/states/operator/
  - /docs/datamodel/states/planning/
  - /docs/datamodel/states/technical/
  - /docs/datamodel_old/
  - /docs/datamodel_old/messages/
  - /docs/datamodel_old/messages/activity/
  - /docs/datamodel_old/messages/addorder/
  - /docs/datamodel_old/messages/addparenttochild/
  - /docs/datamodel_old/messages/addproduct/
  - /docs/datamodel_old/messages/addshift/
  - /docs/datamodel_old/messages/count/
  - /docs/datamodel_old/messages/deleteshift/
  - /docs/datamodel_old/messages/detectedanomaly/
  - /docs/datamodel_old/messages/endorder/
  - /docs/datamodel_old/messages/modifyproducedpieces/
  - /docs/datamodel_old/messages/modifystate/
  - /docs/datamodel_old/messages/processvalue/
  - /docs/datamodel_old/messages/processvaluestring/
  - /docs/datamodel_old/messages/producttag/
  - /docs/datamodel_old/messages/producttagstring/
  - /docs/datamodel_old/messages/recommendation/
  - /docs/datamodel_old/messages/scrapcount/
  - /docs/datamodel_old/messages/scrapuniqueproduct/
  - /docs/datamodel_old/messages/startorder/
  - /docs/datamodel_old/messages/state/
  - /docs/datamodel_old/messages/uniqueproduct/
  - /docs/datamodel_old/database/
  - /docs/datamodel_old/database/assettable/
  - /docs/datamodel_old/database/configurationtable/
  - /docs/datamodel_old/database/counttable/
  - /docs/datamodel_old/database/ordertable/
  - /docs/datamodel_old/database/processvaluestringtable/
  - /docs/datamodel_old/database/processvaluetable/
  - /docs/datamodel_old/database/producttable/
  - /docs/datamodel_old/database/recommendationtable/
  - /docs/datamodel_old/database/shifttable/
  - /docs/datamodel_old/database/statetable/
  - /docs/datamodel_old/database/uniqueproducttable/
  - /docs/datamodel_old/states/
  - /docs/datamodel_old/states/active/
  - /docs/datamodel_old/states/unknown/
  - /docs/datamodel_old/states/material/
  - /docs/datamodel_old/states/process/
  - /docs/datamodel_old/states/operator/
  - /docs/datamodel_old/states/planning/
  - /docs/datamodel_old/states/technical/
---

## What are Data Contracts

Data Contracts are agreements that define how data is structured, formatted, and
managed when different parts of a Unified Namespace (UNS) architecture
communicate. They cover metadata, data models, and service levels to ensure that
all systems work together smoothly and reliably.

Simply put, data contracts specify where a message is going, the format it must
follow, how it's delivered, and what happens when it arrives - all based on
agreed-upon rules and services. It is similar to an API: you send a specific message, and
it triggers a predefined action. For example, sending data
to `_historian` automatically stores it in TimescaleDB,
just like how a REST API's POST endpoint would store data
in its database.

### Example Historian

To give you a simple example, just think about the `_historian` schema. Perhaps
without realizing it, you have already used the Historian Data Contract by using
this schema.

Whenever you send a message to a topic that contains the `_historian` schema via
MQTT, you know that it will be bridged to Kafka and end up in TimescaleDB.
You could also send it directly into Kafka, and you know that it gets
bridged to MQTT as well.

But you also know that you have to follow the correct payload and topic
structure that we as UMH have defined. If there are any issues like a missing
timestamp in the message, you know that you could look them up in the
Management Console.

These rules ensure that the data can be written into the intended database
tables without causing errors, and that the data can be read by other programs,
as it is known what data and structure to expect.

For example, the timestamp is an easy way to avoid errors by making each message
idempotent (can be safely processed multiple times without changing the result).
Each data point associated with a tag is made completely unique by its timestamp, which is
critical because messages are sent using "at least once" semantics, which can
lead to duplicates. With idempotency, duplicate messages are ignored, ensuring
that each message is only stored once in the database.

{{% notice note %}}
If you want a lot more information and really dive into the reasons for this
approach, we recommend our article about
[Data Modeling in the UNS](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/)
on our Learn page.
<!-- Add link to Jeremys upcoming article, once it is released. -->
{{% /notice %}}

## Rules of a Data Contract

Data Contracts can enforce a number of rules. This section provides an overview
of the two rules that are enforced by default. The specifics can vary between
Data Contracts; therefore, detailed information about the
[Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
and [Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts/)
is provided on their respective pages.

### Topic Structure

As mentioned in the example, messages in the UMH must follow our ISA-95
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
    originID -.-> _schema["_schema (Ex: _historian, _custom)"]
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

The schema, for example `_historian`, tells the UMH which data contract to
apply to the message. It is specified after the Location section and is
highlighted with an underscore to make it parsable for the UMH
and to clearly separate it from the location fields.

There is currently only one default schema in the UMH: `_historian`; for more
detailed information, see the
[Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
page.

To add your own custom schemas, you need to add a
[Custom Data Contract](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts).

#### Schema Dependent Content

Depending on the schema used, the next parts of the topic may differ. For
example, in the `_historian' schema, you can either attach your payload
directly or continue to group tags.

#### Allowed Characters

Topics can consist of any letters (`a-z`, `A-Z`), numbers (`0-9`), and the
symbols (`-` & `_`). Note that the `_` cannot be used as the first character in
the Location section.

Be careful to avoid `.`, `+`, `#`, or `/` as these are
special symbols in Kafka or MQTT.

Note that our topics **are case-sensitive**, so `umh.v1.ACMEIncorporated` is
**not** the same as `umh.v1.acmeincorporated`.

### Payload Structure

A Data Contract can include payload rules. For example, in the Historian Data
Contract, you must include a timestamp in milliseconds and a key-value pair.

These requirements are unique to each Data Contract.

## Components of a Data Contract

In addition to the rules, a Data Contract consists of individual components.
The specifics can vary between Data Contracts; therefore, detailed information
about the [Historian Data Contract](https://umh.docs.umh.app/docs/datacontracts/historian/)
and [Custom Data Contracts](https://umh.docs.umh.app/docs/datacontracts/customdatacontracts/)
is provided on their respective pages.

### Data Flow Components

As the name implies, a Data Flow Component manages the movement and
transformation of data within the Unified Namespace architecture.
Data Flow Components can be of three different types: Protocol Converter, Data
Bridge, or Custom Data Flow Component. All are based on
[BenthosUMH](https://github.com/united-manufacturing-hub/benthos-umh).

#### Protocol Converter

You have probably already created a Protocol Converter and are familiar with
its purpose: get data from different sources into your instances. You format
the data into the correct payload structure and send it to the correct topics.
When you add a Protocol Converter, the Management Console uses the configuration
of the underlying Connection and instance to automatically generate most of the
configuration for the Protocol Converter.

#### Data Bridges

Data Bridges are placed between two components of the Unified Namespace, such as
Kafka and MQTT, and allow messages to be passed between them. The default Data
Bridges are the two between MQTT and Kafka for the `_historian` schema, and the
bridge between Kafka and the database. Each Data Bridge is unidirectional and
specific to one schema.

#### Custom Data Flow Components

To meet everyone's needs and enable stream processing, you can add Custom Data
Flow Components (creative naming is our passion). Unlike Protocol Converters or
Data Bridges, you have full control over their configuration, which makes them
incredibly versatile, but also complicated to set up. Therefore, they must be
manually enabled by switching to Advanced Mode in the Management Console Settings.

### Other Data Contracts

Data Contracts can build on existing contracts. For example, if you use a Custom
Data Contract to automatically calculate KPIs, you can send the raw data to
`_historian`, process it with a Custom Data Flow Component, and publish it to a
new schema. The new Data Contract uses the Historian to collect data from the
machines and store it in the database.
