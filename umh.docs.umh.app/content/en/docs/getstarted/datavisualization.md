---
title: 4. Data Visualization
menuTitle: 4. Data Visualization
description: Build a simple Grafana dashboard with the gathered data.
weight: 4000
---

In the following step, we will delve into the process of visualizing the data.
This chapter focuses on the construction of dashboards using Grafana. The
dashboard will be crafted around the OPC-UA data source and the Node-RED flow,
both of which were established in the previous chapter.

## Creating a Grafana dashboard

1. If you haven't done so already, open and log in to Grafana by following the instructions given in the
   [**Acess Grafana**](/docs/getstarted/managingthesystem/#access-grafana) section of chapter 2.

2. Once logged in, click on **Dashboards** in the left-side menu.

3. On the Dashboard page, click **New** and select **New Dashboard** from the drop-down menu.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisNewDashboard.png?width=75%)

4. Click on **+ Add visualization**, which will redirect you to the edit panel view.

5. Next, we'll retrieve OPC-UA data from TimescaleDB. Select **UMH TimescaleDB** 
data source in the dialog box.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisTimescaleDatasource.png?width=75%)

6. We'll show you how to run queries with both the **Builder** mode (a graphical query builder) and the
   **Code** mode (a code editor to write RAW SQL). Let's begin with the graphical approach.

7. Let's query all `value`, `timestamp` and `name` columns from the `tag` table. For some guidance, refer to the
   image below.
   ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisQueryUI.png?width=75%)

8. Click on the **Run Query** button located next to the Builder/Code modes switcher.

9. You should now see a time series graph based on the query you just ran. The Builder mode is a great way to get
   started, but it has its limitations. For more complex use cases, we recommend using the Code mode, which we'll
   cover in the next steps.

10. Open the code editor by switching from **Builder** to **Code**.

11. Now we'll run a slightly more complex query. We'll retrieve the same columns as before, but this time only for a
    specific `asset`.

    ```sql
    SELECT name, value, time_bucket('$__interval', timestamp) AS time
    FROM tag
    WHERE asset_id = get_asset_id(
    	'pharma-genix',
    	'aachen',
    	'packaging',
    	'packaging_1',
    	'blister',
    	'PLC13'
    )
    AND $__timeFilter(timestamp)
    GROUP BY time, name, value
    ORDER BY time DESC;
    ```

    There are a few things to unpack here, so let's break it down:

    - [`time_bucket`](https://docs.timescale.com/use-timescale/latest/time-buckets/about-time-buckets/) is a TimescaleDB function that groups data into time intervals. The first argument is the
      interval, which is set to [`$__interval`](https://grafana.com/docs/grafana/latest/dashboards/variables/add-template-variables/#__interval) to match the time range selected in the Grafana dashboard (1m, 6h, 7d, etc). The second
      argument is the column to group by, which is `timestamp`, as defined in our [data model](/docs/datamodel/database).
    - The table we're querying is `tag`, this varies depending on the tag's data type, find more information in the data
      model linked above.
    - The `asset_id` is retrieved using the `get_asset_id` function, which is a custom plpgsql function we provide to
      simplify the process of querying `tag` data from a specific `asset`. Click [here](/docs/datamodel/database/#data-retrieval) for more examples.
    - [`$__timeFilter`](https://grafana.com/docs/grafana/latest/dashboards/variables/add-template-variables/#timefilter-or-__timefilter) is a Grafana function that filters the data based on a given time range. It receives one
      argument, which is the column to filter by, in our case `timestamp`.
    - Finally, we group the data by `time` (timestamp alias), `name`, and `value`, and order it by `time` in descending order to display the most recent data first.

{{% notice info %}}
You can also select the desired tag in the **Tag Browser** of the **Management Console**, and directly copy the provided
SQL query from there.
{{% /notice %}}

12. Same as before, click on the **Run Query** button to execute the query. If you've been following along, you won't
    see any noticeable changes, since we only have one `asset` in our database.

13. Feel free to experiment with different queries to get a better feel for the data model.

14. Next, you can customize your dashboard. On the right side, you'll find various
    options, such as specifying units or setting thresholds. Playaround until it
    suits your needs.

15. Once you're done making adjustments, click on the blue **Apply** button in the
    top right-hand corner to save the panel and return to the overview.

16. Congratulations, you have created your first Grafana dashboard, and for now it
    should look similar to the one below.
    ![Untitled](/images/getstarted/dataVisualization/getStartedDataVisDashboard1.png?width=75%)

## What's next?

The next topic is **Moving to Production** where we will explain what it
means to move the umh to a manufacturing environment.
Click [here](/docs/getstarted/movingtoproduction/) to proceed.
