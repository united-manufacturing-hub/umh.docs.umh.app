---
title: "Unified Namespace"
chapter: true
description: "Describes all available _schema and there structure"
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

## Versioning Prefix

The `umh/v1` at the beginning is obligatory. It ensures that the structure can evolve over time without causing confusion or compatibility issues.

## Topic Names & Rules

All part of this structure, except for `enterprise` and `_schema` are optional.
They can consist of any letters (`a-z`, `A-Z`), numbers (`0-9`) and therein symbols (`-` & `_`).
Be careful to avoid `.`, `+`, `#` or `/` as these are special symbols in Kafka or MQTT.
Ensure that your topic always begins with `umh/v1`, otherwise our system will ignore your messages.

Be aware that our topics are case-sensitive, therefore `umh.v1.ACMEIncorperated` is __not__ the same as `umh.v1.acmeincorperated`.

{{% notice info %}}
Throughout this documentation we will use the MQTT syntax for topics (`umh/v1`), the corresponding Kafka topic names are the same but `/` replaced with `.`
{{% /notice %}}

{{% topic_decoder %}}

## OriginID
This part identifies where the data is coming from.
Good options include the senders MAC address, hostname, container id.
Examples for originID: `00-80-41-ae-fd-7e`, `E588974`, `e5f484a1791d` 

## _schema

### [_historian](./_historian)

Messages tagged with `_historian` will be stored in our database and are available via Grafana.

### [_analytics](./_analytics)

Messages tagged with `_analytics` will be processed by our analytics pipeline.
They are used for automatic calculation of KPI's and other statistics.

### _local

This key might contain any data, that you do not want to bridge to other nodes (it will however be MQTT-Kafka bridged on its node).


For example this could be data you want to pre-process on your local node, and then put into another `_schema`.
This data must not necessarily be JSON.

### Other

Any other schema, which starts with an underscore (for example: `_images`), will be forwarded by both MQTT-Kafka & Kafka-Kafka bridges but never processed or stored.

This data must not necessarily be JSON.

## Converting other data models
Most data models already follow a location based naming structure.

### KKS Identification System for Power Stations
KKS ([Kraftwerk-Kennzeichensystem](https://de.wikipedia.org/wiki/Kraftwerk-Kennzeichensystem)) is a standardized system for identifying and classifying equipment and systems in power plants, particularly in German-speaking countries.

In a flow diagram, the designation is: `1 2LAC03 CT002 QT12`

- Level 0 Classification:

    Block 1 of a power plant site is designated as 1 in this level.

- Level 1 Classification:

    The designation for the 3rd feedwater pump in the 2nd steam-water circuit is 2LAC03. This means:
    
    Main group 2L: 2nd steam, water, gas circuit
    Subgroup (2L)A: Feedwater system
    Subgroup (2LA)C: Feedwater pump system
    Counter (2LAC)03: third feedwater pump system

- Level 2 Classification:

    For the 2nd temperature measurement, the designation CT002 is used. This means:
    
    Main group C: Direct measurement
    Subgroup (C)T: Temperature measurement
    Counter (CT)002: second temperature measurement
- Level 3 Classification:
    
    For the 12th immersion sleeve as a sensor protection, the designation QT12 is used. This means:
    
    - Main group Q: Control technology equipment
    - Subgroup (Q)T: Protective tubes and immersion sleeves as sensor protection
    - Counter (QT)12: twelfth protective tube or immersion sleeve

The above example refers to the 12th immersion sleeve at the 2nd temperature measurement of the 3rd feed pump in block 1 of a power plant site.
Translating this in our data model could result in:
`umh/v1/nuclearCo/1/2LAC03/CT002/QT12/_schema`

Where:
- nuclearCo: Represents the enterprise or the name of the nuclear company.
- 1: Maps to the `site`, corresponding to Block 1 of the power plant as per the KKS number.
- 2LAC03: Fits into the `area`, representing the 3rd feedwater pump in the 2nd steam-water circuit.
- CT002: Aligns with `productionLine`, indicating the 2nd temperature measurement in this context.
- QT12: Serves as the `workCell` or `originID`, denoting the 12th immersion sleeve.
- _schema: Placeholder for the specific data schema being applied.
