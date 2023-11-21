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

![Communication between the Management Console and the instance](/images/getstarted/managingTheSystem/simpleInfrastructureDiagram.png?width=80%)

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

## Manage the Instance

Before you begin, ensure that you are connected to the same network as the instance
for accessing the various services and features discussed below.

While a graphical user interface for managing the instance is not yet available,
you can still manage it via the command line.

### Access the Command Line

To access the shell of your device, you can either interact directly with the
device or use SSH. It's important to note that you need access to the root user
to execute the following commands.

{{% notice note %}}
If you don't have root user access, you can still execute the commands by
prefixing them with `sudo`. However, you'll need to specify the full path to the
binary. For example, use `/usr/local/bin/kubectl get pods` instead of just `kubectl
get pods`.
{{% /notice %}}

### Interact with the Instance

After accessing the shell, you can interact with the instance using the `kubectl`
command. Start by setting this specific environment variable:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

Then, to get a list of pods, run:

```bash
kubectl get pods -n united-manufacturing-hub
```

For a comprehensive list of commands, refer to the
[Kubernetes documentation](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands).

{{% notice note %}}
Always specify the namespace when running a command by adding `-n united-manufacturing-hub`.
{{% /notice %}}

#### Access Node-RED

Node-RED, a visual tool for wiring the Internet of Things, is utilized by the
United Manufacturing Hub for creating data flows. To access Node-RED, simply
open the following URL in your browser:

```text
http://<instance-ip-address>:1880/nodered
```

#### Access Grafana

Grafana, an open-source analytics and monitoring solution, is used by UMH for
dashboard displays. Retrieve the credentials with these commands:

```bash
kubectl get secret grafana-secret -n united-manufacturing-hub -o jsonpath="{.data.adminuser}" | base64 --decode; echo
kubectl get secret grafana-secret -n united-manufacturing-hub -o jsonpath="{.data.adminpassword}" | base64 --decode; echo
```

Then, access Grafana here:

```text
http://<instance-ip-address>:8080
```

Use the retrieved credentials to log in.

#### Access the RedPanda Console

The RedPanda Console, used for managing the message broker, can be accessed at:

```text
http://<instance-ip-address>:8090
```

#### Interact with the Database

UMH uses TimescaleDB for database needs. Open a `psql` session with this command:

```bash
kubectl exec -it $(kubectl get pods -n united-manufacturing-hub -l app.kubernetes.io/component=timescaledb -o jsonpath="{.items[0].metadata.name}") -n united-manufacturing-hub -- psql -U postgres
```

Run SQL queries as needed. For an overview of the database schema, refer to the
[Data Model](/docs/architecture/datamodel/database) documentation.

#### Connect MQTT to MQTT Explorer

MQTT Explorer is a comprehensive MQTT client that provides a structured overview
of your MQTT topics and makes working with devices/services on your broker
easier.

Connect MQTT Explorer to the MQTT broker using the instance's IP address and port
`1883`.

## Troubleshooting

### cluster error for the kubeconfig

### kubectl not found

### user permissions

## What's next?

TODO
