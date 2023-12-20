---
title: Monitoring & Management
menuTitle: Monitoring & Management
description: Monitor and manage both the Data and the Device & Container
  Infrastructures using the Management Console.
weight: 2000
edition: community
draft: false
---

The Management Console supports you to monitor and manage the Data Infrastructure and the Device & Container
Infrastructure.

## When should I use it?

Once initial deployment of the United Manufacturing Hub is completed, you can monitor and manage it using the Management Console. If you have not deployed yet, navigate to the [Get Started!](/docs/getstarted/installation/) guide.


## What can I do with it?

You can monitor the statuses of the following items using the Management Console:
- **Modules**: A Module refer to a grouped set of related Kubernetes components like pods, statefulsets, and services. It provides a way to monitor and manage these components as a single unit.
- **System**:
    - Resource Utilization: CPU, RAM, and DISK usages
    - OS information: the used operating system, kernel version, and instruction set architecture
- **Data source**: the rate of Kafka/TimescaleDB messages per second, the health of data sources
- **Data connection**: the health of connections
- **Kubernetes**: the number of error events and the deployed management companion's and UMH's versions

In addtion, you can check the topic structure used by data sources and the corresponding payloads.

Moreover, you can create a new connection and initilize the created connection to deploy a data source.
<!--Add delete and edit if these functionalities are available-->

## How can I use it?

After logging in, the **INSTANCE DASHBOARD** page shows the **Overview** tab. You can click and open each status on this tab.

![](/images/features/monitor-management/modules.png?width=80%)

The **Data Connections** tab shows the status of connections. Moreover, you can add new connections on this tab. 

![](/images/features/monitor-management/data-connections.png?width=80%)

You can initialize created connections on the **Data Sources** tab. Additionaly, you can check the health of connection and data sources.

![](/images/features/monitor-management/data-sources.png?width=80%)

The **DATA DASHBOAD** displays the topic structure and publisher & subscriber information.

![](/images/features/monitor-management/data-dashboard.png?width=80%)

## What are the limitations?
Presently, removing a UMH instance from the Management Console is not supported. After overwriting an instance, the old one will display an offline status.


## Where to get more information?
- The [Get Started!](/docs/getstarted/installation/) guide assists you to set up
  the United Manufacturing Hub.
- Learn more about the [Data Infrastructure](/docs/architecture/data-infrastructure/).
- Take a look at the [Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/).