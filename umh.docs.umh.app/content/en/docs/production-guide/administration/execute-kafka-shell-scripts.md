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

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Open a shell in the Kafka container

1. From the instance's shell, execute this command:

   <!-- tested in e2e #1343 -->
   ```bash
   sudo $(which kubectl) exec -it {{% resource type="pod" name="kafka" %}} -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -- /bin/sh
   ```

2. Navigate to the Kafka bin directory:

   ```bash
   cd /opt/bitnami/kafka/bin
   ```

3. Execute any Kafka shell scripts. For example, to list all topics:

   ```bash
   ./kafka-topics.sh --list --zookeeper zookeeper:2181
   ```

4. Exit the shell by typing `exit`.

## {{% heading "whatsnext" %}}

- See [Access Kafka outside the cluster](/docs/production-guide/administration/access-kafka-outside-cluster/).
