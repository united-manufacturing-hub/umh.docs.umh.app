---
title: UMH Lite
menuTitle: UMH Lite
content_type: feature
description: "Introducing UMH Lite - a new type of UMH installation.\n"
weight: 5000
---

If you are already using Unified Namespace, or have a Kafka / MQTT broker, you might want to try out the basic features of UMH. For this purpose, the UMH Lite installation is available.

If you want the full-featured UMH experience, we recommend installing the Classic version. This version provides a comprehensive suite of features, including analytics, data visualization, message brokers, alerting, and more. Below, you can see a comparison of the features between the two versions.

### UMH Classic vs UMH Lite

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

### Converting

To convert a UMH Lite instance to a UMH Classic instance:

1.  Go to the Management Console.
2.  Navigate to Component View.
3.  Select the instance from the list.
4.  Click on 'Instance Settings'.
5.  You will find an option to convert your instance to Classic.
