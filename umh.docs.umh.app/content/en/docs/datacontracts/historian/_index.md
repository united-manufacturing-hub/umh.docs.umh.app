---
title: "Historian Data Contract"
menuTitle: "Historian Data Contract"
description: "This page is a deepdive of the Historian Data Contract of the UMH including the configuration and rules associated to it."
weight: 1000
---

This section will focus on the specific details and configurations of the Historian Data Contract.
If you are not yet familiar with Data Contracts, you should first read the [Data Contracts / API](https://umh.docs.umh.app/docs/datacontracts/) page.

## Historian

The purpose of the Historian Data Contract is to govern the data flow from the Protocol Converter to the data base.
It enforces rules for the structure of the payloads and topics, and provides the necessary infrastructure to bridge data in the Unifies Namespace and to write it into the data base.

This makes sure, that data is only stored in a format accepted by the data base, and makes integrating services like Grafana easier as the data structure is already known.

It also ensures that each message is idempotent (can be safely processed multiple times without changing the result), by making each message in a tag completely unique by its timestamp.
This is critical because messages are sent using "at least once" semantics, which can lead to duplicates.
With idempotency, duplicate messages are ignored, ensuring that each message is only stored once in the database.

## Topics in the Historian

{{<mermaid theme="neutral" >}}
flowchart LR
    umh --> v1
    v1 --> enterprise
    enterprise -->|Optional| site
    site -->|Optional| area
    area -->|Optional| productionLine
    productionLine -->|Optional| workCell
    workCell -->|Optional| originID
    originID -.-> _historian
    _historian -->_tagGroups

    classDef mqtt fill:#00dd00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_historian mqtt;
    classDef optional fill:#77aa77,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID optional;
    
    enterprise -.-> _historian
    site -.-> _historian
    area -.-> _historian
    productionLine -.-> _historian
    workCell -.-> _historian

{{</ mermaid >}}

The prefix and Location of the topic in the Historian Data Contract follows the same rules as alreads described on the general [Data Contracts](https://umh.docs.umh.app/docs/datacontracts/#topic-structure) page.

### Prefix

The first section is the mandatory prefix: `umh.v1.` It ensures that the
structure can evolve over time without causing confusion or compatibility
problems.

### Location

The next section is the Location, which consists of six parts:
`enterprise.site.area.productionLine.workCell.originID`.

You may be familiar with this structure as it is used by your instances and
connections. Here the `enterprise` field is mandatory.

{{% notice note %}}
When you create a Protocol Converter, it uses the Location of the instance and
the connection to prefill the topic, but you can add the unused ones or change
the prefilled parts.
{{% /notice %}}

### Schema: _historian

The only schema in the Historian Data Contract is `_historian`.
Without it, your messages will not be processed.

### Tag groups

In addition to the Location, you can also use tag groups.
A tag group is just an additional part after the schema:

`umh.v1.location._historian.tag-group.tagname`

You can add as many tag groups as you wish:

`umh.v1.location._historian.tag-group1.tag-group2.tagname`

In the tag browser a tag group will look like any field of the Location, exept it is located after the schema.

#### Example

Tag groups can be usefull to further add context to your tags or to keep an overview of them in the tag browser.
For example you can use them to categorize the sensors of a CNC mill.

- One group for the positions of the x,y,z axis:

`umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.axis.tagname`

- A second group for the machine state:

`umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.machine-state.tagname`

## Payload structure

The Historian Data Contracts requires your messages to be a JSON file with a specific structure and inclue a timestamp.
For a simple message wiht one tag it looks like this:

```yaml
{
  "timestamp_ms": 1732280023697,
  "tagname": 42
}
```

The timestamp must be called `"timestamp_ms"` and contain the timestamp in milliseconds.
The value can be either a number `"key": 123` or a string `"key": "string"`.
The `"tagname"` is the name of the tag and will be used in the tag browser or for Grafana.

It is also possible to include several tags in a single payload.

```yaml
{
  "timestamp_ms": 1732280023697,
  "tagname1": 123,
  "tagname2": "string",
  "tagname3": "string"
}
```

If you want to use taggroups, you can also do this in the payload.

```yaml
{
  "timestamp_ms": 1732280023697,
  "taggroup": 
  {
    "tagname1": 123,
    "tagname2": "string"
  }
}
```

Both tags will appear in the `[...]._historian.taggroup` topic.

You can check out the full json schema below:

## Data Flow Components

The Historian Data Contract enables data acquisition and processing by
automatically deploying three Data Bridges and using Protocol Converters.

### Data Bridges

There are three Data Bridges in the Historian Data Contract, which are created and configured automatically when the instance is created.
The first one bridges messages from Kafka to MQTT, the second one from MQTT to Kafka.
The third Data Bridge bridges messages from Kafka to the database, TimescaleDB.
The Data Briges are responsible for validating the topic and payload, and add error logs in case a message is not valid.
Their configurations can not be edited in the Management Console.

### Protocol Converters

The easiest way to get data into your UNS is a Protocol Converter.
If you want to learn how to do this, you can follow our [Get Started guide](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/).
The configuration of a Protocol Converter Consists of three sections:

- **Input:** Here, you specify the address, used protocol, authentication and the "location" of the data on the connected device. This could be the NodeID on an OPC UA PLC.
- **Processing:** In this section you manipulate the data, build the payload with the timestamp and specify the topic.
- **Output:** The output is completely autogenerated and can not be changed.
  The data is always send to the Kafka broker of the instance.

Informaion specific to the selected Protocol and section can be fund by clicking on the vertical **PROTOCOL CONVERTER** button on the right edge of the window.

#### Verified Protocols

Our Protocol Converters are compatible with a long list of protocols.
The most important are considered verified by us, look for the checkmark next to the name of the protocol when selecting the protocol in the Edit Protocol Converter page in the Management Console.

When you are using one of the verfied protocols a lot of the fields are autofilled based upon the underlying Connection and instance.
The input section will use the address of the connection and add pre- and sufixes if necessary.
If you are using OPC UA the username and password are autofilled.
The preconfigured processing section will use the Location of the instance and the connection to build the topic and use the name of the original tag as the tagname.
It will also automatically generate a payload with a timestamp and the value of the incoming message.
If the preconfiguration does not meet your requirements, you can change them.

## Data Base

## Tables

### SQL

## Schema validation ??
