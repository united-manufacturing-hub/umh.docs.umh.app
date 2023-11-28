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

The Data Infrastructure is the heart of the United Manufacturing Hub, orchestrating
the interconnection of data sources, storage, monitoring, and analysis solutions.
It comprises three key components:

- **Data Connectivity**: This layer is essential for linking various data sources
  to the UMH, enabling seamless integration and data flow.
- **Unified Namespace (UNS)**: The UNS plays a pivotal role in sharing and translating
  data within UMH. It connects every layer of the automation pyramid to the UNS,
  integrating additional data sources beyond the traditional automation pyramid.
  This ensures that data is not only shared but also standardized into a cohesive
  model.
- **Historian**: A critical component for data storage, the Historian facilitates
  both real-time and historical analytics. It is based on TimescaleDB, which combines
  PostgreSQL with time-series data storage capabilities. All data in the UNS is
  automatically stored in TimescaleDB and made accessible through Grafana for
  advanced analytics and visualization.

The UMH Data Infrastructure leverages Industrial IoT to expand the ISA95 Automation
Pyramid, enabling high-speed data processing using systems like Kafka. It enhances
system availability through Kubernetes and simplifies maintenance with Docker and
Prometheus. Additionally, it facilitates the use of AI, predictive maintenance,
and digital twin technologies

## Expandability

The United Manufacturing Hub is architecturally designed for high expandability,
offering the capability to integrate custom microservices or Docker containers
into the UMH environment. This feature enables users to establish connections
with third-party systems or to implement specialized data analysis tools.
Furthermore, the platform supports the deployment of any third-party application
available as a Helm Chart, Kubernetes resource, or Docker Compose configuration,
which can be seamlessly converted to Kubernetes resources. This flexibility ensures
that UMH can be tailored to meet diverse and evolving industrial needs.
