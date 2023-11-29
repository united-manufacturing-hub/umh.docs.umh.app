---
title: "Historian"
menuTitle: "Historian"
description: |
  Insight into the Historian's role in storing and visualizing data within the
  UMH ecosystem.
weight: 3000
---


The Historian in the United Manufacturing Hub serves as a comprehensive data
management and visualization system. It includes:

- kafka-to-postgresql-v2: Archives Kafka messages adhering to the Data Model V2 schema into the database.
- TimescaleDB: An open-source SQL database specialized in time-series data storage.
- Grafana: A software tool for data visualization and analytics.
- factoryinsight: An analytics tool designed for data analysis, including calculating operational efficiency metrics like OEE.
- grafana-datasource-v2: A Grafana plugin facilitating connection to factoryinsight.
- Redis: Utilized as an in-memory data structure store for caching purposes.

This structure ensures that data from the Unified Namespace is systematically
stored, processed, and made visually accessible, providing OT professionals with
real-time insights and analytics on shop floor operations.

{{< mermaid theme="neutral" >}}
graph LR
  2["`fa:fa-user **OT Professional / Shopfloor**
  Monitors and manages the shopfloor, including safety, automation and maintenance`"]
  style 2 fill:#dddddd,stroke:#9a9a9a,color:#000000
  51["`**Unified Namespace**
  The central source of truth for all events and messages on the shop floor.`"]
  style 51 fill:#aaaaaa,stroke:#47a0b5,color:#000000

    subgraph 64 [Historian]
      style 64 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

      65["`**kafka-to-postgresql-v2**
      Stores in the database the Kafka messages that follow the Data Model V2 schema`"]
      style 65 fill:#aaaaaa,stroke:#47a0b5,color:#000000
      66["`**TimescaleDB**
      An open-source time-series SQL database`"]
      style 66 fill:#aaaaaa,stroke:#47a0b5,color:#000000
      67["`**Grafana**
      Visualization and analytics software`"]
      style 67 fill:#aaaaaa,stroke:#47a0b5,color:#000000
      68["`**factoryinsight**
      Analytics software that allows data analysis, like OEE`"]
      style 68 fill:#aaaaaa,stroke:#47a0b5,color:#000000
      69["`**grafana-datasource-v2**
      Grafana plugin to easily connect to factoryinsight`"]
      style 69 fill:#aaaaaa,stroke:#47a0b5,color:#000000
      70["`**Redis**
      In-memory data structure store used for caching`"]
      style 70 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    end

    65-. Stores data .->66
    51-. Stores data in a
  predefined schema via .->65
    67-. Performs SQL queries .->66
    67-. Includes .->69
    69-. Extracts KPIs and other
    high-level metrics .->68
    68-. Queries data .->66
    68<-.->70
    65<-.->70
    2-. Visualize real-time
  dashboards .->67
{{< /mermaid >}}
