---
title: "Messages"
chapter: true
description: "All available messages"
edition: community
weight: 1000
---

# Message structure

The messages in our datamodel have to be JSON using the following format:
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
      { "type": "number" }
      { "type": "boolean" }
    ]
  },
  "minProperties": 2
}
```
Examples:
```json
{
    "timestamp_ms": 1702286893,
    "temperature_c": 154.1
}
```

```json
{
    "timestamp_ms": 1702286893,
    "temperature_c": 154.1,
    "pressure_bar": 5,
    "notes": "sensor 1 is faulty"
}
```


{{% notice note %}}
If you use a boolean value, it will be interpreted as a number.
{{% /notice %}}

# Topic structure

{{<mermaid theme="neutral" >}}
flowchart LR
    umh --> v1
    v1 --> enterprise
    enterprise -->|Optional| site
    site -->|Optional| area
    area -->|Optional| productionLine
    productionLine -->|Optional| workCell
    workCell -->|Optional| originID
    originID -->|Optional| _schema --> |Optional| tagName
    _schema --> |Optional| tagGroup
    tagGroup --> tagName
    
    classDef mqtt fill:#00aa00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_schema mqtt;
    classDef optional fill:#779977,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID,tagGroup,tagName optional;
    
    enterprise -.-> _schema
    site -.-> _schema
    area -.-> _schema
    productionLine -.-> _schema
    workCell -.-> _schema
    tagGroup -.-> |1-N| tagGroup
{{</ mermaid >}}

## Versioning Prefix

The `umh/v1` at the beginning is obligatory. It ensures that the structure can evolve over time without causing confusion or compatibility issues.

## Topic Names & Rules

All part of this structure, except for `enterprise` and `_schema` are optional.
They can consist of any letters (`a-z`, `A-Z`), numbers (`0-9`) and therein symbols (`-` & `_`).
Be careful to avoid `.`, `+`, `#` or `/` as these are special symbols in Kafka or MQTT.
Ensure that your topic always begins with `umh/v1`, otherwise our system will ignore your messages.


{{% notice info %}}
Throughout this documentation we will use the MQTT syntax for topics (`umh/v1`), the corresponding Kafka topic names are the same but `/` replaced with `.`
{{% /notice %}}

## OriginID
This part identifies where the data is coming from.
Good options include the senders MAC address, hostname, container id.
Examples for originID: `00-80-41-ae-fd-7e`, `E588974`, `e5f484a1791d` 

## _schema

  - _historian

    These messages must include a `timestamp_ms` key set to a UNIX timestamp in milliseconds since the epoch.

    They must also contain one or more other keys, used as tags for saving into the db.

    If your message does not follow this format it will be ignored 
    by our databridge and kafka-to-postgresql-v2 microservices, and therefore neither forwarded nor processed.

  - _analytics

      Analytics messages are currently work-in-progress and will be detailed later.

  - _local

      This key might contain any data, that you do not want to bridge further.
      It will not be bridged between MQTT & Kafka.

  - Other

      All other schemas will be forwarded by bridges but ignored by any of our processors

### Forwarding and processing

{{<mermaid theme="neutral" >}}
flowchart TB
historian[_historian]
analytics[_analytics]
other[Other]
local[_local]

    processed[Processed]
    forwarded[Forwarded]

    historian --> processed
    historian --> forwarded
    analytics --> processed
    analytics --> forwarded
    other --> forwarded

    classDef schema fill:#add8e6,stroke:#333,stroke-width:2px;
    class historian,analytics,local,other schema;

    classDef action fill:#90ee90,stroke:#333,stroke-width:2px;
    class processed,forwarded action;

{{</ mermaid >}}

## Tag grouping
1) __Using Underscores in Key Names__: For example, `spindle_axis_x.`
This results in the tag `x` being categorized under the group `axis`, which is part of the `spindle` group.

2) __Using Tags / Tag Groups in the Topic__:
The tag is placed before the key name, allowing for multiple group formations.

3) __Combining Both Methods__:
For instance, a message to .../_historian/spindle/axis with key x_pos will categorize `pos` under `x`, which is under `axis` and `spindle`.