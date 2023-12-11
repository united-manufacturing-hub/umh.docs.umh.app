---
title: "_historian"
description: "TODO"
edition: community
weight: 1000
---


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