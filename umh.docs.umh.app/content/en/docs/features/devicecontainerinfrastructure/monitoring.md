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

Once initial deployment of the United Manufacturing Hub is completed, you can monitor and manage it using the Management Console. If you have not deployed yet, navigate to [Provisioning](/docs/features/devicecontainerinfrastructure/provisioning) page.


## What can I do with it?

You can monitor the statuses of the following items using the Management Console:
- Statuses of Modules, a grouped set of related Kubernetes components.
- System status like CPU and RAM usage.
- Data status, for example, the current rate of Kafka messages per second. 
- Data connection statuses measures the current latency.
- Kubernetes statuses shows error events.
- The current topic structure used by data sources and the corresponding payloads.

Also, you can create a new connection and initilize the created connection to deploy a data source.
<!--Add delete and edit if these functionalities are available-->

## How can I use it?

After logging in, the **INSTANCE DASHBOARD** page shows the **Overview** tab. You can click and open each status on this tab.

![](/images/features/monitor-management/modules.png?width=80%)

The **Data Connections** tab shows the status of connections based on the latency. Moreover, you can add new connections on this tab. 

![](/images/features/monitor-management/data-connections.png?width=80%)

You can initialize created connections on the **Data Sources** tab.

![](/images/features/monitor-management/data-sources.png?width=80%)

The **DATA DASHBOAD** displays the topic structure and publisher & subscriber information.

![](/images/features/monitor-management/data-dashboard.png?width=80%)

## What are the limitations?



## Where to get more information?
- Our [Provisioning](/docs/features/devicecontainerinfrastructure/provisioning) guide assists you to complete initial deployment of the UMH.
- Learn more about the [Data Infrastructure](/docs/architecture/data-infrastructure/).
- Take a look at the [Device & Container Infrastructure](/docs/architecture/device--container-infrastructure/).