---
title: UMH Lite
menuTitle: UMH Lite
content_type: feature
description: "Introducing UMH Lite - a new type of UMH installation.\n"
weight: 5000
---

If you are already using Unified Namespace, or have a Kafka / MQTT broker, you might want to try out the basic features of UMH. For this purpose, the UMH Lite installation is available.

## When should I use it?

If you want the full-featured UMH experience, we recommend installing the Classic version. This version provides a comprehensive suite of features, including analytics, data visualization, message brokers, alerting, and more. Below, you can see a comparison of the features between the two versions.

## What can I do with it?

### Differences between UMH Classic and Lite

<style>
 .feature-table {
    .center {
        text-align: center;
    }
    .bold {
        font-weight: bold;
    }
    .indented {
        padding-left: 2rem;
    }
 }
</style>

<table class="feature-table">
    <thead>
        <tr>
            <th>Feature</th>
            <th class="center">Classic</th>
            <th class="center">Lite</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="bold">Connectivity</td>
            <td class="center"></td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">OPC UA</td>
            <td class="center">✓</td>
            <td class="center">✓</td>
        </tr>
        <tr>
            <td class="indented">Node-RED</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="bold">Data Infrastructure</td>
            <td class="center"></td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">Historian</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">Analytics</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">Data Visualization</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">UNS (Kafka and MQTT)</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">Alerting</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">UMH Data Model v1</td>
            <td class="center">✓</td>
            <td class="center">✓</td>
        </tr>
        <tr>
            <td class="indented">Tag Browser for your UNS</td>
            <td class="center">✓</td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="bold">Device & Container Infrastructure</td>
            <td class="center"></td>
            <td class="center"></td>
        </tr>
        <tr>
            <td class="indented">Network Monitoring</td>
            <td class="center">✓</td>
            <td class="center">✓</td>
        </tr>
    </tbody>
</table>

### Connect devices and add protocol converters

You can connect external devices like a PLC with an OPC UA server to a running UMH Lite instance and contextualize the data from it with a [protocol converter](https://umh.docs.umh.app/docs/features/connectivity/benthos-umh/).
For contextualization, you have to use the [UMH Data Model v1](https://umh.docs.umh.app/docs/datamodel/messages/).

### Send data to your own infrastructure

All the data that your instance is gathering is sent to your own data infrastructure. You can configure a target MQTT broker in the instance settings by clicking on it in the Management Console.

### Monitor your network health

By using the UMH Lite in conjunction with the Management Console, you can spot errors in the network. If a connection is faulty, the Management Console will mark it.

### Convert to UMH Classic

Should you find the UMH Lite insufficient and require the features offered by UMH Classic, you can upgrade through the Management Console. To convert a UMH Lite instance to a UMH Classic instance:

1.  Go to the Management Console.
2.  Navigate to Component View.
3.  Select the instance from the list.
4.  Click on 'Instance Settings'.
5.  You will find an option to convert your instance to Classic.

This change will preserve the configurations of your devices and protocol converters: Their data continues to be forwarded to your initial MQTT broker, while also becoming accessible within your new Unified Namespace and database.

Any protocol converters introduced post-upgrade will also support the original MQTT broker as an additional output. You can manually remove the original MQTT broker as an output after the upgrade. Once removed, data will no longer be forwarded to the initial MQTT broker.

## How can I use it?

To add a new UMH Lite instance, simply follow the regular [installation process](https://umh.docs.umh.app/docs/getstarted/installation/) and select UMH Lite instead of UMH Classic. You can follow the next steps in the linked guide to learn how to connect devices and add a protocol converter.

## What are the limitations?

The UMH Lite is a very basic version and only offers you the gathering and contextualization of your data as well as the monitoring of the network. Other features like a historian, data visualization, and a Unified Namespace are only available by using the UMH Classic.

Additionally, converting to a UMH Classic requires an SSH connection, similar to what is needed during the initial installation.

## Where to get more information?

-   Learn how to [install UMH Lite](https://umh.docs.umh.app/docs/getstarted/installation/).
-   Learn how to [gather your data](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/).
-   Read about our [Data Model](https://umh.docs.umh.app/docs/datamodel/messages/) to keep your data organized and contextualized.
