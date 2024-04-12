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

Your infrastructure might consist of multiple UMH instances. This feature offers an intuitive
view for monitoring all connected network devices and external services across your network
of instances. By providing real-time status updates, it enables efficient troubleshooting and
detection of issues within the infrastructure.

For example, monitoring the status is crucial when extracting data from a device via a protocol
converter. If a device goes offline, the **Network View** makes it easy to identify the issue
without needing to investigate the protocol converter itself.

## What can I do with it?

The network view presents a graph where instances are typically grouped according to the
ISA-95 schema, forming a tree-like structure. This allows for easy visualization of the
entire network and its relationships. However, Instances that do not fit into the ISA-95
schema, lacking a defined location, appear separately at the root of the graph, without
any parent nodes, as they cannot be classified anywhere. Additionally, if multiple
enterprises exist, there can be potentially multiple tree-like structures within the graph.

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
   a slight darker gray background. Network devices can only be children of UMH instances, and
   include general information, such as the device's connection type, IP address and port, health
   state and latency. In the image above, several network devices can be seen, such as
   `Siemens S7-1200 0x5965`, which is a child of the `Instance1` instance.

{{% notice note %}}
Currently, the network view is read-only and purely for visualization purposes. However, in the
future, we plan to add more features.
{{% /notice %}}

## How can I use it?

Configure your UMH instances and add network devices to them, as described throughout the
[get started](/docs/getstarted) guide. Then, come back to the Network View to monitor all
your instances, their relationships, status and more at a glance.

## Where to get more information?

- Learn more about the Unified Namespace in [our guide](/docs/features/datainfrastructure/unified-namespace/).
