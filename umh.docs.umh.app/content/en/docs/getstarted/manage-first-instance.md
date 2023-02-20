+++
title = "3. Manage and monitor your first instance (coming soon)"
description = "Coming soon"
weight = 3
aliases = []
+++

For now, the Management Console does not support this feature yet. To access and work with the infrastructure, please follow these steps instead:

1. Install [UMHLens](https://github.com/united-manufacturing-hub/UMHLens/releases/)
2. Open UMHLens
3. A new cluster should appear here called `k3d-united-manufacturing-hub`

   ![](/images/getstarted/manageFirstInstanceUMHLens.png)

4. Click on it to connect with it

Now you have access to the instance using UMHLens and can refer to the [United Manufacturing Hub docs]() instead. We recommend now playing around with the [simulated data inside of the UMH](https://learn.umh.app/guides/getstarted/data-acquisition/mqtt-sim/), [creating your first Node-RED flows](https://learn.umh.app/guides/getstarted/data-manipulation/) and [Grafana dashboards](https://learn.umh.app/guides/getstarted/data-visualization/).

{{% notice note %}}
There are some limitations of using the development version of the UMH locally on your computer, e.g., that you are only with heavy difficulties are able to connect from external devices or applications to your local running UMH instance. If you need this feature, please wait until the "Installation an a separate device" feature is finished, or get started immediately using the [OSS blueprint United Manufacturing Hub](https://learn.umh.app/guides/getstarted/installation/installation-guide-flatcar/)
{{% /notice %}}
