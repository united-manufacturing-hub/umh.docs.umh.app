---
title: "Kafka to Postgresql V2"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

The Kafka to PostgreSQL v2 microservice plays a crucial role in consuming and
translating Kafka messages for storage in a PostgreSQL database. It aligns with
the specifications outlined in the [Data Model v2](/docs/architecture/datamodel/v2).

<!-- body -->

## {{% heading "howitworks" %}}

Utilizing Data Model v2, Kafka to PostgreSQL v2 is specifically configured to
process messages from topics beginning with `umh.v1.`. Each new topic undergoes
validation against Data Model v2 before message consumption begins. This ensures
adherence to the defined data structure and standards.

Message payloads are scrutinized for structural validity prior to database insertion.
Messages with invalid payloads are systematically rejected to maintain data integrity.

The microservice then evaluates the payload to determine the appropriate table
for insertion within the PostgreSQL database. The decision is based on the data
type of the payload field, adhering to the following rules:

- Numeric data types are directed to the `tag` table.
- String data types are directed to the `tag_string` table.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Kafka to Postgresql v2](/docs/reference/microservices/kafka-to-postgresql-v2/)
  reference documentation to learn more about the technical details of the
  Kafka to Postgresql v2 microservice.
