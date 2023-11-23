---
title: 4. Data Visualization
menuTitle: 4. Data Visualization
description: Build a simple Grafana dashboard, with the gathered data.
weight: 4000
---

In the following step, we will delve into the process of visualizing the data.
This chapter focuses on the construction of dashboards using Grafana. One
dashboard will be crafted around the OPC-UA data source, and the other will be
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

4. Next, we'll retrieve OPC-UA data from TimescaleDB. Before moving forward, ensure that the
   **UMH TimescaleDB** data source is selected; it should be the default choice.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisTimescaleDatasource.png?width=75%)

5. Open the code editor by switching from **Builder** to **Code**.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisCodeTab.png?width=75%)

6. Now we can write queries to retrieve time series data from your OPC-UA nodes. Let's begin with the
   following SQL query; just copy and paste it into the code editor.

   ```sql
   SELECT name, value, timestamp
   FROM tag
   WHERE asset_id = get_asset_id(
     'pharma-genix',
     'aachen',
     'packaging',
     'packaging_1',
     'blister'
   );
   ```

{{% notice info %}}
`get_asset_id` is a custom plpgsql function that we provide to simplify the process of querying
`tag` data from a specific `asset`.
In the code snippet above, the arguments provided to the function are based on the OPC-UA node we defined in the
[**Initialize the Connection**](/docs/getstarted/dataacquisitionmanipulation/#initialize-the-connection)
section of chapter 3, so adjust them accordingly if you used different values.
{{% /notice %}}

7. Click on **Run query** at the top right-hand corner of the code editor.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisRunQuery.png?width=75%)

8. Feel free to experiment with different queries to get a feel for the data model.

9. Next, you can customize your dashboard. On the right side, you'll find various
   options, such as specifying units or setting thresholds. Playaround until it
   suits your needs.

10. Once you're done making adjustments, click on the blue **Apply** button in the
    top right-hand corner to save the panel and return to the overview.

11. Congratulations, you have created your first Grafana dashboard, and for now it
    should look similar to the one below.
    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDashboard1.png?width=75%)

12. If you're interested in creating a dashboard for the Node-RED flow, don't worry,
    we got you covered in the next section. Otherwise, you can skip ahead to the
    [**Moving to Production**](/docs/getstarted/movingtoproduction/) chapter.

## Creating a Grafana dashboard for Node-RED flow

1. Assuming you're at the panel overview, click on **Add Panel** at the top
   right-hand corner to create a new one. Otherwise, follow the steps 1-3
   from the [above section](#creating-a-grafana-dashboard-for-opc-ua-data-source).
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisAddingNewPanel.png?width=75%)

2. Next we will configure the **datasource-v2**, to retrieve the data we earlier
   transformed in Node-RED. Click on **umh-datasource** and switch to
   **umh-v2-datasource**.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDatasourceV2.png?width=75%)

3. Go to **Work cell to query** and select under **Select new work cell**:
   `factoryinsight->Aachen->DefaultArea->DefaultProductionLine->testing`

{{% notice info %}}
One can notice, that this is not the exact topic, set in the Node-RED flow
before. This due to our not yet finalized data model and not every part of
it is fully utilized yet. In the future, `DefaultArea` and
`DefaultProductionLine` will be replaced by actual values.
{{% /notice %}}

4. To select the temperature value, go to **Value to query** and
   select under **Select new value**:
   `tags->custom->temperature`.

5. Click on **Refresh Dashboard** at the top right-hand corner,
   the graph will refresh and display the temperature data.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisRefreshDashboard.png?width=75%)

6. Same as before, feel free to customize your panel to your liking.

7. Save your panel by clicking on the blue **Apply** button in the top right-hand
   corner.

8. Back at the panel overview, you should now see both panels, similar to the
   image below.
   <!-- ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDashboard2.png?width=75%) -->

9. This concludes the **Data Visualization** chapter. If you're interested in
   learning more about Grafana, we recommend checking out the official
   [documentation](https://grafana.com/docs/grafana/latest/).

## What's next?

The next topic is **Moving to Production** where we will explain what it
means to move the umh to a manufacturing environment.
Click [here](/docs/getstarted/movingtoproduction/) to proceed.
