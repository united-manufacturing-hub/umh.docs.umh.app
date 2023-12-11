---
title: Introduction & Asset Management
content_type: task
description: Introduction to IIoT Connectivity and Asset Management in UMH.
weight: 1000
edition: community
draft: false
---


In IIoT, connectivity involves extracting and contextualizing data from various systems into the Unified Namespace. There's no universal solution; a blend of different tools is required, tailored to specific technical and organizational challenges.
The goal with asset management is that you can add everything with an IP on your shopfloor. So, if the connection gets worse or drops entirely, you are notified. This is required for any data extraction step using benthos and the Management Console. In the future, we will also recommend adding an asset before working with it in Node-RED.

## When should I use it?
Integrating diverse techniques presents challenges, involving non-standard connections, specific communication protocols, and more. Additionally, mismatches between IT and OT technology may arise. Detailed examples of these challenges are provided below. Asset Management in UMH is designed to address these issues.


### Technical Challenges Examples:

- **Uncommon Protocols:** Handling rare communication protocols.
- **Non-Ethernet Protocols:** Dealing with non-standard connections, like a 4-20 mA sensor or a USB-connected barcode reader.
- **Monotonous Integrations:** Numerous data sources in the same format can lead to tedious, error-prone setup processes. Templating is a key solution here.
- **High Variance in Data Sources:** For instance, different QA stations in production lines might use slightly varied REST API versions, necessitating extensive customization.

### Organizational Challenges Examples:

- **IT and OT Tool Mismatch:** Advanced IT tools like Spark/Flink may be challenging for OT personnel who have crucial domain knowledge.
- **OT Tools’ Limitations:** Traditional OT tools often struggle in modern IT environments, lacking features like Docker compatibility, monitoring, automated backups, or high availability.

## What can I do with it?

You can manage connectivity effectively; for example, you can create, configure, and delete connections using tools in a comfortable way. 


## How can I use it?

To address these challenges, UMH recommends a combination of tools for effective connectivity:

### 1. Node-RED

- **Description:** A leading open-source tool for IIoT connectivity, widely accepted alongside Kepware.
- **Advantages:** Vast global community, extensive connectors, Docker compatibility, user-friendly for OT personnel.
- **Disadvantages:** Reliability may vary.
- **UMH Recommendation:** Primarily for prototyping and integrating parts of the shopfloor that demand high levels of customization and domain knowledge.

### 2. benthos-umh

- **Description:** UMH's custom extension of the Benthos project, enhanced with an OPC UA plugin.
- **Advantages:** Ideal for reliably moving medium-sized data volumes, ease of deployment and management.
- **Disadvantages:** Technical expertise required, longer development cycles.
- **UMH Recommendation:** For scenarios involving the extraction of large data volumes in a standardized format.

### 3. Other Tools

- **Recommendation:** Incorporate existing connectivity solutions or third-party tools, such as Kepware, barcode readers, and sensor connection systems.

This approach ensures a flexible, adaptable IIoT environment that addresses both technical and organizational needs effectively.

## What are the limitations? 
- Each tool has drawbacks, as discussed in the previous section.


## Where to get more information?
- Learn more about Node-RED and the United Manufacturing Hub by following our [Get started guide](/docs/getstarted/).
- Learn [how to connect devices using Node-RED with United Manufacturing Hub](/docs/features/connectivity/node-red/).
- Learn [how to retrofit legacy machines with ifm IO-link master and sensorconnect](/docs/features/connectivity/additionalconnectivity/ifm-retrofitting/).
- Learn [how to retrofit with USB barcodereader](/docs/features/connectivity/additionalconnectivity/barcodereader-retrofitting/).