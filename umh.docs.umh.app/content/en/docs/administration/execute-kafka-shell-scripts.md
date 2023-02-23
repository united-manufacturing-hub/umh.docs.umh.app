---
title: "Execute Kafka Shell Scripts"
content_type: task
description: |
  This page describes how to execute Kafka shell scripts.
weight: 50
---

<!-- overview -->

When working with Kafka, you may need to execute shell scripts to perform
administrative tasks. This page describes how to execute Kafka shell scripts.

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Open a shell in the Kafka container

1. From the Pod section in UMHLens, click on **{{% resource type="pod" name="kafka" %}}**
   to open the details page.
2. {{< include "pod-shell.md" >}}
3. Navigate to the Kafka bin directory:

   ```bash
   cd /opt/bitnami/kafka/bin
   ```

4. Execute any Kafka shell scripts. For example, to list all topics:

   ```bash
   ./kafka-topics.sh --list --zookeeper zookeeper:2181
   ```

5. To exit the shell:

   ```bash
   exit
   ```

## {{% heading "whatsnext" %}}

- See [Access Kafka console](/docs/administration/access-kafka-console/).
- See [Access Kafka outside the cluster](/docs/administration/access-kafka-outside-cluster/).
