---
title: benthos-umh
menuTitle: benthos-umh
description: A version of benthos providing seamless OPC-UA integration with the Unified Namespace
weight: 3000
draft: false
---

[Benthos](https://www.benthos.dev/docs/about) is a stream processing tool that is designed to make common data engineering tasks such as transformations, integrations, and multiplexing easy to perform and manage. It uses declarative, unit-testable configuration, allowing users to easily adapt their data pipelines as requirements change. Benthos is able to connect to a wide range of sources and sinks, and has a wide range of processors and a “lit mapping language” built-in. 

The [benthos-umh](https://github.com/united-manufacturing-hub/benthos-umh), a version of Benthos maintained by the United Manufacturing Hub (UMH), is a Docker container designed to facilitate smooth OPC-UA integration with [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/) (MQTT/Kafka).

## When should I use it?
OPC UA is a communications protocol coming from the OT industry, so the integration with IT tools is necessary to stream data from an OPC UA server. The benthos-umh realizes a simple integration; especially, it is suitable for the integration with the United Manufacturing Hub.

## What can I do with it?
The benthos-umh offers the following features:

- Simple deployment in Docker, docker-compose, and Kubernetes.
- Connects to an OPC-UA server, browses selected nodes, and forwards all sub-nodes in 1-second intervals.
- Supports a wide range of outputs, from the Unified Namespace (MQTT and Kafka) to HTTP, AMQP, Redis, NATS, SQL, MongoDB, Cassandra, or AWS S3. Check out the official [benthos output library](https://www.benthos.dev/docs/components/outputs/about/).
- Fully customizable messages using the benthos processor library: implement Report-by-Exception (RBE) / message deduplication, modify payloads and add timestamps using bloblang, apply protobuf (and therefore SparkplugB), and explore many more options.
- Integrates with modern IT landscape, providing metrics, logging, tracing, versionable configuration, and more.
- Entirely open-source (Apache 2.0) and free-to-use.


## How can I use it?


## What are the limitations?


## Where to get more information?
- Visit our [Github repository](https://github.com/united-manufacturing-hub/benthos-umh).