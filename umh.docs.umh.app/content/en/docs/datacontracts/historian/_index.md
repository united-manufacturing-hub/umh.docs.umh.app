---
title: "Historian Data Contract"
menuTitle: "Historian Data Contract"
description: "This page is a deepdive of the Historian Data Contract of the UMH including the configuration and rules associated to it."
weight: 1000
---

This section focuses on the specific details and configurations of the
Historian Data Contract. If you are not familiar with data contracts, you
should first read the
[Data Contracts / API](https://umh.docs.umh.app/docs/datacontracts/) page.

## Historian

The purpose of the Historian Data Contract is to govern the flow of data from
the Protocol Converter to the database.
It enforces rules for the structure of payloads and topics, and provides the
necessary infrastructure to bridge data in the Unified Namespace and write it
to the database.

This ensures that data is only stored in a format accepted by the database,
and makes it easier to integrate services like Grafana because the data
structure is already known.

It also ensures that each message is idempotent (can be safely processed
multiple times without changing the result), by making each message within a
tag completely unique by its timestamp.
This is critical because messages are sent using "at least once" semantics,
which can lead to duplicates.
With idempotency, duplicate messages are ignored, ensuring that each message
is only stored once in the database.

## Topic Structure in the Historian Data Contract

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

The prefix and Location of the topic in the Historian Data Contract follows
the same rules as already described on the general
[Data Contracts](https://umh.docs.umh.app/docs/datacontracts/#topic-structure)
page.

### Prefix

The first section is the mandatory prefix: `umh.v1.`.
It ensures that the structure can evolve over time without causing confusion or
compatibility problems.

### Location

The next section is the Location, which consists of six parts:
`enterprise.site.area.productionLine.workCell.originID`.
You may be familiar with this structure as it is used by your instances and
connections. Here, the `enterprise` field is mandatory.

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

You can add as many tag groups as you like:

`umh.v1.location._historian.tag-group1.tag-group2.tagname`

In the tag browser, a tag group will look like any field in the Location, except
that it is located after the schema.

#### Example

Tag groups can be useful for adding context to your tags or for keeping track
of them in the tag browser. For example, you might use them to categorize the
sensors on a CNC mill.

- A group for the x, y, z axis positions:

  `umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.axis.tagname`

- A second group for the machine state:

   `umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.machine-state.tagname`

## Payload structure

The Historian Data Contract requires that your messages be a JSON file with a
specific structure and include a timestamp and at least one tag with a value,
both as a key-value pair. The most basic message looks like this

```json
{
  "timestamp_ms": 1732280023697,
  "tagname": 42
}
```

The timestamp must be called `"timestamp_ms"` and contain the timestamp in
milliseconds. The value of the tag can be either a number `"tagname": 123` or a
string `"tagname": "string"`. The `"tagname"` is used in the tag browser or for
Grafana.

It is also possible to include multiple tags in a single payload.

```json
{
  "timestamp_ms": 1732280023697,
  "tagname1": 123,
  "tagname2": "string",
  "tagname3": "string"
}
```

If you want to use tag groups, you can also do this in the payload.

```json
{
  "timestamp_ms": 1732280023697,
  "taggroup": 
  {
    "tagname1": 123,
    "tagname2": "string"
  }
}
```

Both, `tagname1` and `tagname2`, will appear in the `[...]._historian.taggroup` topic.

You can see the full JSON schema below:

{{< spoiler "Show JSON Schema" "Hide JSON Schema" >}}
The messages in our data model must be JSON using the following format:

```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "timestamp_ms": {
      "type": "integer"
    }
  },
  "required": ["timestamp_ms"],
  "additionalProperties": {
    "oneOf": [
      { "type": "string" },
      { "type": "number" },
      { "type": "boolean" }
    ]
  },
  "minProperties": 2
}
```

{{< /spoiler >}}

## Data Flow Components

The Historian Data Contract enables data acquisition and processing through the
use of Protocol Converters and the automatic deployment of three Data Bridges.

### Data Bridges

There are three Data Bridges in the Historian Data Contract, which are
automatically created and configured when the instance is created.
The first bridges messages from Kafka to MQTT, the second from MQTT to Kafka.
The third Data Bridge bridges messages from Kafka to the TimescaleDB database.
The Data Bridges are responsible for validating the topic and payload, and
adding error logs in case a message is not valid.
Their configurations are not editable in the Management Console.

### Protocol Converters

The easiest way to get data into your UNS is to use a Protocol Converter.
If you want to learn how to do this, you can follow our [Get Started guide](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/).
The configuration of a Protocol Converter consists of three sections:

- **Input:** Here you specify the address, protocol used, authentication, and
  the "location" of the data on the connected device. This could be the NodeID on
  an OPC UA PLC.
- **Processing:** In this section, you manipulate the data, build the
  timestamped payload, and specify the topic.
- **Output:** The output is completely auto-generated and cannot be modified.
  The data is always sent to the instance's Kafka broker.

Information specific to the selected protocol and section can be found by clicking on the vertical **PROTOCOL CONVERTER** button on the right edge of the window.

#### Verified Protocols

Our Protocol Converters are compatible with a long list of protocols.
The most important ones are considered verified by us; look for the check mark
next to the protocol name when selecting the protocol on the Edit Protocol
Converter page in the Management Console.

If you are using one of the verified protocols, many of the fields will be
populated automatically based on the underlying connection and instance.
The input section uses the address of the connection and adds prefixes and
suffixes as necessary. If you are using OPC UA, the username and password are
autofilled. The preconfigured processing section will use the location of the
instance and the connection to build the topic and use the name of the original
tag as the tag name. It will also automatically generate a payload with a
timestamp and the value of the incoming message.
If the preconfiguration does not meet your needs, you can change it.

## Database

We use TimescaleDB as the database in the UMH. By default, only tags from the
Historian Data Contract are written to the database.

Our database for the Historian Data Contract consists of three tables. We chose
this layout to allow easy lookups based on the asset, while maintaining
separation between data and names. The separation into `tag` and `tag_string`
prevents accidental lookups of the wrong data type, which could break queries
such as aggregations or averages.

{{< mermaid theme="neutral" >}}
erDiagram
    asset {
        int id PK "SERIAL PRIMARY KEY"
        text enterprise "NOT NULL"
        text site "DEFAULT '' NOT NULL"
        text area "DEFAULT '' NOT NULL"
        text line "DEFAULT '' NOT NULL"
        text workcell "DEFAULT '' NOT NULL"
        text origin_id "DEFAULT '' NOT NULL"
    }

    tag {
        timestamptz timestamp "NOT NULL"
        text name "NOT NULL"
        text origin "NOT NULL"
        int asset_id FK "REFERENCES asset(id) NOT NULL"
        real value
    }

    tag_string {
        timestamptz timestamp "NOT NULL"
        text name "NOT NULL"
        text origin "NOT NULL"
        int asset_id FK "REFERENCES asset(id) NOT NULL"
        text value
    }

    asset ||--o{ tag : "id"
    asset ||--o{ tag_string : "id"

{{</ mermaid >}}

### asset

An asset to us is the unique combination of the parts of the Location:
`enterprise`, `site`, `area`, `line`, `workcell`, and `origin_id`. Each asset
has an `id` that is automatically assigned.

All keys except `id` and `enterprise` are optional.
The example below shows how the table might look.
A new asset is added to the bottom of the table.

| id | enterprise         | site     | area       | line        | workcell | origin_id     |
|----|--------------------|----------|------------|-------------|----------|---------------|
| 1  | acme-corporation   |          |            |             |          |               |
| 2  | acme-corporation   | new-york |            |             |          |               |
| 3  | acme-corporation   | london   | north      | assembly    |          |               |
| 4  | stark-industries   | berlin   | south      | fabrication | cell-a1  | 3002          |
| 5  | stark-industries   | tokyo    | east       | testing     | cell-b3  | 3005          |
| 6  | stark-industries   | paris    | west       | packaging   | cell-c2  | 3009          |
| 7  | umh                | cologne  | office     | dev         | server1  | sensor0       |
| 8  | cuttingincorporated | cologne  | cnc-cutter |             |          |               |

### tag

This table is a Timescale [hypertable](https://docs.timescale.com/use-timescale/latest/hypertables/about-hypertables/).
These tables are optimized to hold a large amount of data roughly sorted by time.

For example, we send data to `umh/v1/cuttingincorporated/cologne/cnc-cutter/_historian/head` using the following JSON:

```json
{
 "timestamp_ms": 1670001234567,
  "pos":{ 
    "x": 12.5,
    "y": 7.3,
    "z": 3.2
  },  
  "temperature": 50.0,
  "collision": false
}
```

This results in the following table entries:

| timestamp     | name             | origin  | asset_id | value |
|---------------|------------------|---------|----------|-------|
| 1670001234567 | head$pos$x       | unknown | 8        | 12.5  |
| 1670001234567 | head$pos$y       | unknown | 8        | 7.3   |
| 1670001234567 | head$pos$z       | unknown | 8        | 3.2   |
| 1670001234567 | head$temperature | unknown | 8        | 50.0  |
| 1670001234567 | head$collision   | unknown | 8        | 0     |

All tags have the same asset_id because each topic contains the same Location.
The tag groups are not part of the asset and are prefixed to the tag name.

{{% notice note %}}
The origin is a placeholder for a later feature, and currently defaults to `unknown`.
{{% /notice %}}

### tag_string

This table is similar to the tag table, but is used for string data.
For example, a CNC cutter could also output the G-code being processed.

`umh/v1/cuttingincorporated/cologne/cnc-cutter/_historian`

```json
{
 "timestamp_ms": 1670001247568,
  "g-code": "G01 X10 Y10 Z0"
}
```

Posting this message to the topic from above would result in this entry:

| timestamp     | name   | origin  | asset_id | value          |
|---------------|--------|---------|----------|----------------|
| 1670001247568 | g-code | unknown | 8        | G01 X10 Y10 Z0 |
