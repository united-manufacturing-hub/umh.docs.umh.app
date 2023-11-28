---
title: Introduction & Asset Management
content_type: task
description: Introduction to IIoT Connectivity and Asset Management in UMH.
weight: 1000
edition: community
---

## Introduction to IIoT Connectivity and Asset Management in UMH

In IIoT, connectivity involves extracting and contextualizing data from various systems into the Unified Namespace. There's no universal solution; a blend of different tools is required, tailored to specific technical and organizational challenges.

## Technical Challenges Examples:

- **Uncommon Protocols:** Handling rare communication protocols.
- **Non-Ethernet Protocols:** Dealing with non-standard connections, like a 4-20 mA sensor or a USB-connected barcode reader.
- **Monotonous Integrations:** Numerous data sources in the same format can lead to tedious, error-prone setup processes. Templating is a key solution here.
- **High Variance in Data Sources:** For instance, different QA stations in production lines might use slightly varied REST API versions, necessitating extensive customization.

## Organizational Challenges Examples:

- **IT and OT Tool Mismatch:** Advanced IT tools like Spark/Flink may be challenging for OT personnel who have crucial domain knowledge.
- **OT Tools’ Limitations:** Traditional OT tools often struggle in modern IT environments, lacking features like Docker compatibility, monitoring, automated backups, or high availability.

## Recommended Tools in UMH

To address these challenges, UMH recommends a combination of tools for effective connectivity:

### 1. Node-RED

- **Description:** A leading open-source tool for IIoT connectivity, widely accepted alongside Kepware.
- **Advantages:** Vast global community, extensive connectors, Docker compatibility, user-friendly for OT personnel.
- **Disadvantages:** Reliability may vary.
- **UMH Recommendation:** Primarily for prototyping and integrating parts of the shopfloor that demand high levels of customization and domain knowledge.

[Learn more about Node-RED's role in the industrial IoT](/docs/getstarted/noderedarticle/)

### 2. benthos-umh

- **Description:** UMH's custom extension of the Benthos project, enhanced with an OPC UA plugin.
- **Advantages:** Ideal for reliably moving medium-sized data volumes, ease of deployment and management.
- **Disadvantages:** Technical expertise required, longer development cycles.
- **UMH Recommendation:** For scenarios involving the extraction of large data volumes in a standardized format.

### 3. Other Tools

- **Recommendation:** Incorporate existing connectivity solutions or third-party tools, such as Kepware, barcode readers, and sensor connection systems.

This approach ensures a flexible, adaptable IIoT environment that addresses both technical and organizational needs effectively.

## Asset Management

Describe asset management functionality, describe the current best practice of having Excel sheets, and if something goes down, one is not notified immediately. The goal with asset management is that you can add everything with an IP on your shopfloor. So if the connection gets worse or drops entirely, you are notified. This is required for any data extraction step using benthos and the Management Console. In the future, we will also recommend adding an asset before working with it in Node-RED.
