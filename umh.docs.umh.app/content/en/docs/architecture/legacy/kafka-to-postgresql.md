---
title: "Kafka to Postgresql"
content_type: concept
# description: |
#     Add a description of the concept here.
weight: 10
---

<!-- overview -->

Kafka-to-postgresql is a microservice responsible for consuming kafka messages
and inserting the payload into a Postgresql database. Take a look at the
[Datamodel](/docs/architecture/datamodel/) to see how the data is structured.

{{% notice note %}}
This microservice requires that the Kafka Topic `umh.v1.kafka.newTopic` exits. This will happen automatically from version 0.9.12.
{{% /notice %}}

<!-- body -->

## {{% heading "howitworks" %}}

By default, kafka-to-postgresql sets up two Kafka consumers, one for the
[High Integrity](#high-integrity) topics and one for the
[High Throughput](#high-throughput) topics.

The graphic below shows the program flow of the microservice.

![Kafka-to-postgres-flow](/images/kafka-to-postgresql-flow.jpg)

### High integrity

The High integrity topics are forwarded to the database in a synchronous way.
This means that the microservice will wait for the database to respond with a
non error message before committing the message to the Kafka broker.
This way, the message is garanteed to be inserted into the database, even though
it might take a while.

Most of the topics are forwarded in this mode.

The picture below shows the program flow of the high integrity mode.

![high-integrity-data-flow](/images/HICountFlow.jpg)

### High throughput

The High throughput topics are forwarded to the database in an asynchronous way.
This means that the microservice will not wait for the database to respond with
a non error message before committing the message to the Kafka broker.
This way, the message is not garanteed to be inserted into the database, but
the microservice will try to insert the message into the database as soon as
possible. This mode is used for the topics that are expected to have a high
throughput.

The topics that are forwarded in this mode are [processValue](/docs/architecture/datamodel/messages/processvalue/),
[processValueString](/docs/architecture/datamodel/messages/processvaluestring/)
and all the raw topics.

<!-- Optional section; add links to information related to this topic. -->

## {{% heading "whatsnext" %}}

- Read the [Kafka to Postgresql](/docs/reference/microservices/kafka-to-postgresql/) reference documentation
  to learn more about the technical details of the Kafka to Postgresql microservice.
