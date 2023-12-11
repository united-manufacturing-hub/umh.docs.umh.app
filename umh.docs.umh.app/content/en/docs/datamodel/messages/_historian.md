---
title: "_historian"
description: "Messages for our historian feature"
edition: community
weight: 1000
---

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
originID -->|Optional| _historian --> |Optional| tagName
_historian --> |Optional| tagGroup
tagGroup --> tagName

    classDef mqtt fill:#00dd00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_historian mqtt;
    classDef optional fill:#77aa77,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID,tagGroup,tagName optional;
    
    enterprise -.-> _historian
    site -.-> _historian
    area -.-> _historian
    productionLine -.-> _historian
    workCell -.-> _historian
    tagGroup -.-> |1-N| tagGroup
{{</ mermaid >}}


# Message structure

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
1) __Using Underscores in Key Names__: For example, `spindle_axis_x.`
   This results in the tag `x` being categorized under the group `axis`, which is part of the `spindle` group.

2) __Using Tags / Tag Groups in the Topic__:
   The tag is placed before the key name, allowing for multiple group formations.

3) __Combining Both Methods__:
   For instance, a message to .../_historian/spindle/axis with key x_pos will categorize `pos` under `x`, which is under `axis` and `spindle`.

   __Examples:__
    1) Sending a message with payload
       ```json
       {
         "timestamp_ms":1680698839098,
         "x_pos":123,
         "x_speed":456,
         "y_pos":789,
         "y_speed":1
       }
       ```
       to the topic `umh/v1/dcc/aachen/shopfloor/wristband/warping/_historian/spindle/axis` will result in storing four tags for the given timestamp: `spindle_axis_x_pos`, `spindle_axis_x_speed`, `spindle_axis_y_pos`, and `spindle_axis_y_speed`.
    2) A message with payload
       ```json
       {
         "timestamp_ms":1680698839098,
         "temperature":23
       }
       ```
       to `umh/v1/dcc/aachen/_historian` stores the temperature tag for the site `aachen` for the given timestamp.