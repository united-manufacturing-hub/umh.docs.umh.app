---
title: "Data Contracts / API"
menuTitle: "Data Contracts / API"
description: "This page describes how messages flow in the UMH, which message goes where, how it has to look like and how you can build your own structures."
weight: 1725
---
<!--
{{<mermaid theme="neutral" >}}
flowchart LR
AP[Automation Pyramid] -- > C_d
C_d -- > UN_d
UN_d -- > H_d
UN_d -- > A_d
H_d -- > DL[Data Lake]
A_d -- > G[Performance Monitoring]

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
-->

## What are Data Contracts

Data Contracts are formal agreements that define the structure, format, and rules for data exchanged between components within a Unified Namespace (UNS) architecture. They specify metadata, data models, and service levels to ensure that all systems interact consistently and reliably. By establishing clear guidelines for data sharing, Data Contracts facilitate seamless integration and prevent disruptions caused by changes in data formats or structures.

In short, they define where a messages goes, what structure it has to follow, how it gets there, what happens on its arrival, based on rules set by either us as defaults, or the user.

{{% notice note %}}
For more insights explore our
[Architectural Decision Records (ADRs)](https://adr.github.io/), check out our
[learning article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
<!-- Add link to Jeremys upcoming article, once it is released. -->
{{% /notice %}}

## Example

To give you an easy example just think about the `_historian` schema you probably already have used.
You want to send data from your machines to your UNS and store in the data base.
For Kafka to process your message and successfully write it into the data base, you have to adhere to the topic stuture, including the `_historian` schema, and use the correct payload format.
This in makes sure that the data can be stored in the data base tables without causing errors and that the data can be read by other programs as they know what data to expect.

This overall is a Data Contract.

## Example of a custom Data Contract

You can also add your own contracts to your UNS.
For example, implementing a Data Contract to automate MES and PLC interaction.

**Scenario**: When a machine stops, the latest order ID from the MES needs to be automatically written into the PLC.

**Objective**: Utilize data contracts within a Unified Namespace (UNS) to automate data exchange between the MES and PLC, ensuring scalability and maintainability across multiple machines and production lines.

**Approach**:

We begin by utilizing the existing `_historian` data contract to continuously send and store the latest order ID from the MES in the UNS.

Additionally a schema is required to handle action requests and responses, enabling commands like writing data to the PLC, for example `_action`.
Since the `_action` schema does not yet exist, it needs to be manually added first.

Next, implement protocol converters to facilitate communication between systems.
The first **ingiong protocol converter** fetches the latest order ID from the MES and publishes it to the UNS using the `_historian` data contract.
A second **outgoing protocol converter** listens for action requests in the manually added `_action` data contract and executes them by getting the last order ID from the UNS and writing the order ID to the PLC.

Finally, we set up a stream processor that monitors the UNS for specific conditions, such as a machine stoppage. When such a condition is detected, it generates an action request in the `_action` data contract for the output protocol converter to process.

The combination of the Historian Data Contract, the additional `_action` schema, the two Protocol Converters and the stream processor and enforcement of payload and topic structure from this new Data Contract.

**Benefits**:

- **Scalability**: The solution can be templated and applied across various assets.
- **Maintainability**: Leveraging default data contracts reduces complexity and eases system upkeep.
- **Reliability**: Ensures consistent data handling and robust operation within a distributed system.

## Why Data Contracts

This standardization enhances data integrity and reduces the risk of system failures when modifications are necessary. Implementing Data Contracts also improves the scalability and maintainability of your architecture, allowing your organization to manage complex data interactions efficiently.

## Deep Dive into Data modeling

If this has sparked your interest, or you want to read more about reasons why we use this approach, we recommend reading the aricle about [Data Modeling in the UNS](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/) on our learn page.

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
