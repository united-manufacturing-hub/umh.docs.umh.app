---
title: "Management Console"
menuTitle: "Management Console"
description: |
  
weight: 1000
---

The Management Console is pivotal in configuring, managing, and monitoring the
United Manufacturing Hub. It comprises a web application, a backend API, a
management companion, and key storage, all designed to ensure secure and
efficient operation.

{{< mermaid theme="neutral" >}}
graph TB
  27["`**Device & Container Infrastructure**
  Oversees automated, streamlined installation of key software and operating systems`"]
  style 27 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  50["`**Data Infrastructure**
  Integrates every ISA-95 standard layer with the Unified Namespace, adding data sources beyond typical automation pyramid bounds`"]
  style 50 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  1["`fa:fa-user **IT/OT Professional**
  Manages and monitors the United Manufacturing Hub`"]
  style 1 fill:#dddddd,stroke:#9a9a9a,color:#000000

  subgraph 16 [Management Console]
    style 16 fill:#ffffff,stroke:#47a0b5,color:#47a0b5

    17["`**Web Application**
    Client-side application for the Management Console`"]
    style 17 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    18["`**Backend**
    Public API for the Management Console`"]
    style 18 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    19["`**Management Companion**
    Agent deployed on the infrastructure to enable interaction`"]
    style 19 fill:#aaaaaa,stroke:#47a0b5,color:#000000
    20["`**Key Storage**
    Stores private keys`"]
    style 20 fill:#aaaaaa,stroke:#47a0b5,color:#000000
  end

  50-. Is deployed on .->27
  19-. Manages & monitors .->27
  19-. Manages & monitors .->50
  17<-. Exchange E2E
  encrypted messages
  using the private key .->18
  18-. Fetches encrypted private key .->20
  18-. Exchange E2E
  encrypted messages
  using the private key .->19
  1-. Interacts with the
      entire infrastructure .->17
  27-. Deploys .->19
{{< /mermaid >}}

## Web Application

The client-side Web Application enables users to register, add, and manage
instances, and monitor the infrastructure within the United Manufacturing Hub. All
communications between the Web Application and the user's devices are encrypted
using the user's private key, ensuring complete confidentiality from the backend.

## Management Companion

Deployed on each UMH instance, the Management Companion acts as an agent
responsible for decrypting messages from the Backend and executing requested
actions. Responses are encrypted using the companion's private key, maintaining
a secure and opaque channel to the Backend.

## Backend

The Backend is the public API for the Management Console. It functions as a bridge
between the Web Application and the Management Companion. Its primary role is to
verify user permissions for accessing UMH instances. Importantly, the backend
does not have access to the contents of the messages exchanged between the Web
Application and the Management Companion, ensuring that communication remains
opaque and secure.
