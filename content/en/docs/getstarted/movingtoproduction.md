+++
title = "5. Moving to Production"
menuTitle = "5. Moving to Production"
description = "Moving the United Manufacturing Hub to production"
weight = 5000
+++

## Next steps

The next big step would of course be to use the UMH on an Edge device.
However, if you want to try around locally, we recommend you try out the following topics.

## Grafana Canvas

If you're interested in creating visually appealing Grafana dashboards, you might want to try Grafana-Canvas. In our previous [blog article](https://www.umh.app/post/building-shopfloor-dashboards-with-the-united-manufacturing-hub-and-grafana-canvas), we explained why Grafana-Canvas is a valuable addition to your standard Grafana dashboard. If you'd like to learn how to build one, check out our [tutorial](https://learn.umh.app/guides/advanced/data-visualization/canvas-grafana/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPCanvas.png?width=70%)

## OPC/UA-Simulator

If you want to get a good overview of how the OPC/UA protocol works and how to connect it to the UMH, the OPC/UA-simulator is a useful tool. Detailed instructions can be found in [this guide](https://learn.umh.app/course/creating-a-node-red-flow-with-simulated-opc-ua-data/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPopcua.png?width=70%)

## PackML-Simulator

For those looking to get started with PackML, the PackML Simulator is another helpful simulator. Check out our [tutorial](https://learn.umh.app/course/creating-a-node-red-flow-with-packml/) on how to create a Node-RED flow with PackML data.

![Untitled](/images/getstarted/movingToProduction/getStartedMTPPackMLStateModel.png)


## Benthos

Benthos is a highly scalable data manipulation and IT connection tool. If you're interested in learning more about it, check out our [tutorial](https://learn.umh.app/course/using-benthos-with-the-united-manufacturing-hub/).

![Untitled](/images/getstarted/movingToProduction/getStartedMTPBenthos.png)


## Kepware

At times, you may need to connect different, older protocols. In such cases, KepwareServerEx can help bridge the gap between these older protocols and the UMH. If you're interested in learning more, check out our [tutorial](https://learn.umh.app/course/connecting-kepware-with-the-opc-ua-simulator/).

## Edge device installation

Follow our step-by-step [tutorial](/docs/production-guide/installation/installation-guide-flatcar) on how to install the UMH on an edge device using Flatcar. We've also written a blog article explaining why we use Flatcar as the operating system for the industrial IoT, which you can find [here](https://learn.umh.app/blog/flatcar-as-the-operating-system-of-the-industrial-iot/).


