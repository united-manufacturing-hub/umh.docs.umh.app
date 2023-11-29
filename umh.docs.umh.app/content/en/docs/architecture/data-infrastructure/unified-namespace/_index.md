---
title: "Unified Namespace"
menuTitle: "Unified Namespace"
description: |
  Discover the Unified Namespace's role as a central hub for shop floor data in
  UMH.
weight: 2000
---

The Unified Namespace (UNS) within the United Manufacturing Hub is a vital module
facilitating the streamlined flow and management of data. It comprises various
microservices:

- Redpanda (Kafka): Manages large-scale data processing and orchestrates communication between microservices.
- HiveMQ: An MQTT broker crucial for receiving data from IoT devices on the shop floor.
- Redpanda Console: Offers a graphical interface for monitoring Kafka topics and messages.
- Data Bridge: Bridges data between MQTT and Kafka and between multiple Kafka instances, ensuring efficient data transmission.

The UNS serves as a pivotal point in the UMH architecture, ensuring data from shop
floor systems and sensors (gathered via the Data Connectivity module) is effectively
processed and relayed to the Historian and external Data Warehouses/Data Lakes
for storage and analysis.

{{< mermaid theme="neutral" >}}
graph LR
  4["`**Data Warehouse/Data Lake**
  Stores data for analysis, on-premise or in the cloud`"]
  style 4 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  64["`**Historian**
  Stores events in a time-series database and provides visualization tools.`"]
  style 64 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  85["`**Connectivity**
  Includes tools and services for connecting various shop floor systems and sensors.`"]
  style 85 fill:#aaaaaa,stroke:#47a0b5,color:#000000

  subgraph 51 [Unified Namespace]
    style 51 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

    52["`**Redpanda (Kafka)**
    Handles large-scale data processing and communication between microservices.`"]
    style 52 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    53["`**HiveMQ**
    MQTT broker used for receiving data from IoT devices on the shop floor.`"]
    style 53 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    54["`**Redpanda Console**
    Provides a graphical view of topics and messages in Kafka.`"]
    style 54 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    55["`**databridge**
    Bridges messages between MQTT and Kafka as well as between Kafka and other Kafka instances.`"]
    style 55 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  54-.->52
  52<-.->55
  55<-.->53
  55-. Provides data .->4
  52-. Stores data in a
  predefined schema .->64
  85-. Provides
  contextualized data .->53
  85-. Provides
  contextualized data .->52
{{< / mermaid >}}
