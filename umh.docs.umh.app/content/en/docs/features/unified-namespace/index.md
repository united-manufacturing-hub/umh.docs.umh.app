+++
title = "Unified Namespace / Message Broker"
menuTitle = "Unified Namespace / Message Broker"
description = "Exchange events and messages across all your shopfloor equipment, IT / OT systems such as ERP or MES and microservices."
weight = 1
+++

Unified Namespace is a event-driven architecture that allows for seamless communication between nodes in a network. It operates on the principle that all data, regardless of whether there is an immediate consumer, should be published and made available for consumption. This means that any node in the network can work as either a producer or a consumer, depending on the needs of the system at any given time.

More information can be found in our [Learning Hub on the topic of Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/)

## When should I use it?

## How can I use it?

## What are the limitations?

- Messages are only bridged between MQTT and Kafka if they fulfill the following requirements:
    - payload is a valid JSON OR message is send to the `ia/raw` topic
    - only send to topics matching the [allowed topics in the UMH datamodel](/docs/architecture/datamodel/messages/), independent on what is configured in the environment variables (will be changed soon)
- Messages from MQTT to Kafka will be published under a different topic:
    - Spaces will be removed
    - `/` characters will be replaced with a `.`
    - and vice versa
- By default, there will be no Authorization and Authentication on the MQTT broker. [You need to enable authentication and authorization yourself](/docs/production-guide/security/).
- The MQTT broker is not exposed externally by default. [You need to enable external MQTT access first](/docs/production-guide/administration/access-mqtt-outside-cluster/)

## Where to get more information?
- For more information about the involved microservices, please take a look at our [architecture](/docs/architecture/)
- For more information about [MQTT](/lesson/introduction-into-it-ot-mqtt/), [Kafka](https://learn.umh.app/lesson/introduction-into-it-ot-kafka/), or the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/) visit the Learning Hub 
- For more information about the reasons to use MQTT and Kafka, please take a look at our blog article [Tools & Techniques for scalable data processing in Industrial IoT](https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/)
