---
title: "Data Connectivity"
menuTitle: "Data Connectivity"
description: |
  Learn about the tools and services in UMH's Data Connectivity for integrating
  shop floor systems.
weight: 1000
---

The Data Connectivity module in the United Manufacturing Hub is designed to enable
seamless integration of various data sources from the manufacturing environment
into the Unified Namespace. Key components include:

- [Node-RED](/docs/architecture/data-infrastructure/data-connectivity/node-red):
  A versatile programming tool that links hardware devices, APIs, and online services.
- [barcodereader](/docs/architecture/data-infrastructure/data-connectivity/barcodereader):
  Connects to USB barcode readers, pushing data to the message broker.
- benthos-umh: A specialized version of benthos featuring an OPC UA plugin for
  efficient data extraction.
- [sensorconnect](/docs/architecture/data-infrastructure/data-connectivity/sensorconnect):
  Integrates with IO-Link Masters and their sensors, relaying data to the message broker.

These tools collectively facilitate the extraction and contextualization of data
from diverse sources, adhering to the ISA-95 automation pyramid model, and
enhancing the Management Console's capability to monitor and manage data flow
within the UMH ecosystem.

{{< mermaid theme="neutral" >}}
graph LR
  5["`**Automation Pyramid**
  Represents the layered structure of systems in manufacturing operations based on the ISA-95 model`"]
  style 5 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  16["`**Management Console**
  Configures, manages, and monitors Data and Device & Container Infrastructures in the UMH Integrated Platform`"]
  style 16 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  51["`**Unified Namespace**
  The central source of truth for all events and messages on the shop floor.`"]
  style 51 fill:#aaaaaa,stroke:#47a0b5,color:#000000

  subgraph 85 [Connectivity]
    style 85 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

    86["`**Node-RED**
    A programming tool for wiring together hardware devices, APIs, and online services.`"]
    style 86 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    87["`**Barcode Reader**
    Connects to USB barcode reader devices and pushes data to the message broker.`"]
    style 87 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    88["`**Sensor Connect**
    Reads out IO-Link Master and their connected sensors, pushing data to the message broker.`"]
    style 88 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    89["`**benthos-umh**
    Customized version of benthos with an OPC UA plugin`"]
    style 89 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  16-. Manages & monitors .->89
  89-. Provides
  contextualized data .->51
  86-. Provides
  contextualized data .->51
  87-. Provides
  contextualized data .->51
  88-. Provides
  contextualized data .->51
  89-. Extracts data via OPC UA .->5
  86-. Extracts data via S7, and
  many more protocols .->5
{{< /mermaid >}}
