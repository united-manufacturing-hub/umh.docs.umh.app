+++
title = "Architecture"
menuTitle = "Architecture"
description = "A detailed view of the architecture of the UMH stack."
weight = 2000
no_list = true
+++

The United Manufacturing Hub at its core is a [Helm Chart for Kubernetes](/docs/architecture/helm-chart) consisting of several microservices and open source 3rd party applications, such as Node-RED and Grafana. This Helm Chart can be deployed in various environments, from edge devices and virtual machines to managed Kubernetes offerings. In large-scale deployments, you find typically a combination out of all these deployment options.

In this chapter, we'll explore the various microservices and applications that make up the United Manufacturing Hub, and how they work together to help you extract, contextualize, store, and visualize data from your shop floor.
{{< mermaid theme="neutral" >}}
flowchart 
    subgraph UMH["United Manufacturing Hub"]
        style UMH fill:#47a0b5
        subgraph UNS["Unified Namespace"]
            style UNS fill:#f4f4f4
            kafka["Apache Kafka"]
            mqtt["HiveMQ"]
            console["Console"]
            kafka-bridge
            mqtt-kafka-bridge["mqtt-kafka-bridge"]

            click kafka "./microservices/core/kafka"
            click mqtt "./microservices/core/mqtt-broker"
            click console "./microservices/core/console"
            click kafka-bridge "./microservices/core/kafka-bridge"
            click mqtt-kafka-bridge "./microservices/core/mqtt-kafka-bridge"


            mqtt <-- MQTT --> mqtt-kafka-bridge <-- Kafka --> kafka
            kafka -- Kafka --> console
        end
        subgraph custom["Custom Microservices"]
            custom-microservice["A user provied custom microservice in the Helm Chart"]
            custom-application["A user provided custom application deployed as Kubernetes resources or as a Helm Chart"]
            click custom-microservice "./microservices/core/custom"
        end
        subgraph Historian
            style Historian fill:#f4f4f4
            kafka-to-postgresql
            timescaledb[("TimescaleDB")]
            factoryinsight
            umh-datasource
            grafana["Grafana"]
            redis

            click kafka-to-postgresql "./microservices/core/kafka-to-postgresql"
            click timescaledb "./microservices/core/database"
            click factoryinsight "./microservices/core/factoryinsight"
            click grafana "./microservices/core/grafana"
            click redis "./microservices/core/redis"

            kafka -- Kafka ---> kafka-to-postgresql
            kafka-to-postgresql -- SQL --> timescaledb
            timescaledb -- SQL --> factoryinsight
            factoryinsight -- HTTP --> umh-datasource
            umh-datasource --Plugin--> grafana
            factoryinsight <--RESP--> redis
            kafka-to-postgresql <--RESP--> redis
        end 


        subgraph Connectivity
            style Connectivity fill:#f4f4f4
            nodered["Node-RED"] 
            barcodereader
            sensorconnect

            click nodered "./microservices/core/node-red"
            click barcodereader "./microservices/community/barcodereader"
            click sensorconnect "./microservices/core/sensorconnect"

            nodered  <-- Kafka --> kafka
            
            barcodereader -- Kafka --> kafka
            sensorconnect -- Kafka --> kafka
        end

        subgraph Simulators
            style Simulators fill:#f4f4f4
            mqtt-simulator["IoT sensors simulator"]
            packml-simulator["PackML simulator"]
            opcua-simulator["OPC-UA simulator"]

            click mqtt-simulator "./microservices/community/mqtt-simulator"
            click packml-simulator "./microservices/community/packml-simulator"
            click opcua-simulator "./microservices/community/opcua-simulator"

            mqtt-simulator -- MQTT --> mqtt
            packml-simulator -- MQTT --> mqtt
            opcua-simulator -- OPC-UA --> nodered
        end
    end
    subgraph Datasources
        plc["PLCs"]
        other["Other systems on the shopfloor (MES, ERP, etc.)"]
        barcode["USB barcode reader"]
        ifm["IO-link sensor"]
        iot["IoT devices"]

        plc -- "Siemens S7, OPC-UA, Modbus, etc." --> nodered
        other -- " " ----> nodered
        ifm -- HTTP --> sensorconnect
        barcode -- USB --> barcodereader
        iot <-- MQTT --> mqtt

        %% at the end for styling purposes
        nodered <-- MQTT -->  mqtt
    end

     subgraph Data sinks
         umh-other["Other UMH instances"]
         other-systems["Other systems (cloud analytics, cold storage, BI tools, etc.)"]
         
         kafka <-- Kafka --> kafka-bridge
         kafka-bridge <-- Kafka ----> umh-other
         factoryinsight -- HTTP ----> other-systems
     end
{{</ mermaid >}}

## Simulators
The United Manufacturing Hub includes several simulators to generate data during development and testing.

### Microservices
- [iotsensorsmqtt](/docs/architecture/microservices/community/mqtt-simulator/) simulates data in three different MQTT topics, providing a simple way to test and visualize MQTT data streams.
- [packml-simulator](/docs/architecture/microservices/community/packml-simulator/) simulates a PackML machine which sends and receives MQTT messages
- [opcua-simulator](/docs/architecture/microservices/community/opcua-simulator/) simulates an OPC-UA server, which can then be used to test connectivity of OPC-UA clients and to generate sample data for OPC-UA clients

## Data connectivity microservices
The United Manufacturing Hub includes microservices that extract data from the shop floor and push it into the Unified Namespace. Additionally, you can deploy your own microservices or third-party solutions directly into the Kubernetes cluster using the [custom microservice feature](/docs/architecture/helm-chart/#custom-microservices-configuration). To learn more about third-party solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app)

### Microservices
- [sensorconnect](/docs/architecture/microservices/core/sensorconnect/) automatically reads out IO-Link Master and their connected sensors, and pushes the data to the message broker.
- [barcodereader](/docs/architecture/microservices/core/barcodereader/) connects to USB barcode reader devices and pushes the data to the message broker.
- [Node-RED](/docs/architecture/microservices/core/node-red/) is a versatile tool with many community plugins and allows access to machine PLCs or connections with other systems on the shopfloor. It plays an important role and is explained in the next section.

## Node-RED: connectivity & contextualization

Node-RED is not just a tool for connectivity, but also for stream processing and data contextualization. It is often used to extract data from the message broker, reformat the event, and push it back into a different topic, such as the [UMH datamodel](/docs/architecture/datamodel).

In addition to the built-in microservices, third-party contextualization solutions can be deployed similarly to [data connectivity microservices](#data-connectivity-microservices). For more information on these solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app/).
In addition to the built-in microservices, third-party contextualization solutions can be deployed similarly to [data connectivity microservices](#data-connectivity-microservices). For more information on these solutions, check out our extensive tutorials on our [learning hub](https://learn.umh.app/).

### Microservices
- [Node-RED](/docs/architecture/microservices/core/node-red/) is a programming tool that can wire together hardware devices, APIs, and online services.

## Unified Namespace

At the core of the United Manufacturing Hub lies the [Unified Namespace](/lesson/introduction-into-it-ot-unified-namespace/), which serves as the central source of truth for all events and messages occurring on your shop floor. The Unified Namespace is implemented using two message brokers: HiveMQ for [MQTT](https://learn.umh.app/lesson/introduction-into-it-ot-mqtt/) and [Apache Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/). MQTT is used to receive data from IoT devices on the shop floor because it excels at handling a large number of unreliable connections. On the other hand, Kafka is used to enable communication between the microservices, leveraging its large-scale data processing capabilities.

The data between both brokers is bridged automatically using the mqtt-to-kafka microservice, allowing you to send data to MQTT and process it reliably in Kafka.

If you're curious about the benefits of this dual approach to MQTT/Kafka, check out our blog article about [Tools & Techniques for Scalable Dataprocessing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/).

<!-- For more information on the Unified Namespace feature and how to use it, check out our documentation. -->

### Microservices
- [HiveMQ](/docs/architecture/microservices/core/mqtt-broker/) is an MQTT broker used for receiving data from IoT devices on the shop floor. It excels at handling large numbers of unreliable connections.
- [Apache Kafka](/docs/architecture/microservices/core/kafka-broker/) is a distributed streaming platform used for communication between microservices. It offers large-scale data processing capabilities.
- [mqtt-kafka-bridge](/docs/architecture/microservices/core/mqtt-kafka-bridge/) is a microservice that bridges messages between MQTT and Kafka, allowing you to send data to MQTT and process them reliably in Kafka.
- [kafka-bridge](/docs/architecture/microservices/core/kafka-bridge/) a microservice that bridges messages between multiple Kafka instances.
- [console](/docs/architecture/microservices/core/kafka-console/) is a web-based user interface for Kafka, which provides a graphical view of topics and messages.

## Historian / data storage and visualization

The United Manufacturing Hub stores events according to our [datamodel](/docs/architecture/datamodel/). These events are automatically stored in TimescaleDB, an open-source time-series SQL database. From there, you can access the stored data using Grafana, a visualization and analytics software. With Grafana, you can perform on-the-fly data analysis by executing simple min, max, and avg on tags, or extended KPI calculations such as OEE. These calculations can be selected in the umh-datasource microservice.

### Microservices
- [kafka-to-postgresql](/docs/architecture/microservices/core/kafka-to-postgresql/) stores data in selected topics from the Kafka broker in a PostgreSQL compatible database such as TimescaleDB.
- [TimescaleDB](/docs/architecture/microservices/core/database/), which is an open-source time-series SQL database 
- [factoryinsight](/docs/architecture/microservices/core/factoryinsight/) provides REST endpoints to fetch data and calculate KPIs
- [Grafana](/docs/architecture/microservices/core/grafana/) is a visualization and analytics software
- [umh-datasource](/docs/architecture/microservices/grafana-plugins/umh-datasource/) is a plugin providing access factoryinsight
- [redis](/docs/architecture/microservices/core/cache/) is an in-memory data structure store, used for cache.

## Custom Microservices

The Helm Chart allows you to add your own microservices or Docker containers to the United Manufacturing Hub. These can be used, for example, to connect with third-party systems or to analyze the data. Additionally, you can deploy any other third-party application as long as it is available as a Helm Chart, Kubernetes resource, or Docker Compose (which can be converted to Kubernetes resources).
