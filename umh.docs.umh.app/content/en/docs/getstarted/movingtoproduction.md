+++
title = "5. Moving to Production"
menuTitle = "5. Moving to Production"
description = "Move the United Manufacturing Hub to production."
weight = 5000
+++

  The next big step is to use the UMH on a virtual machine or an edge device in
  your production and connect your production assets. However, we understand that
  you might want to understand a little bit more about the United Manufacturing
  Hub first. So, you can either read more about our product, deep-dive into your 
  local installation, or continue with the deployment in production.
  You can use the guide below to get started with the UMH in production 
  and connect a few machines to a single instance.

## Check out our community

  We are quite active on GitHub and Discord. Feel free to join, introduce
  yourself and share your best-practices and experiences.

- [Give us a star on GitHub](https://github.com/united-manufacturing-hub/united-manufacturing-hub)
- [Join our Discord channel](https://discord.gg/F9mqkZnm9d)
- [Take a look at the Community Repository](https://github.com/united-manufacturing-hub/community-repo)

## Learn more about the United Manufacturing Hub

If you like reading more about its features and architecture, check out the
following chapters:
- [Features](/docs/features/) to understand the capabilities of the United
   Manufacturing Hub and learn how to use them
- [Architecture](/docs/architecture/) to learn what is behind the United 
   Manufacturing Hub and how everything works together

If reading is not your thing, you can always ... 

## Set up a first instance and connect to a few machines

  If you want to get a first impression of the UMH in a production environment,
  you can connect to a few machines on your shopfloor and read their data
  through a single UMH instance. To enable a UMH instance to read machine data,
  it must be run on an edge device such as an industrial PC, or a virtual
  machine (VM). The exact process depends on your specific
  hardware but here is a general guide:

1. Choose between and edge device or an IPC: Your UMH instance has to reach
   your machines over the network. You might
   need to ask your IT if this is possible and maybe change some network 
   settings. Using an edge device might be easier since it can be physically
   placed in the
   same network as the machine, a VM could be trickier because the server might
   not have direct network access. On the other hand, setting up a VM is
   simpler, without the need of new hardware, if you have access to a server.

2. Find out what protocol your machines use: You need this information
   to access their data in Node-RED. Most likely, it's OPC UA. Here is a 
   [list](https://umh.docs.umh.app/docs/features/data-connectivity-node-red/)
   of the supported protocols and how to connect them to Node-RED.

3. Once you have decided if a Vm or an Edge device suits your situation better,
   you can start the installation process by clicking on the **+ Add Device**
   button in the general overview of all instances inside the Management 
   Console.

4. Select the right panel **Production Deployment - Edge, Cloud & VM** and 
   click on the blue **continue** button in the right bottom corner.

5. Chose the **VM** or **Edge Deice** panel, depending on your choice and 
   click on **continue** again. Follow the instruction to set up your instance.
   
6. When you are done and the instance is running, remember to place it in
   the same network as your machines. The same applies for the device
   that is running the Management Console. 

7. Click on the tile of the new instance inside the overview
   and open the Node-RED popup. Use this
   [list](https://umh.docs.umh.app/docs/features/data-connectivity-node-red/#what-can-i-do-with-it)
   to learn how to connect your machines to Node-RED.
   If the provided help is not sufficient, you can ask for help on our Discord.

8. Use Node-RED to generate a new dataflow by using your machines´ data as input.
   You can use this collected data in other tools, for example to build a
   dashboard in Grafana. 


## Play around with it locally

If you want to try around locally, we recommend you try out the following topics.

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
