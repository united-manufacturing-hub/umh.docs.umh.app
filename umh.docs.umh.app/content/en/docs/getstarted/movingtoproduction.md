---
title: 5. Moving to Production
menuTitle: 5. Moving to Production
description: Move the United Manufacturing Hub to production.
weight: 8000
draft: true
wip: true
---

This chapter involves deploying the United Manufacturing Hub (UMH) on a virtual machine or an edge device, allowing you to connect with your production assets. However, we recognize the importance of familiarizing yourself with the United Manufacturing Hub beforehand. Feel free to delve deeper into our product, explore the specifics of local installation, or proceed with the production deployment. The guide below will kickstart your UMH journey in a production setting.

## Check out our community

We are quite active on GitHub and Discord.

Feel free to join our [community](https://www.umh.app/community), introduce yourself and share your best-practices and experiences.

## Learn more about the United Manufacturing Hub

If you like reading more about its features and architecture, check out the
following chapters:

- [Features](/docs/features/) to understand the capabilities of the United
  Manufacturing Hub and learn how to use them.
- [Architecture](/docs/architecture/) to learn what is behind the United
  Manufacturing Hub and how everything works together.

Ready to transition to production? Continue reading to discover how to install UMH and seamlessly connect multiple machines to your instance.

## Set up your first instance and connect to a few machines

If you want to get a first impression of the UMH in a production environment, connecting to machines on your shop floor, follow these steps:

#### 1. Choose an Edge Device or VM (Recommended: VM)

Before starting the installation process, decide whether to use virtual machine (VM), or a generic server or edge device. For ease of setup, we recommend using a VM. Ensure that the selected device has network access to the machines.

#### 2. Select Machines with OPC UA for Testing

For testing purposes, it's recommended to use machines with OPC UA. If your machines use other protocols, consider Node-RED as an alternative for data connection. Check the [list of supported protocols](https://umh.docs.umh.app/docs/features/data-connectivity-node-red/) and how to connect them to Node-RED.

#### 3. Installation Process

The installation is well documented in the [first chapter](/docs/getstarted/installation/#installation-steps). But here's a quick overview:

- Click on the **+ Add Instance** button in the instance dashboard of the Management Console, redirecting you to the installation process page.

- Select the **Install UMH Only** option, redirecting you to the install command generation page.

- Finally, follow the provided instructions to set up your instance. If everything went well, there should be a button at the bottom right corner
  of the page, redirecting you back to the instance dashboard.

#### 4. Network Configuration

Once your UMH instance is up and running, ensure it is placed in the same network as your machines. Additionally, verify that the device running the Management Console is also within the same network.

While basic management and monitoring with the **Management Console** don't necessarily demand extensive network configuration, it's important to note that various open-source tools integrated into UMH do.
Therefore, to take full advantage of the UMH, ensure that you can reach the IP of the server to access Grafana or Node-RED, and that the connection is not blocked by a firewall.

#### 5. Configure Connections and Data Sources

The connections and data sources setup is documented in detail in the [third chapter](/docs/getstarted/dataacquisitionmanipulation). But here's a quick overview for OPC UA:

- Assuming you have a selected instance running, navigate to the **Data Connections** tab and click on the **+ Add Connection** button.
- Click on the **OPC UA Server** option, redirecting you to the OPC UA connection setup page.
- Follow the provided instructions, test the connection, and if succesful you'll be able to deploy it.
- Once successfully deployed and back to the Data Connections tab, you'll see the new connection under **Uninitialized Connections**.
- To initialize it, navigate to **Data Sources** > **Uninitialized Connections**, redirecting you to the data source setup page.
- Again, follow the provided instructions. If you're having trouble, refer to the more detailed [guide](/docs/getstarted/dataacquisitionmanipulation/#initialize-the-connection).
- Once successfully deployed and back to the Data Sources tab, you'll see it under **Data Sources**.
- Congratulations! Your OPC UA connection and data source are now configured, and your UMH instance is ready to gather valuable insights from your machines.

#### 6. Alternative Protocols

The previous step exclusively covered OPC UA. If your machines use protocols other than OPC UA, we recommend exploring Node-RED as a versatile solution for connecting and gathering data.

You can use it to generate a new dataflow by using your machine's data as input. This collected data can even be used in other tools, such as building a dashboard in Grafana.

If you encounter any issues, feel free to ask for help on our Discord channel.

## Play around with it locally

If you want to get a first impression of the UMH in a local environment, we recommend checking out the following topics:

### Grafana Canvas

If you're interested in creating visually appealing Grafana dashboards, you
might want to try Grafana-Canvas. In our previous
[blog article](https://www.umh.app/post/building-shopfloor-dashboards-with-the-united-manufacturing-hub-and-grafana-canvas),
we explained why Grafana-Canvas is a valuable addition to your standard
Grafana dashboard. If you'd like to learn how to build one, check out our
[tutorial](https://learn.umh.app/guides/advanced/data-visualization/canvas-grafana/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPCanvas.png?width=70%)

### OPC/UA-Simulator

If you want to get a good overview of how the OPC/UA protocol works and how to
connect it to the UMH, the OPC/UA-simulator is a useful tool. Detailed
instructions can be found in
[this guide](https://learn.umh.app/course/creating-a-node-red-flow-with-simulated-opc-ua-data/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPopcua.png?width=70%)

### PackML-Simulator

For those looking to get started with PackML, the PackML Simulator is another
helpful simulator. Check out our
[tutorial](https://learn.umh.app/course/creating-a-node-red-flow-with-packml/)
on how to create a Node-RED flow with PackML data.

![Untitled](/images/getstarted/movingToProduction/getStartedMTPPackMLStateModel.png)

### Benthos

Benthos is a highly scalable data manipulation and IT connection tool.
If you're interested in learning more about it, check out our
[tutorial](https://learn.umh.app/course/using-benthos-with-the-united-manufacturing-hub/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPBenthos.png)

### Kepware

At times, you may need to connect different, older protocols. In such cases,
KepwareServerEx can help bridge the gap between these older protocols and the
UMH. If you're interested in learning more, check out our
[tutorial](https://learn.umh.app/course/connecting-kepware-with-the-opc-ua-simulator/).

## Deployment to production

**Ready to go to production? Go install it!**

Follow our step-by-step
[tutorial](/docs/production-guide/installation/installation-guide-flatcar)
on how to install the UMH on an edge device or an virtual machine using
Flatcar. We've also written a blog article explaining why we use Flatcar
as the operating system for the industrial IoT, which you can find
[here](https://learn.umh.app/blog/flatcar-as-the-operating-system-of-the-industrial-iot/).

Make sure to check out our
[advanced production guides](https://umh.docs.umh.app/docs/production-guide/),
which include detailed instructions on how to secure your setup and how to
best integrate with your infrastructure.
