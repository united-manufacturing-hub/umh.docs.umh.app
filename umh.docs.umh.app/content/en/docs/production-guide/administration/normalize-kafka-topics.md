---
title: "Normalize Kafka Topics"
content_type: task
description: |
    This page describes how to reduce the amount of Kafka Topics in order to
    lower the overhead.
weight: 50
edition: community
---

<!-- overview -->

Kafka excels at processing a high volume of messages but can encounter difficulties
with excessive topics, which may lead to insufficient memory. The optimal Kafka
setup involves minimal topics, utilizing the
[event key](https://kafka.apache.org/intro#intro_concepts_and_terms) for logical
data segregation.

The diagram below illustrates the principle of combining multiple topics into a
single topic with different keys, simplifying topic management.

{{< mermaid >}}
graph LR

event1(Topic: umh.v1.acme.anytown.foo.bar<br>Value: 1)
event2(Topic: umh.v1.acme.anytown.foo.baz<br>Value: 2)
event3(Topic: umh.v1.acme.anytown<br>Value: 3)
event4(umh.v1.acme.anytown.frob<br>Value: 4)

event1 --> bridge
event2 --> bridge
event3 --> bridge
event4 --> bridge
bridge{{Topic merge point: 3}}

subgraph Topic: umh.v1.acme
gmsg1(Key: anytown.foo.bar<br>Value: 1)
gmsg2(Key: anytown.foo.baz<br>Value: 2)
gmsg3(Key: anytown<br>Value: 3)
gmsg4(Key: anytown.frob<br>Value: 4)
end

bridge --> gmsg1
bridge --> gmsg2
bridge --> gmsg3
bridge --> gmsg4

{{< /mermaid >}}

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

{{< notice note >}}
There are two configurations for the topic merge point: one in the Companion
configuration for Benthos data sources and another in the Helm chart for data bridges.
{{< /notice >}}

<!-- steps -->

## Data Sources

To adjust the topic merge point for data sources, modify
{{< resource type="configmap" name="management-companion" >}} configmap. This
can be easily done with the following command:

```bash
sudo $(which kubectl) edit configmap {{< resource type="configmap" name="management-companion" >}} -n {{< resource type="ns" name="management-companion" >}} --kubeconfig /etc/rancher/k3s/k3s.yaml
```

This command opens the current configuration in the default editor, allowing you
to set the `umh_merge_point` to your preferred value:

```yaml
data:
  umh_merge_point: <numeric-value>
```

Ensure the value is at least 3 and update the `lastUpdated` field to the current
Unix timestamp to trigger the automatic refresh of existing data sources.

## Data Bridge

For data bridges, the merge point is defined individually in the Helm chart values
for each bridge. Update the Helm chart installation with the new `topicMergePoint`
value for each bridge. See the [Helm chart documentation](/docs/reference/helm-chart/#bridges)
for more details.

Setting the `topicMergePoint` to -1 disables the merge feature.

<!-- Optional section, but recommended; write the problem/question in H3 -->
<!-- ## {{% heading "troubleshooting" %}} -->

<!-- Optional section; add links to information related to this topic. -->
<!-- ## {{% heading "whatsnext" %}} -->
