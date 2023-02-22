+++
title = "4. Data Visualization"
menuTitle = "4. Data Visualization"
description = ""
weight = 4000
+++


The next point is the visualisation of the data. In this chapter we will create a Grafana dashboard based on the node-red flow we created earlier, showing us the temperature and temperature warnings.

1. Open Grafana with UMHLens and enter the secrets also found in UMHLens.
2. Once you are in grafana navigate to the left and click on **New dashboard**.

   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisNewDashboard.png)
3. Click on **Add a new panel**.

   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisNewPanel.png)
4. Next we will configure the [datasource-v2](https://learn.umh.app/guides/advanced/data-visualization/grafana-datasource-v2-tutorial/), to retrieve the data we earlier transformed in Node-red. Click on **umh-v2-datasource**.

   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDatasourceV2.png)
5. Go to **Work cell to query** and select under **Select new work cell**: factoryinsight->Aachen->DefaultArea->DefaultProductionLine->testing
6. Next go to **Value to query** and select under **Select new value**: tags->custom->temperature .
7. If you now click on **Refresh Dashboard** at the top right-hand corner, the graph will refresh and display the temperature data.

   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisRefreshDashboard.png)
8. Next, you can customise your dashboard. On the right side are several options, such as specifying a unit or setting thresholds, etc. Just play around until it suits your needs.
9. When you have finished making adjustments, click **Apply** in the top right-hand corner to save the panel and return to the overview.
10. Next we will display the temperature warnings. Click **Add Panel** at the top right to create an additional panel.

    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisAddingNewPanel.png)
11. To set up the **umh-v2 data source**, repeat the steps discussed earlier, but select under **Value to query**:  **TemperatureWarning** instead of **temperature**.
12. instead of a time series chart to display the temperature warnings, we select **Stat** on the right side.

    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisStat.png)
13. Now you can again customize your panel and when you are done click on **Apply**.
14. Congratulations, you have created your first Grafana dashboard, and it should look something like the one below.

    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisFinishedDashbaord.png)


## What's next?

The next topic is "Moving to Production", where we will explain what it means to move the umh to a manufacturing environment. Click [here](/docs/getstarted/movingtoproduction/) to proceed.