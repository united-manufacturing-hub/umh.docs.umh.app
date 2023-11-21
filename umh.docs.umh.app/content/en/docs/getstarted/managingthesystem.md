---
title: 2. Managing the System
menuTitle: 2. Managing the System
description: Learn how to manage your UMH instance with the Management Console.
weight: 2000
---

In this chapter, you will learn how to monitor, manage and configure your UMH
instance with the Management Console.

At this stage, you should have already installed the UMH on your device. If you
have not done so, please follow the steps in the [Installation](/docs/getstarted/installation)
chapter first.

## A Few Words About the Communication

Now that you have connected a UMH instance to the Management Console, you might
be curious about how the Management Console communicates with the instance.

The Management Companion is a microservice that runs in conjunction with the UMH.
It plays a crucial role in linking the instance to the Management Console. This
includes gathering the status of the device and the various components within
the system.

The diagram below illustrates the communication flow between the Management
Console and the instance:

![Communication between the Management Console and the instance](/images/getstarted/managingTheSystem/simpleInfrastructureDiagram.png)

## Overview of Your Instances

On the left side of the Management Console, you can view the list of your
instances. If you have just installed the UMH, you should see only one instance
in the list.

The status of your instance is indicated by color: green means everything is
working properly, while yellow indicates that there may be an issue.

The **Messages Received** statistic shows the number of messages received by you
from the instance since you opened the Management Console. It is usually a good
indicator of the health of the Companion and the latency of the connection between
you and the instance.

## Monitoring the Instance's Status

From the instance dashboard, in the overview tab, you can view the status of
your instance. There are multiple interfaces that display the status of each
component of the system.

### Modules

A _Module_ refers to a group of workloads in the United Manufacturing Hub
responsible for specific tasks. For example, the _Data Source_ module collects
data from various sources and is composed of multiple microservices.

In the **Modules** tab, you can view the status of each module. If a module is
not healthy, it means that one or more of its microservices are not functioning
properly.

### System

In the **System** tab, you can view the resource usage of your device, as well
as some system's information.

If there is an overload on the device, you can view it here. An overloaded device
is unable to handle the workload, and you should consider upgrading the device.

### Data

In the **Data** tab, you can see an overview of the data infrastructure, including
the number of messages going through the message broker, those stored in the
database, and messages received by each data source.

### Connection

In the **Connection** tab, you can view the status of all the data source connections
configured in the system. A non-healthy connection indicates that the device and
the data source are unable to communicate.

### Kubernetes

In the **Kubernetes** tab, you can check for any error events in the Kubernetes
cluster. Any errors suggest that the cluster is not operating correctly.

Additionally, this tab displays the version of the United Manufacturing Hub and
the Management Companion currently installed on your device.

## What's next?

TODO
