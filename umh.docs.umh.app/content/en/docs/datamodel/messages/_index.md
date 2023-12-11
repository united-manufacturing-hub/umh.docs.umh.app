---
title: "Messages"
chapter: true
description: "All available messages"
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
    originID -->|Optional| _schema
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

### [_historian](./_historian)

Messages tagged with `_historian` will be stored in our database and are available via Grafana.

### _analytics

Analytics messages are currently work-in-progress and will be detailed later.

### _local

This key might contain any data, that you do not want to bridge to other nodes.


For example this could be data you want to pre-process on your local node, and then put into another `_schema`.

### Other

All other schemas will be forwarded by bridges but ignored by any of our processors.