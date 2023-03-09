---
title: "Kafka Broker"
content_type: microservices
description: |
    The technical documentation of the kafka-broker microservice,
    which handles the communication between the microservices and the Kafka broker.
weight: 0
---

<!-- overview -->

The Kafka broker in the United Manufacturing Hub is a [Apache Kafka](https://kafka.apache.org/),
that with the help of [Zookeeper](https://zookeeper.apache.org/) manages the
topics and the partitions. It's a core component of the stack and is used to
communicate between the different microservices.

## {{% heading "howitworks" %}}

Kafka is an event streaming platform that is used to store and process
messages. It's a distributed system that is made up of a cluster of
brokers. Each broker is responsible for a subset of the data. The brokers
communicate with each other to keep the data in sync. The brokers are
also responsible for the replication of the data. The replication factor
is the number of copies of each partition that are kept on different
brokers.

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="kafkabroker" >}}`
- Service:
  - Internal ClusterIP: `{{< resource type="service" name="kafkabroker" >}}` at
    port 9092
  - Internal ClusterIP (headless): `{{< resource type="service" name="kafkabroker-headless" >}}` at
    port 9092
  - External LoadBalancer: `{{< resource type="service" name="kafkabroker-ext" >}}` at
    port 9094
- ConfigMap: `{{< resource type="configmap" name="kafkabroker-scripts" >}}`
- Secret: `{{< resource type="secret" name="kafkabroker" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="kafkabroker" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure the Kafka broker manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `kafka` section of the Helm
chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                                        | Description                                                                                              | Type   | Allowed values  | Default                                                |
| ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------- | ------ | --------------- | ------------------------------------------------------ |
| `ALLOW_PLAINTEXT_LISTENER`                           | Allow to use the PLAINTEXT listener                                                                      | string | Any             | yes                                                    |
| `BITNAMI_DEBUG`                                      | Specify if debug values should be set                                                                    | `bool` | `true`, `false` | `false`                                                |
| `KAFKA_CFG_ALLOW_EVERYONE_IF_NO_ACL_FOUND`           | Allow resources with no associated ACL                                                                   | `bool` | `true`, `false` | `true`                                                 |
| `KAFKA_CFG_AUTHORIZER_CLASS_NAME`                    | Class name of the Authorizer                                                                             | string | Any             | ""                                                     |
| `KAFKA_CFG_AUTO_CREATE_TOPICS_ENABLE`                | Whether topics get generated automatically                                                               | `bool` | `true`, `false` | `true`                                                 |
| `KAFKA_CFG_DEFAULT_REPLICATION_FACTOR`               | Default replication factors for automatically created topics                                             | int    | Any             | 1                                                      |
| `KAFKA_CFG_DELETE_TOPIC_ENABLE`                      | Whether topic deletion is enabled                                                                        | `bool` | `true`, `false` | `false`                                                |
| `KAFKA_CFG_LISTENERS`                                | The address(es) the socket server listens on                                                             | string | Any             | INTERNAL://:9093,CLIENT://:9092,EXTERNAL://:9094       |
| `KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP`           | The protocol to listener mapping                                                                         | string | Any             | INTERNAL:PLAINTEXT,CLIENT:PLAINTEXT,EXTERNAL:PLAINTEXT |
| `KAFKA_CFG_LOG_DIRS`                                 | A comma separated list of directories in which kafka's log data is kept                                  | string | Any             | /bitnami/kafka/data                                    |
| `KAFKA_CFG_LOG_FLUSH_INTERVAL_MESSAGES`              | The number of messages to accept before forcing a flush of data to disk                                  | int    | Any             | 10000                                                  |
| `KAFKA_CFG_LOG_FLUSH_INTERVAL_MS`                    | The maximum amount of time a message can sit in a log before a forced flush                              | int    | Any             | 1000                                                   |
| `KAFKA_CFG_LOG_RETENTION_BYTES`                      | A size-based retention policy for logs                                                                   | int    | Any             | 26214400                                               |
| `KAFKA_CFG_LOG_RETENTION_CHECK_INTERVAL_MS`          | The interval at which log segments are checked to see if they can be deleted                             | int    | Any             | 300000                                                 |
| `KAFKA_CFG_LOG_RETENTION_HOURS`                      | The minimum age of a log file to be eligible for deletion due to age                                     | int    | Any             | 168                                                    |
| `KAFKA_CFG_LOG_SEGMENT_BYTES`                        | The maximum size of a log segment file. When this size is reached a new log segment will be created      | int    | Any             | 10485760                                               |
| `KAFKA_CFG_MESSAGE_MAX_BYTES`                        | The largest record batch size allowed by Kafka                                                           | int    | Any             | 1000012                                                |
| `KAFKA_CFG_NUM_IO_THREADS`                           | The number of threads doing disk I/O                                                                     | int    | Any             | 8                                                      |
| `KAFKA_CFG_NUM_NETWORK_THREADS`                      | The number of threads handling network requests                                                          | int    | Any             | 3                                                      |
| `KAFKA_CFG_NUM_PARTITIONS`                           | The default number of log partitions per topic                                                           | int    | Any             | 6                                                      |
| `KAFKA_CFG_NUM_RECOVERY_THREADS_PER_DATA_DIR`        | The number of threads per data directory to be used for log recovery at startup and flushing at shutdown | int    | Any             | 1                                                      |
| `KAFKA_CFG_OFFSETS_TOPIC_REPLICATION_FACTOR`         | The replication factor for the offsets topic                                                             | int    | Any             | 1                                                      |
| `KAFKA_CFG_SOCKET_RECEIVE_BUFFER_BYTES`              | The receive buffer (SO_RCVBUF) used by the socket server                                                 | int    | Any             | 102400                                                 |
| `KAFKA_CFG_SOCKET_REQUEST_MAX_BYTES`                 | The maximum size of a request that the socket server will accept (protection against OOM)                | int    | Any             | 104857600                                              |
| `KAFKA_CFG_SOCKET_SEND_BUFFER_BYTES`                 | The send buffer (SO_SNDBUF) used by the socket server                                                    | int    | Any             | 102400                                                 |
| `KAFKA_CFG_SUPER_USERS`                              | List of super users                                                                                      | string | Any             | User:admin                                             |
| `KAFKA_CFG_TRANSACTION_STATE_LOG_MIN_ISR`            | Overridden min.insync.replicas config for the transaction topic                                          | int    | Any             | 1                                                      |
| `KAFKA_CFG_TRANSACTION_STATE_LOG_REPLICATION_FACTOR` | The replication factor for the transaction topic                                                         | int    | Any             | 1                                                      |
| `KAFKA_CFG_ZOOKEEPER_CONNECT`                        | URL of ZooKeeper                                                                                         | string | Any             | united-manufacturing-hub-zookeeper                     |
| `KAFKA_CFG_ZOOKEEPER_CONNECTION_TIMEOUT_MS`          | Timeout in ms for connecting to ZooKeeper                                                                | int    | Any             | 6000                                                   |
| `KAFKA_HEAP_OPTS`                                    | Kafka Java Heap size                                                                                     | string | Any             | -Xmx2048m -Xms2048m                                    |
| `KAFKA_INTER_BROKER_LISTENER_NAME`                   | The listener that the brokers should communicate on                                                      | string | Any             | INTERNAL                                               |
| `KAFKA_LOG_DIR`                                      | Mount path of the Kafka logs volume                                                                      | string | Any             | /opt/bitnami/kafka/logs                                |
| `KAFKA_VOLUME_DIR`                                   | Mount path of the Kafka data volume                                                                      | string | Any             | /bitnami/kafka                                         |
| `KAFKA_ZOOKEEPER_PROTOCOL`                           | The protocol to use with ZooKeeper                                                                       | string | Any             | PLAINTEXT                                              |
{{< /table >}}
