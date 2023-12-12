---
title: "Data Model (v1)"
menuTitle: "Data Model (v1)"
description: "This page describes the data model of the UMH stack - from the message payloads up to database tables."
weight: 1725
---

{{<mermaid theme="neutral" >}}
flowchart LR
AP[Automation Pyramid] --> C_d
C_d --> UN_d
UN_d --> H_d
H_d --> DL[Data Lake]

    subgraph UNS[ ]
        subgraph C_d[ ]
            C_d_infoX["Connectivity\n(e.g., OPC UA)"]
            C_d_info["Time-Series data\nUnstructured / semi-structured data\nRelational data (master, operational, batch)"]
            C_d_infoX --- C_d_info
        end

        subgraph UN_d[ ]
            UN_d_infoX["Unified Namespace\n(e.g., MQTT, Kafka)"]
            UN_d_info["umh/v1/enterprise/site/area/productionLine/workCell/originID/_schema/schema_specific"]
            UN_d_infoX --- UN_d_info
        end

        subgraph H_d[ ]
            H_d_infoX["Historian\n(e.g., TimescaleDB)"]
            H_d_info[Table: asset\nTable: tag\nTable: tag_string]
            H_d_infoX --- H_d_info
        end
    end
click C_d_infoX href "../features/connectivity"
click UN_d_infoX href "./messages"
click H_d_infoX href "./database"
{{</ mermaid >}}
The Data Infrastructure of the UMH consists out of the three components: Connectivity, Unified Namespace, and Historian (see also [Architecture](./../architecture)). Each of the components has their own standards and best-practices, so a consistent data model across
multiple building blocks need to combine all of them.

{{% notice note %}}
If you like to learn more about our data model & [ADR's](https://adr.github.io/) checkout our [learn article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
{{% /notice %}}

## Connectivity
Incoming data is often unstructured, therefore our standard allows either conformant data in our `_historian` schema, or any kind of data in any other schema.

Our key considerations where:
1. **Event driven architecture**: We only look at changes, reducing network and system load
2. **Ease of use**: We allow any data in, allowing OT & IT to process it as they wish

## [Unified Namespace](./messages)
The UNS employs [MQTT](https://mqtt.org/) and [Kafka](https://kafka.apache.org/) in a hybrid approach, utilizing MQTT for efficient data collection and Kafka for robust data processing.
The UNS is designed to be reliable, scalable, and maintainable, facilitating real-time data processing and seamless integration or removal of system components.

These elements are the foundation for our data model in UNS:

1. **Incoming data based on OT standards**: Data needs to be contextualized here not by IT people, but by OT people.
They want to model their data (topic hierarchy and payloads) according to ISA-95, Weihenstephaner Standard, Omron PackML, Euromap84,  (or similar) standards, and need e.g., [JSON](https://www.json.org/json-en.html) as payload to better understand it.

2. **Hybrid Architecture**: Combining MQTT’s user-friendliness and widespread adoption in Operational Technology (OT) with Kafka’s advanced processing capabilities.
Topics and payloads can not be interchanged fully between them due to limitations in MQTT and Kafka, so some trade-offs needs to be done.

3. **Processed data based on IT standards**: Data is sent after processing to IT systems, and needs to adhere with standards: the data inside of the UNS needs to be easy processable for either contextualization, or storing it in a Historian or Data Lake.

## [Historian](./database)
We choose [TimescaleDB](https://www.timescale.com/) as our primary database.

Key elements we considered:
1. **IT best-practice**: used SQL and Postgres for easy compatibility, and therefore TimescaleDb
2. **Straightforward queries**: we aim to make easy SQL queries, so that everyone can build dashboards
3. **Performance**: because of time-series and typical workload, the database layout might not be optimized fully on usability, but we did some trade-offs that allow it to store millions of data points per second
