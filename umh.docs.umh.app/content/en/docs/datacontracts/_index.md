---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes how messages flow in the UMH, which message goes where, how it has to look like and how you can build your own structures."
weight: 1725
---

## What are Data Contracts

Data Contracts are formal agreements that define the structure, format, and rules for data exchanged between components within a Unified Namespace (UNS) architecture. They specify metadata, data models, and service levels to ensure that all systems interact consistently and reliably. By establishing clear guidelines for data sharing, Data Contracts facilitate seamless integration and prevent disruptions caused by changes in data formats or structures.

In short, they define where a messages goes, what structure it has to follow, how it gets there, what happens on its arrival, based on rules set by either us as defaults, or the user.

## Example Historian

To give you an easy example just think about the `_historian` schema you probably already have used.
The Historian Data Contract governs the data flow from your machines to the data base by enforcing rules and providing services.

- **Protocol Converter**: You have to use a protocol Converter to send your data from your machine to your UNS.
- **Topic sturcture**: You have to use the correct topic structure and include the `_historian` schema.
- **Message format**: The payload has to follow the correct message format, and inlcude a timestamp.
- **Bridges**: The Historian Data Contract features two bridges, that bridge your data from MQTT to Kafka and vice versa.
- **Kafka to Postgres**: If your message follows the set rules, Kafka will write it into the data base.

The rules make sure that the data can be processed by Kafka, is stored in the data base tables without causing errors and that the data can be read by other programs as they know what data to expect.
The bridges allow seamless data flow via MQTT without additional configuration.

## Why Data Contracts

This standardization enhances data integrity and reduces the risk of system failures when modifications are necessary.
Implementing Data Contracts also improves the scalability and maintainability of your architecture, allowing your organization to manage complex data interactions efficiently.

{{% notice note %}}
If this has sparked your interest, or you want to read more about reasons why we use this approach, we recommend reading the aricle about [Data Modeling in the UNS](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/) on our learn page.
<!-- Add link to Jeremys upcoming article, once it is released. -->
{{% /notice %}}

## Topic structure

As mentioned in the example, messages in the UMH have to follow a specific structure to be processed. The structure itself follows the diagram below.

{{<mermaid theme="neutral" >}}
flowchart LR
    umh --> v1
    v1 --> enterprise
    enterprise -->|Optional| site
    site -->|Optional| area
    area -->|Optional| productionLine
    productionLine -->|Optional| workCell
    workCell -->|Optional| originID
    originID -->|Optional| _schema["_schema (Ex: _historian, _analytics, _local)"]
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

The obligatory prefix of every topic is `umh.v1.`.
It ensures that the structure can evolve over time without causing confusion or compatibility issues.

### Location

In addition to the prefix, the `enterprise` field is also obligatory.
The ther location fields can be used as required by your situation.
When you create a protocol converter, it will use the location of the instance and connection to prefill these fields.

### Schemas

One of the most obvious parts of a Data Contract is the used schema.
It tells the UMH what to do with incoming messages, and what rules to apply to them.

Currently there is one schema used per default in the UMH: `_historian`.
<!-- Add Link to new Historian page -->
You can also use your own schemas for your messages, simply by using them in the topic.
These will show up in the Tag Brwoser, but not in the data base.

### Schema dependent

## Payload structure

## Protocol Converters

## Bridges

## Schema Validation

## SQL

## Summary Historian

## (Summary Analytics) // probably deactivated

## Summary Custom Data Contract
