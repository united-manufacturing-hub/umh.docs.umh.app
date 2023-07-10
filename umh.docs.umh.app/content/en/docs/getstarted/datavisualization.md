+++
title = "4. Data Visualization"
menuTitle = "4. Data Visualization"
description = "Build a simple Grafana dashboard, with the gathered data."
weight = 4000
+++


  The next step is to visualize the data. This chapter is about the creation of
  a Grafana dashboard which is based on the Node-RED flow from the
  previous chapter. The dashboard will display the temperature readings
  and temperature warnings.


## Creating a Grafana dashboard

1. Open Grafana by opening the Grafana popup and clicking on the **open** button
   and enter the secrets found in the popup.

2. Once you are in Grafana hover over the fourth icon in the left menu,
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

9. Once finished making adjustments, click on the blue **Apply** button in the 
   top right-hand corner to save the panel and return to the overview.

10. The next step is to display the temperature warnings. Click **Add Panel** 
    at the top right to create an additional panel.
    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisAddingNewPanel.png?width=75%)

11. Repeat the steps discussed earlier, but this time, select 
    **TemperatureWarning** instead of **temperature** under **Value to query**.

12. Instead of a time series chart to display the temperature warnings, select
    **Stat** on the right side.
    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisStat.png?width=75%)

13. Now you can again customize your panel and when you are done click on
    **Apply**.

14. Congratulations, you have created your first Grafana dashboard, and it
    should look something like the one below.

    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisFinishedDashbaord.png?width=75%)


## What's next?

  The next topic is **Moving to Production** where we will explain what it
  means to move the umh to a manufacturing environment.
  Click [here](/docs/getstarted/movingtoproduction/) to proceed.