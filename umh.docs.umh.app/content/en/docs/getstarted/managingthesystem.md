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

The Management Companion, serving as an agent within each UMH instance, provides
a secure link to the Management Console. It enables comprehensive and secure
monitoring and management of the UMH, ensuring system health and streamlined
configuration, all while acting as a vigilant watchdog over system components and
connected devices.

The diagram below illustrates the communication flow between the Management
Console and the instance:

![Communication between the Management Console and the instance](/images/getstarted/managingTheSystem/simpleInfrastructureDiagram.png?width=80%)

## Overview of Your Instances

![Instance overview](/images/getstarted/managingTheSystem/instanceOverview.png?width=80%)

On the left side of the Management Console, you can view the list of your
instances. If you have just installed the UMH, you should see only one instance
in the list.

The status of your instance is indicated by color: green means everything is
working properly, while yellow indicates that there may be a connection issue.

The **Messages Received** statistic shows the number of messages received by you
from the instance since you opened the Management Console. It is usually a good
indicator of the health of the connection to the Companion.
If the number is not increasing for 10 seconds, the instance is considered
disconnected.

## Monitoring the Instance's Status

From the instance dashboard, in the overview tab, you can view the status of
your instance. There are multiple interfaces that display the status of each
component of the system.

### Modules

A _Module_ refers to a group of workloads in the United Manufacturing Hub
responsible for specific tasks. For example, the _Historian & Analytics_ module
represents the microservices, storage, and connections that are responsible for
storing and analyzing data.

In the **Modules** tab, you can view the status of each module. If a module is
not healthy, it means that one or more of its components are not functioning
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

To log in as the root user, after logging as a normal user, run:

```bash
sudo su
```

If you don't have root user access, you can still execute the commands by
prefixing them with `sudo`. However, you'll need to specify the full path to the
binary, which you can find with the `which` command.

For example, type `which kubectl` to get the path to the `kubectl` binary, then
run the command with `sudo` and the full path.

Besides, you must then add the `--kubeconfig /etc/rancher/k3s/k3s.yaml` flag to
specify the configuration file path.

This is what a command would look like:

```bash
sudo /usr/local/bin/kubectl get pods --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub
```

{{% notice warning %}}
It is important to note that you will need to use `sudo` and the full path to
the binary for all commands in this chapter.
{{% /notice %}}

### Interact with the Instance

After accessing the shell as the root user, you can interact with the instance
using the `kubectl` command. Start by setting this specific environment variable:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

{{% notice note %}}
You can skip this step by adding the `--kubeconfig /etc/rancher/k3s/k3s.yaml`
flag. All the commands in this chapter will use this flag.
{{% /notice %}}

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
United Manufacturing Hub for creating data flows.

To access Node-RED, simply open the following URL in your browser:

```text
http://<instance-ip-address>:1880/nodered
```

#### Access Grafana

Grafana, an open-source analytics and monitoring solution, is used by UMH for
dashboard displays.

After logging in as the root user with `sudo su`, retrieve the credentials with
these commands:

```bash
kubectl get secret grafana-secret --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -o jsonpath="{.data.adminuser}" | base64 --decode; echo
kubectl get secret grafana-secret --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -o jsonpath="{.data.adminpassword}" | base64 --decode; echo
```

Then, access Grafana here:

```text
http://<instance-ip-address>:8080
```

Use the retrieved credentials to log in.

#### Access the RedPanda Console

The RedPanda Console, used for managing the Kafka broker, can be accessed at:

```text
http://<instance-ip-address>:8090
```

#### Interact with the Database

UMH uses TimescaleDB for database needs.

After logging in as the root user, open a `psql` session with this command:

```bash
kubectl exec -it $(kubectl get pods --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -l app.kubernetes.io/component=timescaledb -o jsonpath="{.items[0].metadata.name}") --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -- psql -U postgres
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

### Error: `You must be logged in to the server` while using the `kubectl` Command

If you encounter the error below while using the `kubectl` command:

```text
E1121 13:05:52.772843  218533 memcache.go:265] couldn't get current server API group list: the server has asked for the client to provide credentials
error: You must be logged in to the server (the server has asked for the client to provide credentials)
```

This issue can be resolved by setting the `KUBECONFIG` environment variable. Run
the following command:

```bash
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```

Alternatively, use the `--kubeconfig` flag to specify the configuration file path:

```bash
kubectl --kubeconfig /etc/rancher/k3s/k3s.yaml get pods -n united-manufacturing-hub
```

### "Permission Denied" Error with `kubectl` Command

Encountering the error below while using the `kubectl` command:

```text
error: error loading config file "/etc/rancher/k3s/k3s.yaml": open /etc/rancher/k3s/k3s.yaml: permission denied
```

Indicates the need for root access. Run the command with `sudo`, or log in as
the root user.

### `kubectl: command not found` error

If you encounter the error below while using the `kubectl` command:

```text
kubectl: command not found
```

The solution is to use the full path to the `kubectl` binary. You can do this by
prefixing the command with `/usr/local/bin/` or by adding it to your `PATH`
environment variable:

```bash
/usr/local/bin/kubectl get pods -n united-manufacturing-hub

# or

export PATH=$PATH:/usr/local/bin
```

## What's next?

Now that you have learned how to monitor, manage and configure your UMH instance
with the Management Console, you can start creating your first data flow. To
learn how to do this, proceed to the [Data Acquisition and Manipulation](/docs/getstarted/dataacquisitionmanipulation)
chapter.
