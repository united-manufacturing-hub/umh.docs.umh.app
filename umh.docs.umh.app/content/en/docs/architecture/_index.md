---
title: "Architecture"
menuTitle: "Architecture"
description: |
  A detailed overview of the United Manufacturing Hub architecture.
weight: 2000
no_list: true
---

The United Manufacturing Hub is a comprehensive Helm Chart for Kubernetes,
integrating a variety of open source software, including notable third-party
applications such as Node-RED and Grafana. Designed for versatility, UMH is
deployable across a wide spectrum of environments, from edge devices to virtual
machines, and even managed Kubernetes services, catering to diverse industrial
needs.

The following diagram illustrates the interaction between different types of
users and UMH's components, offering a clear visual representation of its
architecture and functionality.

{{< mermaid theme="neutral" >}}
graph LR
  subgraph group1 [United Manufacturing Hub]
    style group1 fill:#ffffff,stroke:#47a0b5,color:#47a0b5,stroke-dasharray:5

    16["`**Management Console**
    Configures, manages, and monitors Data and Device & Container Infrastructures in the UMH Integrated Platform`"]
    style 16 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    27["`**Device & Container Infrastructure**
    Oversees automated, streamlined installation of key software and operating systems`"]
    style 27 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    50["`**Data Infrastructure**
    Integrates every ISA-95 standard layer with the Unified Namespace, adding data sources beyond typical automation pyramid bounds`"]
    style 50 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  1["`fa:fa-user **IT/OT Professional**
  Manages and monitors the United Manufacturing Hub`"]
  style 1 fill:#dddddd,stroke:#9a9a9a,color:#000000
  2["`fa:fa-user **OT Professional / Shopfloor**
  Monitors and manages the shopfloor, including safety, automation and maintenance`"]
  style 2 fill:#dddddd,stroke:#9a9a9a,color:#000000
  3["`fa:fa-user **Business Analyst**
  Gathers and analyzes company data to identify needs and recommend solutions`"]
  style 3 fill:#dddddd,stroke:#9a9a9a,color:#000000
  4["`**Data Warehouse/Data Lake**
  Stores data for analysis, on-premise or in the cloud`"]
  style 4 fill:#f4f4f4,stroke:#f4f4f4,color:#000000
  5["`**Automation Pyramid**
  Represents the layered structure of systems in manufacturing operations based on the ISA-95 model`"]
  style 5 fill:#f4f4f4,stroke:#f4f4f4,color:#000000

  1-. Interacts with the
      entire infrastructure .->16
  16-. Manages & monitors .->27
  16-. Manages & monitors .->50
  2-. Access real-time
      dashboards from .->50
  2-. Works with .->5
  3-. Gets and analyzes data from .->4
  50-. Is installed on .->27
  50-. Provides data to .->4
  50-. Provides to and
       extracts data from .->5
{{</ mermaid >}}

## Management Console

The Management Console of the United Manufacturing Hub is a sophisticated web
application designed to configure, manage, and monitor the various aspects of
Data and Device & Container Infrastructures within UMH. Acting as the central
command center, it provides a comprehensive overview and control over the system's
functionalities, ensuring efficient operation and maintenance. The console simplifies
complex processes, making it accessible for users to oversee the vast array of
services and operations integral to UMH.

## Device & Container Infrastructure

The Device & Container Infrastructure forms the foundational layer of the United
Manufacturing Hub's architecture, streamlining the deployment and setup of critical
software and operating systems across devices. This infrastructure is pivotal in
automating the installation process, ensuring that the essential software components
and operating systems are efficiently and reliably established. It provides the
groundwork upon which the Data Infrastructure is built, embodying a robust and
scalable base for the entire architecture.

## Data Infrastructure

### Data Connectivity

### Unified Namespace

### Historian

## Data connectivity

The United Manufacturing Hub includes microservices that extract data from the shop floor and push it into the Unified Namespace. Additionally, you can deploy your own microservices or third-party solutions directly into the Kubernetes cluster using the [custom microservice feature](/docs/architecture/helm-chart/#custom-microservices-configuration). To learn more about third-party solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app)

- [sensorconnect](/docs/architecture/microservices/core/sensorconnect/) automatically reads out IO-Link Master and their connected sensors, and pushes the data to the message broker.
- [barcodereader](/docs/architecture/microservices/core/barcodereader/) connects to USB barcode reader devices and pushes the data to the message broker.
- [Node-RED](/docs/architecture/microservices/core/node-red/) is a versatile tool with many community plugins and allows access to machine PLCs or connections with other systems on the shopfloor. It plays an important role and is explained in the next section.

Node-RED is not just a tool for connectivity, but also for stream processing and data contextualization. It is often used to extract data from the message broker, reformat the event, and push it back into a different topic, such as the [UMH datamodel](/docs/architecture/datamodel).

In addition to the built-in microservices, third-party contextualization solutions can be deployed similarly to [data connectivity microservices](#data-connectivity-microservices). For more information on these solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app/).
In addition to the built-in microservices, third-party contextualization solutions can be deployed similarly to [data connectivity microservices](#data-connectivity-microservices). For more information on these solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app/).

## Unified Namespace

At the core of the United Manufacturing Hub lies the [Unified Namespace](/lesson/introduction-into-it-ot-unified-namespace/), which serves as the central source of truth for all events and messages occurring on your shop floor. The Unified Namespace is implemented using two message brokers: HiveMQ for [MQTT](https://learn.umh.app/lesson/introduction-into-it-ot-mqtt/) and [Apache Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/). MQTT is used to receive data from IoT devices on the shop floor because it excels at handling a large number of unreliable connections. On the other hand, Kafka is used to enable communication between the microservices, leveraging its large-scale data processing capabilities.

The data between both brokers is bridged automatically using the mqtt-to-kafka microservice, allowing you to send data to MQTT and process it reliably in Kafka.

If you're curious about the benefits of this dual approach to MQTT/Kafka, check out our blog article about [Tools & Techniques for Scalable Dataprocessing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).

{{% notice tip %}}
For more information on the Unified Namespace feature and how to use it, check out the detailed description of the [Unified Namespace feature](/docs/features/unified-namespace/).
{{% /notice %}}

- [HiveMQ](/docs/architecture/microservices/core/mqtt-broker/) is an MQTT broker used for receiving data from IoT devices on the shop floor. It excels at handling large numbers of unreliable connections.
- [Apache Kafka](/docs/architecture/microservices/core/kafka-broker/) is a distributed streaming platform used for communication between microservices. It offers large-scale data processing capabilities.
- [mqtt-kafka-bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/) is a microservice that bridges messages between MQTT and Kafka, allowing you to send data to MQTT and process them reliably in Kafka.
- [kafka-bridge](/docs/architecture/microservices/core/kafka-bridge/) a microservice that bridges messages between multiple Kafka instances.
- [console](/docs/architecture/microservices/core/kafka-console/) is a web-based user interface for Kafka, which provides a graphical view of topics and messages.

## Historian / data storage and visualization

The United Manufacturing Hub stores events according to our [datamodel](/docs/architecture/datamodel/). These events are automatically stored in TimescaleDB, an open-source time-series SQL database. From there, you can access the stored data using Grafana, a visualization and analytics software. With Grafana, you can perform on-the-fly data analysis by executing simple min, max, and avg on tags, or extended KPI calculations such as OEE. These calculations can be selected in the umh-datasource microservice.

{{% notice tip %}}
For more information on the Historian or Analytics feature and how to use it, check out the detailed description of the [Historian feature](/docs/features/historian/) or the [Analytics features](/docs/features/analytics/).
{{% /notice %}}

- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql/) stores data in selected topics from the Kafka broker in a PostgreSQL compatible database such as TimescaleDB.
- [TimescaleDB](/docs/architecture/microservices/core/database/), which is an open-source time-series SQL database 
- [factoryinsight](/docs/architecture/microservices/core/factoryinsight/) provides REST endpoints to fetch data and calculate KPIs
- [Grafana](/docs/architecture/microservices/core/grafana/) is a visualization and analytics software
- [umh-datasource](/docs/architecture/microservices/grafana-plugins/umh-datasource/) is a plugin providing access factoryinsight
- [redis](/docs/architecture/microservices/core/cache/) is an in-memory data structure store, used for cache.

## Other

### Custom Microservices

The Helm Chart allows you to add your own microservices or Docker containers to the United Manufacturing Hub. These can be used, for example, to connect with third-party systems or to analyze the data. Additionally, you can deploy any other third-party application as long as it is available as a Helm Chart, Kubernetes resource, or Docker Compose (which can be converted to Kubernetes resources).

### Simulators

The United Manufacturing Hub includes several simulators to generate data during development and testing.

- [iotsensorsmqtt](/docs/architecture/microservices/community/mqtt-simulator/) simulates data in three different MQTT topics, providing a simple way to test and visualize MQTT data streams.
- [packml-simulator](/docs/architecture/microservices/community/packml-simulator/) simulates a PackML machine which sends and receives MQTT messages
- [opcua-simulator](/docs/architecture/microservices/community/opcua-simulator/) simulates an OPC-UA server, which can then be used to test connectivity of OPC-UA clients and to generate sample data for OPC-UA clients
