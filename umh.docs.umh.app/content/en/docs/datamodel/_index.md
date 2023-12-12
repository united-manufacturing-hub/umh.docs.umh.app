---
title: "Data Model (v1)"
menuTitle: "Data Model (v1)"
description: "This page describes the data model of the UMH stack - from the message payloads up to database tables."
weight: 1725
---

{{% notice note %}}
If you like to learn more about our data model & [ADR's](https://adr.github.io/) checkout our [learn article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
{{% /notice %}}

### Unified Namespace and Message Management in UMH

#### Unified Namespace (UNS) Implementation

In the United Manufacturing Hub (UMH), we have established a Unified Namespace (UNS) as a foundational element for our Industrial IoT (IIoT) data processing architecture. This architecture employs MQTT and Kafka in a hybrid approach, utilizing MQTT for efficient data collection and Kafka for robust data processing. The UNS is designed to be reliable, scalable, and maintainable, facilitating real-time data processing and seamless integration or removal of system components.

Key aspects of the UNS include:
1. **Hybrid Architecture**: Combining MQTT's user-friendliness and widespread adoption in Operational Technology (OT) with Kafka's advanced processing capabilities.
2. **Data Modeling Schema**: Developing an [open schema](./messages) that aligns with [ISA95](https://en.wikipedia.org/wiki/ANSI/ISA-95) standards, simplifying data payloads to [JSON](https://www.json.org/json-en.html) format for accessibility.
3. **Topic Structure Management**: [Aligning topic structures with the ISA95 model](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/#:~:text=How%20we%20handle%20the%20situation), ensuring data integrity and ease of understanding for OT professionals.

#### Message Management Strategies

For efficient message handling and data organization within the UNS, several strategies have been implemented:

1. **Time-Series Data Handling**: The `_historian` schema, using [TimescaleDB](https://www.timescale.com/), organizes time-series data effectively. This structured approach enables detailed data analysis while ensuring organized data management and reduced system load.

2. **Payload Structure**: JSON has been selected as the primary data format for payloads. Its direct readability, simplicity, and compatibility make it particularly suitable for the manufacturing environment, striking a balance between handling complex data structures and maintaining user-friendliness.

3. **Data Bridge for MQTT and Kafka Integration**: A crucial element is the Data Bridge microservice, which efficiently transfers data between MQTT and Kafka brokers. It uses a merge point feature to maintain a consistent topic strategy across both platforms, optimizing performance while ensuring clarity and accessibility for OT professionals.
