---
title: 4. Data Visualization
menuTitle: 4. Data Visualization
description: Build a simple Grafana dashboard, with the gathered data.
weight: 4000
---

In the following step, we will delve into the process of visualizing the data.
This chapter focuses on the construction of dashboards using Grafana. One
dashboard will be crafted around the OPC_UA data source, and the other will be
centered on the Node-RED flow, both of which were established in the
previous chapter.

## Creating a Grafana dashboard for OPC-UA Data Source

1. If you haven't done so already, open and log in to Grafana by following the instructions given in the
   [**Acess Grafana**](/docs/getstarted/managingthesystem/#access-grafana) section of chapter 2.

2. Once logged in, hover over the fourth icon in the left menu,
   **dashboards**, and click on **+ New dashboard**.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisNewDashboard.png?width=75%)

3. Click on **Add a new panel**.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisNewPanel.png?width=75%)

4. Next we will configure the **datasource-v2**, to retrieve the data we earlier
   transformed in Node-RED. Click on **umh-datasource** and switch to
   **umh-v2-datasource**.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDatasourceV2.png?width=75%)

5. Go to **Work cell to query** and select under **Select new work cell**:
   `factoryinsight->Aachen->DefaultArea->DefaultProductionLine->testing`

{{% notice info %}}
One can notice, that this is not the exact topic, set in the Node-RED flow
before. This due to our not yet finalized data model and not every part of
it is fully utilized yet. In the future, `DefaultArea` and
`DefaultProductionLine` will be replaced by actual values.
{{% /notice %}}

6. To select the temperature value, go to **Value to query** and
   select under **Select new value**:
   `tags->custom->temperature`.

7. Click on **Refresh Dashboard** at the top right-hand corner,
   the graph will refresh and display the temperature data.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisRefreshDashboard.png?width=75%)

8. Next, you can customise your dashboard. On the right side are several
   options, such as specifying a unit or setting thresholds, etc. Just play
   around until it suits your needs.

9. Once you're done making adjustments, click on the blue **Apply** button in the
   top right-hand corner to save the panel and return to the overview.

10. Congratulations, you have created your first Grafana dashboard, and it
    should look something like the one below.
    <!-- TODO: Update this pic -->
    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisFinishedDashbaord.png?width=75%)

## Creating a Grafana dashboard for Node-RED flow

1. Assuming you're at the panel overview, click on **Add Panel** at the top
   right-hand corner to create a new one. Otherwise, follow the steps 1-3
   from the [above section](#creating-a-grafana-dashboard-for-node-red-flow).
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisAddingNewPanel.png?width=75%)

## What's next?

The next topic is **Moving to Production** where we will explain what it
means to move the umh to a manufacturing environment.
Click [here](/docs/getstarted/movingtoproduction/) to proceed.
