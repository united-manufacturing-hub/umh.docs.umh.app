---
title: "Data Bridge"
content_type: microservices
description: |
    The technical documentation of the data-bridge microservice,
    which transfers data between two Kafka or MQTT brokers, tranforming
    the data following the UNS data model.
weight: 0
---

<!-- overview -->
Data-bridge is a microservice specifically tailored to adhere to the
[UNS](https://learn.umh.app/lesson/navigating-data-flow-understanding-data-models/)
data model. It consumes topics from a message broker, translates them to
the proper format and publishes them to the other message broker.

<!-- body -->

## {{% heading "howitworks" %}}

Data-bridge connects to the source broker, that can be either Kafka or MQTT,
and subscribes to the topics specified in the configuration. It then processes
the messages, and publishes them to the destination broker, that can be either
Kafka or MQTT.

In the case where the destination broker is Kafka, messages from multiple topics
can be merged into a single topic, making use of the message key to identify
the source topic.
For example, subscribing to a topic using a wildcard, such as
`umh.v1.acme.anytown..*`, and a merge point of 4, will result in
messages from the topics `umh.v1.acme.anytown.foo.bar`,
`umh.v1.acme.anytown.foo.baz`, `umh.v1.acme.anytown` and `umh.v1.acme.anytown.frob`
being merged into a single topic, `umh.v1.acme.anytown`, with the message key
being the missing part of the topic name, in this case `foo.bar`, `foo.baz`, etc.

Here is a diagram showing the flow of messages:

{{< mermaid >}}
graph LR
source((MQTT or Kafka broker))
subgraph Messages
direction TB
msg1(topic: umh/v1/acme/anytown/foo/bar<br>value: 1)
msg2(topic: umh/v1/acme/anytown/foo/baz<br>value: 2)
msg3(topic: umh/v1/acme/anytown<br>value: 3)
msg4(topic: umh/v1/acme/anytown/frob<br>value: 4)
end
source --> msg1
source --> msg2
source --> msg3
source --> msg4

msg1 --> bridge
msg2 --> bridge
msg3 --> bridge
msg4 --> bridge
bridge{{data-bridge<br>subscribes to: umh/v1/acme/anytown/#<br>topic merge point: 4}}

subgraph Grouped messages
direction TB
gmsg1(topic: umh.v1.acme.anytown<br>key: foo.bar<br>value: 1)
gmsg2(topic: umh.v1.acme.anytown<br>key: foo.baz<br>value: 2)
gmsg3(topic: umh.v1.acme.anytown<br>value: 3)
gmsg4(topic: umh.v1.acme.anytown<br>key: frob<br>value: 4)
end

bridge --> gmsg1
bridge --> gmsg2
bridge --> gmsg3
bridge --> gmsg4

dest((Kafka broker))
gmsg1 --> dest
gmsg2 --> dest
gmsg3 --> dest
gmsg4 --> dest
{{< /mermaid >}}

{{% notice note %}}
The value of the message is not changed, only the topic and key are modified.
{{% /notice %}}

Another important feature is that it is possible to configure multiple data
bridges, each with its own source and destination brokers, and each with its
own set of topics to subscribe to and merge point.

The brokers can be local or remote, and, in case of MQTT, they can be secured
using TLS.

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="databridge" >}}`
- Secret: `{{< resource type="secret" name="databridge-mqtt" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure the environment variables directly, as they are
set by the Helm chart. If you need to change them, you can do so by editing the
values in the Helm chart.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name        | Description                                                                                                                                                   | Type   | Allowed values          | Default                             |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ | ----------------------- | ----------------------------------- |
| `BROKER_A`           | The address of the source broker.                                                                                                                             | string | Any                     | ""                                  |
| `BROKER_B`           | The address of the destination broker.                                                                                                                        | string | Any                     | ""                                  |
| `LOGGING_LEVEL`      | The logging level to use.                                                                                                                                     | string | PRODUCTION, DEVELOPMENT | PRODUCTION                          |
| `MESSAGE_LRU_SIZE`   | The size of the LRU cache used to avoid message looping. Only used with MQTT brokers                                                                          | int    | Any                     | 1000000                             |
| `MICROSERVICE_NAME`  | Name of the microservice. Used for tracing.                                                                                                                   | string | Any                     | united-manufacturing-hub-databridge |
| `MQTT_ENABLE_TLS`    | Whether to enable TLS for the MQTT connection.                                                                                                                | bool   | `true`, `false`         | false                               |
| `MQTT_PASSWORD`      | The password to use for the MQTT connection.                                                                                                                  | string | Any                     | ""                                  |
| `PARTITIONS`         | The number of partitions to use for the destination topic. Only used if the destination broker is Kafka.                                                      | int    | Greater than 0          | 6                                   |
| `POD_NAME`           | Name of the pod. Used for tracing.                                                                                                                            | string | Any                     | united-manufacturing-hub-databridge |
| `REPLICATION_FACTOR` | The replication factor to use for the destination topic. Only used if the destination broker is Kafka.                                                        | int    | Odd integer             | 3                                   |
| `SERIAL_NUMBER`      | Serial number of the cluster. Used for tracing.                                                                                                               | string | Any                     | default                             |
| `SPLIT`              | The nth part of the topic to use as the message key. If the topic is `umh/v1/acme/anytown/foo/bar`, and `SPLIT` is 4, then the message key will be `foo.bar`  | int    | Greater than 3          | -1                                  |
| `TOPIC`              | The topic to subscribe to. Can be in either MQTT or Kafka form. Wildcards (`#` for MQTT, `.*` for Kafka) are allowed in order to subscribe to multiple topics | string | Any                     | ""                                  |
{{< /table >}}
