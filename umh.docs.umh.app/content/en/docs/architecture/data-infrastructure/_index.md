---
title: "Data Infrastructure"
menuTitle: "Data Infrastructure"
description: |
  An overview of UMH's Data Infrastructure, integrating and managing diverse data
  sources.
weight: 1000
---

The United Manufacturing Hub's Data Infrastructure is where all data converges.
It extends the ISA95 Automation Pyramid, the usual model for data flow in factory
settings. This infrastructure links each level of the traditional pyramid to the
Unified Namespace (UNS), incorporating extra data sources that the typical automation
pyramid doesn't include. The data is then organized, stored, and analyzed to offer
useful information for frontline workers. Afterwards, it can be sent to the a data
lake or analytics platform, where business analysts can access it for deeper insights.

It comprises three primary elements:

- **[Data Connectivity](/docs/architecture/data-infrastructure/data-connectivity)**:
  This component includes an array of tools and services designed
  to connect various systems and sensors on the shop floor, facilitating the flow
  of data into the Unified Namespace.
- **[Unified Namespace](/docs/architecture/data-infrastructure/unified-namespace)**:
  Acts as the central hub for all events and messages on the
  shop floor, ensuring data consistency and accessibility.
- **[Historian](/docs/architecture/data-infrastructure/historian)**: Responsible
  for storing events in a time-series database, it also provides tools for data
  visualization, enabling both real-time and historical analytics.

Together, these elements provide a comprehensive framework for collecting,
storing, and analyzing data, enhancing the operational efficiency and
decision-making processes on the shop floor.

{{< mermaid theme="neutral" >}}
graph LR
  2["`fa:fa-user **OT Professional / Shopfloor**
  Monitors and manages the shopfloor, including safety, automation and maintenance`"]
  style 2 fill:#dddddd,stroke:#9a9a9a,color:#000000
  4["`**Data Warehouse/Data Lake**
  Stores data for analysis, on-premise or in the cloud`"]
  style 4 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  5["`**Automation Pyramid**
  Represents the layered structure of systems in manufacturing operations based on the ISA-95 model`"]
  style 5 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  16["`**Management Console**
  Configures, manages, and monitors Data and Device & Container Infrastructures in the UMH Integrated Platform`"]
  style 16 fill:#aaaaaa,stroke:#47a0b5,color:#000000

  subgraph 50 [Data Infrastructure]
    style 50 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

    51["`**Unified Namespace**
    The central source of truth for all events and messages on the shop floor.`"]
    style 51 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    64["`**Historian**
    Stores events in a time-series database and provides visualization tools.`"]
    style 64 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    85["`**Connectivity**
    Includes tools and services for connecting various shop floor systems and sensors.`"]
    style 85 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  16-. Manages & monitors .->85
  85-. Provides
  contextualized data .->51
  85-. Provides and
  extracts data .->5
  51-. Provides data .->4
  51-. Stores data in a
  predefined schema .->64
  5<-. Works with .-2
  2-. Visualize real-time
  dashboards .->64
{{< /mermaid >}}
