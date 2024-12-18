---
title: "_historian"
description: "Messages for our historian feature"
weight: 2000
---

# Topic structure

{{<mermaid theme="neutral" >}}
flowchart LR
topicStart["umh.v1..."] --> _historian
_historian --> |Optional| tagName
_historian --> |Optional| tagGroup
tagGroup --> tagName

    classDef mqtt fill:#00dd00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_historian mqtt;
    classDef optional fill:#77aa77,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID,tagGroup,tagName optional;

    tagGroup -.-> |1-N| tagGroup
    click topicStart href "../"
{{</ mermaid >}}


# Message structure

Our `_historian` messages are JSON containing a unix timestamp as milliseconds (`timestamp_ms`) and one or more key value pairs.
Each key value pair will be inserted at the given timestamp into the database.

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


## Tag grouping
Sometimes it makes sense to further group data together.
In the following example we have a CNC cutter, emitting data about it's head position.
If we want to group this for easier access in Grafana, we could use two types of grouping.

1) __Using Tags / Tag Groups in the Topic__:
   This will result in 3 new database entries, grouped by `head` & `pos`.

   Topic: `umh/v1/cuttingincorperated/cologne/cnc-cutter/_historian/head/pos`
    ```json
    {
     "timestamp_ms": 1670001234567,
      "x": 12.5,
      "y": 7.3,
      "z": 3.2
    }
    ```
   This method allows very easy monitoring of the data in tools like our Management Console or MQTT Explorer, as each new `/` will be displayed as a Tree.

2) __Using JSON subobjects:__

    Equivalent to the above we could also send:
    Topic: `umh/v1/cuttingincorperated/cologne/cnc-cutter/_historian`
    ```json
    {
     "timestamp_ms": 1670001234567,
      "head": {
         "pos": {
            "x": 12.5,
            "y": 7.3,
            "z": 3.2   
         }
      }
    }
    ```
   It's usefull if the machine cannot send to multiple topics, but grouping is still desired.


3) __Combining Both Methods__:
   Equivalent to the above we could also send:

   Topic: `umh/v1/cuttingincorperated/cologne/cnc-cutter/_historian/head`
    ```json
    {
     "timestamp_ms": 1670001234567,
      "pos": {
         "x": 12.5,
         "y": 7.3,
         "z": 3.2
      }
    }
    ```
   This can be useful, if we also want to monitor the cutter head temperature and other attributes, while still preserving most of the readability of the above method.
    ```json
    {
     "timestamp_ms": 1670001234567,
      "pos": {
         "x": 12.5,
         "y": 7.3,
         "z": 3.2
      },
      "temperature": 50.0,
      "collision": false
    }

## What's next?

Find out how the data is [stored and can be retrieved from our database](../../database).
