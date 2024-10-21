---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes the messages and actions in the Uified Namespace - from the message payloads up to database tables."
weight: 1725
---

{{<mermaid theme="neutral" >}}
flowchart LR
AP[Automation Pyramid] --> C_d
C_d --> UN_d
UN_d --> H_d
UN_d --> A_d
H_d --> DL[Data Lake]
A_d --> G[Performance Monitoring]

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

        subgraph DC[ ]
            subgraph H_d[ ]
                H_d_infoX["Historian\n(e.g., TimescaleDB)"]
                H_d_info[Table: asset\nTable: tag\nTable: tag_string]
                H_d_infoX --- H_d_info
            end

            subgraph A_d[ ]
                A_d_infoX["Analytics\n(e.g., KPIs)"]
            end
        end

    end
click C_d_infoX href "../features/connectivity"
click UN_d_infoX href "./messages"
click H_d_infoX href "./database"
click C_d_info href "../features/connectivity"
click UN_d_info href "./messages"
click H_d_info href "./database"

{{</ mermaid >}}

## Data Contracts / API in UMH

The Data Infrastructure of UMH comprises several key components: Connectivity,
Unified Namespace (UNS), Analytics, and Historian (refer to our
[Architecture](./../architecture) for more details). Each component follows its
own standards and best practices, necessitating a unified data structure to
seamlessly integrate all building blocks.

{{% notice note %}}
For more insights explore our
[Architectural Decision Records (ADRs)](https://adr.github.io/), check out our
[learning article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
{{% /notice %}}

## Connectivity

Since incoming data is often unstructured, our standard permits either
conformant data within our `_historian` or `_analytics` schemas or any type
of data in other custom schemas.

Our main considerations are:

1. **Event-driven architecture**: We focus solely on changes, reducing network
and system load.
2. **Ease of use**: We accept any data format, allowing OT and IT teams to
process data as they see fit.

## [Unified Namespace](./messages)

Our UNS utilizes a hybrid approach, combining [MQTT](https://mqtt.org/) for
efficient data collection and [Kafka](https://kafka.apache.org/) for robust
data processing. Designed for reliability, scalability, and maintainability,
the UNS facilitates real-time data processing and the seamless integration or
removal of system components.

The foundation of our data contracts and API within the UNS includes:

1. **Incoming data aligned with OT standards**: Data should be contextualized
by OT personnel. They prefer to model their data (topic hierarchy and payloads)
according to standards like ISA-95, Weihenstephaner Standard, Omron PackML,
Euromap84, or similar, often using [JSON](https://www.json.org/json-en.html)
payloads for better understanding.

2. **Hybrid Architecture**: We merge the user-friendliness and widespread
adoption of MQTT in Operational Technology (OT) with Kafka's advanced processing
capabilities. Due to limitations in MQTT and Kafka, topics and payloads cannot
be fully interchanged, so certain trade-offs are necessary.

3. **Processed data following IT standards**: After processing, data is sent to
IT systems and must adhere to IT standards. Data within the UNS should be
easily processable for tasks like contextualization or storage in a Historian
or Data Lake.

## [Historian](./database)

We have chosen [TimescaleDB](https://www.timescale.com/) as our primary database.

Our selection was based on the following key factors:

1. **Adherence to IT best practices**: By using SQL and PostgreSQL, we ensure
easy compatibility, which is why TimescaleDB was our choice.
2. **Simplified queries**: We aim for straightforward SQL queries, enabling
everyone to build dashboards with ease.
3. **High performance**: Given the time-series nature and typical workload, the
database schema may not be fully optimized for usability. However, we've made
trade-offs that allow it to store millions of data points per second.
