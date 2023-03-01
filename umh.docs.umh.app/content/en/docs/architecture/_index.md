+++
title = "Architecture"
menuTitle = "Architecture"
description = "A detailed view of the architecture of the UMH stack."
weight = 2000
+++

The United Manufacturing Hub at its core is a [Helm Chart for Kubernetes]() consisting of several microservices and open source 3rd party applications, such as Node-RED and Grafana. This Helm Chart can then be deployed either locally on your computer for testing, on edge devices, on virtual machines or in managed Kubernetes offerings. In large-scale deployments, you find typically a combination out of all these deployment options.

Let's start with the core and then work our way from top to bottom.
{{< mermaid theme="neutral" >}}
flowchart 
    subgraph Unified Namespace
        kafka["Apache Kafka"]
        mqtt["HiveMQ"]
        console["Console"]
        kafka-bridge

        mqtt-kafka-bridge["mqtt-kafka-bridge"]
        mqtt <-- MQTT --> mqtt-kafka-bridge <-- Kafka --> kafka
        kafka -- Kafka --> console
    end

    subgraph Historian
        kafka-to-postgresql
        timescaledb[("TimescaleDB")]
        factoryinsight
        umh-datasource
        grafana["Grafana"]

        kafka -- Kafka ---> kafka-to-postgresql
        kafka-to-postgresql -- SQL --> timescaledb
        timescaledb -- SQL --> factoryinsight
        factoryinsight -- HTTP --> umh-datasource
        umh-datasource --Plugin--> grafana
    end 

     subgraph Data sinks
         umh-other["Other UMH instances"]
         erp["ERP, MES, or other systems"]
         
         kafka <-- Kafka --> kafka-bridge
         kafka-bridge <-- Kafka ----> umh-other
         factoryinsight <-- HTTP ----> erp
     end

    subgraph Connectivity
        nodered["Node-RED"] 
        barcodereader
        sensorconnect

        nodered  <-- Kafka --> kafka
        
        barcodereader -- Kafka --> kafka
        sensorconnect -- Kafka --> kafka
    end

    subgraph Datasources
        plc["PLCs"]
        other["Other equipment on the shopfloor"]
        barcode["USB barcode reader"]
        ifm["IO-link sensor"]
        iot["IoT devices"]

        plc -- "Siemens S7, OPC-UA, Modbus, etc." --> nodered
        other -- " " --> nodered
        ifm -- HTTP --> sensorconnect
        barcode -- USB --> barcodereader
        iot <-- MQTT --> mqtt

        %% at the end for styling purposes
        nodered <-- MQTT -->  mqtt
    end

{{</ mermaid >}}
<!-- %% %%{ init: { 'theme': 'base', 'themeVariables': { 'fontFamily': 'arial','primaryColor': '#ffffff','primaryTextColor': '#000000','primaryBorderColor': '#000000','lineColor': '#f4f4f4','secondaryColor': '#f4f4f4','tertiaryColor': '#aaaaaa','noteBkgColor': '#ffa62b','noteTextColor': 'ffffff'}}}%%-->

## Unified Namespace
At the core / in the middle of the United Manufacturing Hub is the [Unified Namespace](), which acts as the central source of truth for all messages  / events happening on your shopfloor.
It is implemented using two message brokers, HiveMQ for MQTT and Apache Kafka. MQTT is used to receive data from IoT devices on the shop floor because it excels at handling large numbers of unreliable connections, while Kafka is used to communicate between the microservices to utilize its large scale data processing. 

The data between both brokers are bridged automatically using the [mqtt-to-kafka]() microservice, allowing you to send data to MQTT and process them reliably in Kafka.

Want to understand the why for this dual-approach MQTT / Kafka? [Check out our blog article about Tools & Techniques for Scalable Dataprocessing in Industrial IoT]()

Check out [Unified Namespace feature]() to get more information on what it is and how to use it

### Microservices
- [HiveMQ]()
- [Apache Kafka]()
- [mqtt-kafka-bridge](), to bridgeb etween MQTT and Kafka
- [kafka-bridge](), to bridge to different brokers
- [console](), to view data ..

## Simulators

### Microservices
- [mqtt simulator]()
- PackML
- - ...

## Data connectivity microservices

The United Manufacturing Hub includes microservices to extract data from the shop floor and push it into the Unified Namespace.

3rd party connectivity solutions such as your own microservices, can either be deployed using the [custom microservice feature]() or deployed directly into the Kubernetes cluster. Check out our extensive tutorials for 3rd party solutions on our [learning hub]().

### Microservices
- [sensorconnect](), which automatically reads out IO-Link Master and their connected sensors, and pushes the data to the message broker
- [barcodereader](), which connects to USB barcode reader devices and pushes the data to the message broker

## Node-RED: connectivity & contextualization

Intro

3rd party contextualization solutions such as your own microservices can be deployed similarly to [data connectivity microservices](). Check out our extensive tutorials for 3rd party solutions on our [learning hub]().

### Microservices
- [Node-RED]()

## Historian / data storage and visualization

Check out [Historian feature]() to get more information on what it is and how to use it

### Microservices
- [kafka-to-postgresql]()
- [TimescaleDB]()
- [factoryinsight]()
- [Grafana]()
- [umh-datasource]()


