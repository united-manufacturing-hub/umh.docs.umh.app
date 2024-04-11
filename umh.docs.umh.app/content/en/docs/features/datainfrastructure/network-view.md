---
title: Network Monitoring
menuTitle: Network Monitoring
description: |
  Monitor all instances within the Unified Namespace at a glance.
weight: 2000
draft: true
---

The Network Monitoring feature of the United Manufacturing Hub visualizes the instance's
network within the Unified Namespace.

## When should I use it?

Your infrastructure might consist of multiple UMH instances. This feature offers
an intuitive view for monitoring the entire network of all instances and their
network devices, allowing you to detect any issues within the infrastructure.

## What can I do with it?

The network view offers a graph where instances are usally grouped by the ISA-95 schema,
these instances form a tree-like structure, which there can be multiple of, making it
easy to visualize the whole network and the relationships between them. There can be
instances that don't fit into the ISA-95 schema, these appear at the root of the graph,
without any parent nodes.

![Network view](/images/features/network-view/networkViewDemo.png?width=80%)

It might seem like there's a lot going on in the image above, but we can break it down into 3
different types of nodes:

1. **Location**: These are the nodes to visualize the ISA-95 schema and are colored with a
   black background with a slight gray border. In the image above, one can be seen with the
   label `demo-microchip-enterprise`, representing the enterprise level.
2. **UMH Instance**: These are the nodes that represent a UMH instance and are colored with
   a light gray background. In the image above, several instances can be seen, such as `Cologne`,
   living at the **site** level, as well as non ISA-95 instances like `Instance1`, which doesn't
   fit into any location level.
3. **Network Device**: These are the nodes that represent a network device and are colored with
   a slight darker gray background. Network devices can only be descendants of UMH instances, and
   include general information, such as the device's connection type, IP address and port, health
   state and latency. In the image above, several network devices can be seen, such as
   `Siemens S7-1200 0x5965`, which is a descendant of the `Instance1` instance.

{{% notice note %}}
Currently, the network view is read-only and purely for visualization purposes. However, in the
future, we plan to add more features.
{{% /notice %}}

## How can I use it?

Configure your UMH instances, add network devices to them, interact with tools provided by UMH
(Node-RED, etc.), as described throughout the [get started](/docs/getstarted) guide. Then, come back
to the Network View to monitor all your instances, their relationships, status and more at a glance.

## Where to get more information?

- Learn more about the Unified Namespace in [our guide](/docs/features/datainfrastructure/unified-namespace/).
