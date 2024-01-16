---
title: "Data Infrastructure"
content_type: concept
description: |
    Concepts related to the security of the Data Infrastructure.
weight: 10
draft: true
---

<!-- overview -->
Security within the Data Infrastructure is a broad topic, as there are many levels
of that need to be considered. For simplicity, we will just consider the security
regarding the connection between the components of the Data Infrastructure.

<!-- body -->
## Benthos UMH

The security of the connection between Benthos UMH and the OPC UA server is
handled by the OPC UA server. Benthos can be configured to use authentication,
but if the OPC UA server settings are weak, then the connection is still
vulnerable.

## Kafka

The Kafka broker is exposed to the instance network, but not to the public
internet.

## MQTT

The MQTT broker is exposed to the instance network, but not to the public
internet. It is also possible to configure password authentication and TLS
encryption.

## TimescaleDB

The database is exposed to the instance network, but not to the public internet.
The database uses username and password authentication, with different users for
different databases.
