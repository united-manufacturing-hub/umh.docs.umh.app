+++
title = "Layered Scaling"
menuTitle = "Layered Scaling"
description = "Efficiently scale your United Manufacturing Hub deployment across edge devices and servers using Layered Scaling."
weight = 3
+++

Additional points:
- Explain plant-centric infrastructure and how it relates to the UMH design architecture. See also https://learn.umh.app/blog/tools-techniques-for-scalable-data-processing-in-industrial-iot/
- Minimal architecture: just one Helm Chart on an on-premise server. Advantage: easy maintenance. 
  Disadvantage (see also further below): latency, network dependency, message throughput, server can be hard to reach 
  from outside (e.g., viewing the dashboards from HQ)
- Standard architecture: one on-premise server and then edge devices in the factory running a minimized instance 
  (e.g., with ifm retrofitting feature enabled, but historian and analytics disabled)
- IoT architecture: standard architecture, but additionally a lot of IoT devices are connected via MQTT. 
  Using MQTT makes especially sense when handling a large amount of unreliable connections (AGVs, Wi-Fi, devices being 
  turned on and off repeatedly, smaller devices sensing very few data-points like a scale sending every minute a value, etc.).
- Full-scale / plant-overarching architecture: to allow plant-overarching analysis / benchmarking, multi-plant kpis,
  connections to enterprise-IT, etc.. We typically recommend sending only data processed by our API [factoryinsight]().
  One could also connect to the kafka broker and use a kafka-bridge to send data from the on-premise instances to a 
  central cloud instance, but typically only the "processed data" such as OEE, information on an order level 
  (how many products were produced, etc.) are relevant to higher level systems.
- the UMH has already been used in all of these architectures in production - from small scale to using it to benchmarks
  factories with each other.

Layered Scaling is an architectural approach in the United Manufacturing Hub that enables efficient scaling of your 
deployment across edge devices and servers. By dividing the processing workload across multiple layers or tiers, each
with a specific set of responsibilities, Layered Scaling allows for better management of resources, 
improved performance, and easier deployment of software components.

## When should I use it?

Layered Scaling is ideal when:

- You need to process and exchange data close to the source for latency reasons and independence from internet and
  network outages. For example, if you are taking pictures locally, analyzing them using machine learning, and then 
  scrapping the product if the quality is poor. In this case, you don't want the machine to be idle if something happens
  in the network. Also, it would not be acceptable for a message to arrive a few hundred milliseconds later, as the 
  process is quicker than that.
- High-frequency data might be useful to not send to the "higher" instance and store there. It can put unnecessary
  stress on those instances. You have an edge device that takes care of it. For example, you are taking and processing
  images (e.g., for quality reasons) or using an accelerometer and microphone for predictive maintenance reasons on the 
  machine and do not want to send data streams with 20 kHz (20,000 times per second) to the next instance.
- Organizational reasons. For the OT person, it might be better to configure the data contextualization using Node-RED
  directly at the production machine. They could experiment with it, configure it without endangering other machines,
  and see immediate results (e.g., when they move the position of a sensor). If the instance is "somewhere in IT," 
  they may feel they do not have control over it anymore and that it is not their system.

## What can I do with it?

With Layered Scaling in the United Manufacturing Hub, you can:

- Deploy minimized versions of the Helm Chart on edge devices, focusing on specific features required for that 
  environment (e.g., without the Historian and Analytics features enabled, but with the IFM retrofitting feature using 
  [sensorconnect](), with the barcodereader retrofit feature using [barcodereader](), or with the data connectivity via
  [Node-RED]() feature enabled).
- Seamlessly communicate between edge devices, on-premise servers, and cloud instances using the [kafka-bridge]() 
  microservice, allowing data to be buffered in between in case the internet or network connection drops.

## How can I use it?

To implement Layered Scaling in the United Manufacturing Hub:

1. Deploy a minimized version of the Helm Chart on edge devices, tailored to the specific features required for that 
   environment. You can either install the whole version using flatcar and then disable functionalities you do not need,
   or use the Management Console. If the feature is not available in the Management Console, you could try asking nicely
   in the Discord and we will, can provide you with a token you can enter during the flatcar installation, so that your 
   edge devices are pre-configured depending on your needs (incl. demilitarized zones, multiple networks, etc.)
2. Deploy the full Helm Chart with all features enabled on a central instance, such as a server.
3. Configure the Kafka Bridge microservice to transmit data from the edge devices to the central instance for further
   processing and analysis.

For MQTT connections, you can just connect external devices via MQTT, and it will land up in kafka directly. To connect
on-premise servers with the cloud (plant-overarching architecture), you can use kafka-bridge or write service in benthos
or Node-RED that regularly fetches data from factoryinsight and pushes it into your cloud instance.

## What are the limitations?

- At the moment only sending data upwards is supported in the kafka bridge @Ferdinand to check. If you want to send data
  downwards as well, feel free to contact us by opening a GitHub issue or contacting us in the Discord
- Be aware that each device increases the complexity over the entire system. We recommend using the 
  [Management Console](https://mgmt.docs.umh.app/docs/) to manage them centrally.

Because Kafka is used to reliably transmit messages from the edge devices to the server, and it struggles with devices 
repeatedly going offline and online again, ethernet connections should be used. also the total amount of edge devices
should not "escalate". if you have a lot of edge devices (e.g., you want to connect each PLC), we recommend connecting
them via MQTT to an instance of the UMH instead.

## Where to get more information?

- Learn more about the United Manufacturing Hub's architecture by visiting [our architecture page](/docs/architecture/).
- For more information about the Helm Chart and how to deploy it, refer to the [Helm Chart documentation](/docs/deployment/helm/).
- To get an overview of the microservices in the United Manufacturing Hub, check out the [microservices documentation](/docs/architecture/microservices/).
