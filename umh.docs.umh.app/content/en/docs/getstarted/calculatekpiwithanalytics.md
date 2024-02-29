---
title: 6. (optional) Calculating business KPIs such as OEE with _analytics
menuTitle: 6. (optional) Calculating business KPIs such as OEE with _analytics
description: Generate business KPIs such as OEE with _analytics
weight: 6000
draft: false
---

This guide focuses on calculating Overall Equipment Effectiveness (OEE) using [_analytics](https://1313-unitedmanuf-umhdocsumha-ywbal2q7x0i.ws-eu108.gitpod.io/docs/datamodel/messages/#_analytics), 
aimed at individuals familiar with MQTT, Node-RED, and Operational Technology (OT).
It offers a practical approach to leverage analytics for improving business KPIs.

In this guide we will set up a simple virtual printing machine using Node-RED, and calculate the OEE using the _analytics messages.

## Setting up a printing machine (Part 1)

If you are not interested in the setup, you can import the flow from [here](/json/getstarted/flows.json).

This guide assumes that you have some basic knowledge of Node-RED. If you are new to Node-RED, 
you can find a good introduction [here](https://nodered.org/docs/tutorials/first-flow).

### Creating the product-type/create function

Before producing anything our system first needs to know what we are producing. This is done by creating 
a product-type. 
In this example we will create a product-type called "otto-poster" (Prints of our beloved mascot Otto).
Therefore, we create an inject node and an MQTT node (to publish the product-type to the UNS).
Since we are dealing with a printer, we use a low cycle time of 10 milliseconds.

1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload type to JSON and the payload to:
```json
{
  "externalProductID": "otto-poster",
  "cycleTime": 0.01
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product-type/create`.
4. Drag an mqtt out node from the palette to the flow.
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.

### Creating the shift/add function

In order to calculate the OEE, we need to know when a shift starts and ends. 
Therefore, we create a shift. In this example our shift will be 8 hours long, beginning now.
We create an inject node, function node and a mqtt node (to publish the shift to the UNS).

1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to `{}`.
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/shift/add`.
4. Drag a function node from the palette to the flow.
5. Double-click the function node and set the following code:
```javascript
const startTime = Date.now();
// This shift will be 8 hours
const endTime = startTime + 28800000

msg.payload = {
    "startTime": startTime,
    "endTime": endTime
}
return msg;
```
6. Drag an mqtt out node from the palette to the flow.
7. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
8. Connect the inject node to the function node and the function node to the mqtt node.
9. Deploy the flow.

### Creating the work-order/create function

Now that we have a product-type and a shift, we can create a work-order. 
In this example we will create a work-order for 7500 "otto-poster" prints.
Each work-order has an work order id, which is unique per asset. 
In this example we will use the work order id `#1247`.
This order id will come from your ERP system, but for this example we will use an inject node.

1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to:
```json
{
  "externalWorkOrderId": "#1247",
  "product": {
    "externalProductId": "otto-poster"
  },
  "quantity": 7500
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/create`.
4. Drag an mqtt out node from the palette to the flow.
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.

### Creating the work-order/start function

We are ready to start the work-order. This is done by creating a work-order/start event. 
In this example we will start the work-order `#1247`, which we created in the previous step.

1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to:
```json
{
  "externalWorkOrderId": "#1247"
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/start`.
4. Drag a function node from the palette to the flow.
5. Double-click the function node and set the following code:

```javascript
    const startTime = Date.now();

    msg.payload["startTime"] = startTime
    return msg;
```
6. Drag an mqtt out node from the palette to the flow.
7. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
8. Connect the inject node to the function node and the function node to the mqtt node.
9. Deploy the flow.


### Creating the state machine

Normally you get the machine state directly from the machine. In the first step, 
we will simply inject a "machine running", and "machine stopped" with inject node. 
As a more advanced step, we will build a simulator in Node-RED.

#### Injecting running and stopped states

In this step, we create a simple flow injecting running and stopped state of machine.

1. Drag an inject node from the palette to the flow. This node injects the start status.
2. Double-click the inject node and set the payload to:
```json
{  "state": 
  {
    "id": 100, 
    "lastchange": 0
  }
}
```
3. Drag an inject node from the palette to the flow. This node injects the stopped status.
4. Double-click the inject node and set the payload to:
```json
{  "state": 
  {
    "id": 200, 
    "lastchange": 0
  }
}
```

3. Drag a function node from the palette to the flow.
4. Double-click the function node and set the following code:
```javascript
// Create a name of the received state
switch (msg.payload.state.id) {
    case 100:
        msg.payload.state.name = "MachineStartingState"
        break
    case 200:
        msg.payload.state.name = "MachineStopState"
        break
    default:
        msg.payload.state.name = "UnknownState"
        break
}

// Set time
const time = Date.now();
msg.payload.state.lastchange = time
    
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/state/statewithname";
return msg;
```
5. Connect both inject nodes to the function node.
6. Drag an mqtt out node from the palette to the flow.
7. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the function node.
8. Connect the function node to the mqtt node.
9. Now, creating the flow shall be completed. 

![start and stop flow](/images/getstarted/calculateKpiWithAnalytics/start-stop.png?width=75%)


#### Creating state machine
As an advanced step, we will create a state machine to simulate the printing process.
It will listen for the work-order/start event and then simulate produce the prints.
While producing it will change to different states, and might output some failed prints.

1. Drag an mqtt in node from the palette to the flow.
2. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server 
and set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/start`.
3. Drag a function node from the palette to the flow. This function will setup the state machine.
4. Double-click the function node, set the name `state-machine-setup`, and set the following code:
```javascript
// At the start of each order there is nothing produced, so set it to zero
msg.payload["produced"] = 0;

// ProducingAtLowerThanFullSpeedState [ramping up]
// We later simulate that the machine gets faster over time
msg.payload["state"] = {
    id: 20000,
    lastchange: Date.now()
}
return msg;
```
5. Connect the mqtt node to the *state-machine-setup* function node.
6. Drag a switch node from the palette to the flow. 
This node will stop the process when the work-order is finished.
7. Set the switch node to check if `msg.payload.produced` is greater than or equal to `7500` 
(the quantity of the work-order).
8. Add another rule to check if `msg.payload.produced` is less than `7500`.
9. Connect the function node to the switch node.
10. Drag a function node from the palette to the flow. 
This function will handle the end of the work-order.
11. Double-click the function node and set the name `workorder-end-handler` and the following code:
```javascript
// We produced every product in this order, so let's stop it
msg.payload = {
    "externalWorkOrderId": "#1247",
    "endTime": Date.now(),
}
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/stop";
return msg;
```
12. Connect the first rule (top output) of the switch node to the *workorder-end-handler* function node.
13. Drag an mqtt out node from the palette to the flow.
14. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the function node.
15. Connect the *workorder-end-handler* function node to the mqtt node.
16. Now we will create the loop for the state machine.
17. Drag a function node from the palette to the flow. This function will simulate state changes.
18. Double-click the function node and set the name `state-change-simulator` and the following code:
{{< codenew file="js/simulate-state-changer.js" >}}

19. Ensure that "Outputs" is set to 2 in the function node.
20. Connect the second rule (bottom output) of the switch node to the *state-change-simulator* function node.
21. We will now create the flow to publish state changes to the UNS.
22. Drag a filter node from the palette to the flow. This node will filter out the state changes.
23. Set the filter node to block unless value changes and set the property to `msg.payload.state.id`.
24. Connect both outputs of the *state-change-simulator* function node to the filter node.
25. Drag a function node from the palette to the flow. This function will publish the state changes to the UNS.
26. Double-click the function node and set the name `state-change-publisher` and the following code:
```javascript
// We have a state change, let's publish it
msg.payload = {
    "startTime": Date.now(),
    "state": msg.payload.state.id
};
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/state/add";

return msg;
```
27. Connect the filter node to the *state-change-publisher* function node.
28. Drag an mqtt out node from the palette to the flow.
29. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the function node.
30. Connect the *state-change-publisher* function node to the mqtt node.
31. Now we will create the producer functions.
32. Drag a function node from the palette to the flow. This function will increase the produced amount.
33. Double-click the function node and set the name `produced-amount-incrementar` and the following code:
```javascript
// Assuming that the producing isn't failing this works
const produced = msg.payload.produced + 1;

// JSON.parse(JSON.stringify(msg)) is a simple way to deep copy it
let msg_write_back = JSON.parse(JSON.stringify(msg))
msg_write_back.payload.produced = produced;

// Delete everything from the product messages, that is not needed
delete msg.payload.produced;
delete msg.payload.state;
delete msg.payload.delay;

return [msg_write_back,msg];
```
34. Ensure that "Outputs" is set to 2 in the function node.
35. Connect the bottom output of the *state-change-simulator* function node to the function node.
36. Create another function node from the palette to the flow. 
This function will publish the produced amount to the UNS.
37. Double-click the function node and set the name `produced-amount-publisher` and the following code:
{{< codenew file="js/produce-amount-publisher.js" >}}

38. Ensure that "Outputs" is set to 2 in the function node.
39. Connect the bottom output of the *produced-amount-incrementar* function node to the function node.
40. Drag a mqtt out node from the palette to the flow.
41. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the function node.
42. Connect the top output of the *produced-amount-publisher* function node to the mqtt node.
43. Create a function node from the palette to the flow. This function will randomly scrap some products.
44. Double-click the function node and set the name `products-scrap` and the following code:
```javascript
// This works for us, as we produce one at a time
msg.badQuantity = msg.quantity;

// setBadQuantiy doesn't have these keys, so we just delete them
delete msg.quantity;
delete msg.productId;

msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product/setBadQuantity";
return msg;
```
45. Connect the bottom output of the *produced-amount-publisher* function node to the function node.
46. Drag a mqtt out node from the palette to the flow.
47. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the function node.
48. Connect the *products-scrap* function node to the mqtt node.
49. Great, now we just need to create a feedback loop to continue the state machine.
50. Drag a delay node from the palette to the flow.
51. Set the delay node to 10 milliseconds.
52. Set "Fixed Delay" to "Override delay with msg.delay".
53. Connect the top output of the *produced-amount-incrementar* function node to the delay node.
54. Connect the top output of the *state-change-simulator* function node to the delay node.
55. Connect the delay node to the switch node from step 6.
56. Deploy the flow.

![state machine](/images/getstarted/calculateKpiWithAnalytics/state-machine.png?width=75%)
### Accidentally created shifts or states

If you accidentally created a shift or state, you can remove it by creating a shift/delete or state/overwrite event.

For shift/delete:
1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to:
```json
{
  "startTime": <start time of the shift>,
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/shift/delete`.
4. Drag an mqtt out node from the palette to the flow.
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.
8. Click the inject node to remove the shift.


For state/overwrite:
1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to:
```json
{
  "startTime": <start time of the state>,
  "endTime": <end time of the state>,
  "state": <state id>
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/state/overwrite`.
4. Drag an mqtt out node from the palette to the flow.
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, 
you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.
8. Click the inject node to overwrite the state.


## Accessing the data (Part 2)

Now that we have set up the printing machine, we can calculate the OEE.

The easiest way to access the saved data is via Grafana.
Navigate to the IP of your United Manufacturing Hub using port 8080 and log in with your credentials.

If you do not know your credentials, log in via SSH and execute the following command:
```bash
sudo $(which kubectl) get secret grafana-secret -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -o jsonpath='{.data.adminpassword}' | base64 -d
```

The default username is `admin`.

Checkout the [Historian](http://localhost:1313/docs/datamodel/database/) page for more information on how the tables are structured.

## Calculating the OEE (Part 3) using SQL

The following steps assume that the asset id of the printing machine is 1.
You can show all asset id's by executing the following SQL query:
```sql
SELECT * FROM assets;
```

<!--
-- THIS IS A HTML COMMENT AND NOT VISISBLE IN THE FINAL DOCUMENTATION
-- Work Order Table
-- This table stores information about manufacturing orders. The ISA-95 model defines work orders in terms of production requests.
-- Here, each work order is linked to a specific asset and product type
CREATE TABLE work_orders (
workOrderId SERIAL PRIMARY KEY,
externalWorkOrderId TEXT UNIQUE NOT NULL,
assetId INTEGER NOT NULL REFERENCES assets(id),
productTypeId INTEGER NOT NULL REFERENCES product_types(productTypeId),
quantity INTEGER NOT NULL,
status INTEGER NOT NULL DEFAULT 0, -- 0: planned, 1: in progress, 2: completed
startTime TIMESTAMPTZ,
endTime TIMESTAMPTZ,
CONSTRAINT asset_workorder_uniq UNIQUE (assetId, externalWorkOrderId),
CHECK (quantity > 0),
CHECK (status BETWEEN 0 AND 2),
EXCLUDE USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&) WHERE (startTime IS NOT NULL AND endTime IS NOT NULL)
-- EXCLUDE USING gist ensures that no two work orders for the same asset overlap in time
);

-- Product Type Table
CREATE TABLE product_types (
productTypeId SERIAL PRIMARY KEY,
externalProductTypeId TEXT UNIQUE NOT NULL,
cycleTime REAL NOT NULL,
assetId INTEGER REFERENCES assets(id),
CONSTRAINT external_product_asset_uniq UNIQUE (externalProductTypeId, assetId),
CHECK (cycleTime > 0)
);

-- Product Table
-- -- Tracks individual products produced. This table captures production output, quality (through badQuantity), and timing
CREATE TABLE products (
productId SERIAL PRIMARY KEY,
externalProductTypeId INTEGER REFERENCES product_types(productTypeId),
assetId INTEGER REFERENCES assets(id),
startTime TIMESTAMPTZ,
endTime TIMESTAMPTZ NOT NULL,
quantity INTEGER NOT NULL,
badQuantity INTEGER DEFAULT 0,
CHECK (quantity > 0),
CHECK (badQuantity >= 0),
CHECK (startTime <= endTime),
CONSTRAINT product_endtime_asset_uniq UNIQUE (endTime, assetId)
);

-- creating hypertable
SELECT create_hypertable('products', 'endTime');

-- creating an index to increase performance
CREATE INDEX idx_products_asset_endtime ON products(assetId, endTime DESC);

-- Using btree_gist to avoid overlapping shifts
-- Source: https://gist.github.com/fphilipe/0a2a3d50a9f3834683bf

-- Shifts Table
-- Manages work shifts for assets. Shift scheduling is a key operational aspect under ISA-95, impacting resource planning and allocation.
CREATE TABLE shifts (
shiftId SERIAL PRIMARY KEY,
assetId INTEGER REFERENCES assets(id),
startTime TIMESTAMPTZ NOT NULL,
endTime TIMESTAMPTZ NOT NULL,
CONSTRAINT shift_start_asset_uniq UNIQUE (startTime, assetId),
CHECK (startTime < endTime),
EXCLUDE USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&)
);

-- State Table
-- Records the state changes of assets over time. State tracking supports ISA-95's goal of detailed monitoring and control of manufacturing operations.
CREATE TABLE states (
stateId SERIAL PRIMARY KEY,
assetId INTEGER REFERENCES assets(id),
startTime TIMESTAMPTZ NOT NULL,
state INT NOT NULL,
CHECK (state >= 0),
CONSTRAINT state_start_asset_uniq UNIQUE (startTime, assetId)
);
-- creating hypertable
SELECT create_hypertable('states', 'startTime');

-- creating an index to increase performance
CREATE INDEX idx_states_asset_starttime ON states(assetId, startTime DESC);
-->

### Calculate products per shift

This SQL query calculates the number of products produced per shift.
It is limited to products produced in 2024 enhancing the query performance.

```sql
-- Calculate products per shift
SELECT
    s.assetId,
    s.startTime,
    s.endTime,
    COUNT(p.productId) AS products
FROM
    shifts s
LEFT JOIN
    products p
ON
    s.assetId = p.assetId
AND
    p.endTime BETWEEN s.startTime AND s.endTime
AND
    p.endTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY
    s.assetId,
    s.startTime,
    s.endTime
```

### Calculate the availability of our machine

In this example, we calculate the availability of our machine.
We define it as the time the machine was in a good state (`state > 10000 & state < 29999`) and had an active work-order, divided by the selected time frame.
The result is the availability percentage.

- The `timeframe` [Common Table Expression (CTE)](https://www.postgresql.org/docs/current/queries-with.html) is where you define the start and end of your time frame for analysis.
- The `good_state_duration` CTE calculates the total time the asset was both in a good state and had an active work order within the selected time frame.
- The `active_work_order_duration` CTE calculates the total duration of the selected time frame.
- Finally, the main query calculates the availability percentage by dividing the total good state time by the total time frame duration.
- Adjust the start and end times in `selected_time_frame` to match your specific time frame for analysis.

```sql
-- Calculating availability for assets
WITH timeframe AS (
    SELECT
        '2023-01-01T00:00:00Z'::TIMESTAMPTZ AS start_time,
            '2023-01-31T23:59:59Z'::TIMESTAMPTZ AS end_time
),
 good_state_duration AS (
     SELECT
         s.assetId,
         SUM(LEAST(s.endTime, tf.end_time) - GREATEST(s.startTime, tf.start_time)) AS good_state_time
     FROM
         states s,
         timeframe tf
     WHERE
         s.state > 10000 AND s.state < 29999
       AND s.startTime < tf.end_time
       AND s.endTime > tf.start_time
     GROUP BY
         s.assetId
 ),
 active_work_order_duration AS (
     SELECT
         w.assetId,
         SUM(LEAST(w.endTime, tf.end_time) - GREATEST(w.startTime, tf.start_time)) AS work_order_time
     FROM
         work_orders w,
         timeframe tf
     WHERE
         w.startTime < tf.end_time
       AND w.endTime > tf.start_time
     GROUP BY
         w.assetId
 )
SELECT
    gs.assetId,
    CASE
        WHEN awo.work_order_time IS NULL THEN 0
        ELSE gs.good_state_time / awo.work_order_time
        END AS availability
FROM
    good_state_duration gs
        LEFT JOIN
    active_work_order_duration awo ON gs.assetId = awo.assetId
ORDER BY
    gs.assetId;

```

### Calculate the performance of our machine

In this example, we calculate the performance of our machine.
We define it as the total number of products produced divided by the ideal production.
The result is the performance percentage.

- The `total_produced` CTE calculates the total number of products produced within the selected time frame.
- The `ideal_production` CTE calculates the total time in good state during active work orders.
- Finally, the main query calculates the performance percentage by dividing the total produced by the ideal production.

```sql
WITH total_produced AS (
    -- Calculate total produced within the selected time frame
    SELECT
        SUM(quantity) AS total_produced
    FROM
        products
    WHERE
        endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
    ),
    total_hours AS (
-- Calculate the total available time for production in hours
SELECT
    SUM(EXTRACT(EPOCH FROM (LEAST(ws.endTime, '2024-01-31T23:59:59Z'::TIMESTAMPTZ) - GREATEST(ws.startTime, '2024-01-01T00:00:00Z'::TIMESTAMPTZ))) / 3600) AS total_hours -- Converts time interval to hours
FROM
    work_orders AS wo
    INNER JOIN shifts AS ws ON wo.assetId = ws.assetId
WHERE
    wo.assetId = 1 -- Asset ID of the printing machine
  AND wo.status BETWEEN 1 AND 2 -- Work orders that are in progress or completed
  AND ws.startTime < '2024-01-31T23:59:59Z'::TIMESTAMPTZ
  AND (ws.endTime IS NULL OR ws.endTime > '2024-01-01T00:00:00Z'::TIMESTAMPTZ)
    ),
    actual_production_rate AS (
-- Calculate the actual production rate for the selected timeframe
SELECT
    SUM(quantity) / SUM(EXTRACT(EPOCH FROM (endTime - startTime)) / 3600) AS rate
FROM
    work_orders
WHERE
    status = 1 -- Assuming status = 1 means the work order is completed
  AND assetId = 1 -- Filter by the specific asset
  AND endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ -- Adjust this to your selected timeframe
    )
SELECT
    -- Calculate performance as a percentage of actual produced vs. what was actually possible at the actual production rate
    (tp.total_produced / (th.total_hours * apr.rate)) * 100 AS performance_percentage
FROM
    total_produced tp,
    total_hours th,
    actual_production_rate apr;
```


### Calculate the quality of our machine

In this example, we calculate the quality of our machine.
We define it as the number of good products divided by the total number of products produced.
The result is the quality percentage.

- The `production_summary` CTE aggregates the total produced and bad quantity within the selected time frame.
- Finally, the main query calculates the quality percentage by dividing the total produced by the bad quantity.

```sql
WITH production_summary AS (
    -- Aggregate total produced and bad quantity within the given timeframe
    SELECT
        SUM(quantity) AS total_produced,
        SUM(badQuantity) AS total_bad
    FROM
        products
    WHERE
        endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
        -- Adjust the above timeframe to your specific requirement
)
SELECT
    -- Calculate Quality as (Total Produced - Bad Quantity) / Total Produced
    (total_produced - total_bad)::FLOAT / total_produced AS quality
FROM
    production_summary;
```

### Calculate the OEE of our machine

In this example, we calculate the OEE of our machine.
The output will be a table with the availability, performance, and quality percentages.

This SQL is based on the previous examples and combines the availability, performance, and quality calculations into a single query.

```sql
WITH selected_time_frame AS (
    -- Define the overall time frame for calculating OEE
    SELECT
        '2024-01-01T00:00:00Z'::TIMESTAMPTZ AS start_time, -- Example start time of selected time frame
        '2024-01-31T23:59:59Z'::TIMESTAMPTZ AS end_time    -- Example end time of selected time frame
),
availability AS (
    -- Calculate availability as the ratio of good state time to total time frame
    SELECT
        (gt.total_good_time / tt.total_time) AS availability_percentage
    FROM
        (
            -- Calculate total time in good state during active work orders
            SELECT
                SUM(LEAST(ws.endTime, stf.end_time) - GREATEST(ws.startTime, stf.start_time)) AS total_good_time
            FROM
                work_orders AS wo
            INNER JOIN states AS s ON wo.assetId = s.assetId
            INNER JOIN selected_time_frame stf ON s.startTime <= stf.end_time AND s.endTime >= stf.start_time
            WHERE
                wo.assetId = 1 -- Asset ID of the printing machine
                AND s.state > 10000 AND s.state < 29999
                AND wo.status BETWEEN 1 AND 2 -- Work orders that are in progress or completed
                AND s.startTime < wo.endTime
                AND (s.endTime IS NULL OR s.endTime > wo.startTime)
        ) gt,
        (
            -- Calculate the total selected time frame duration
            SELECT
                (end_time - start_time) AS total_time
            FROM
                selected_time_frame
        ) tt
),
performance AS (
    -- Calculate performance as the ratio of total produced to the ideal production
    SELECT
        (ps.total_produced / (ws.endTime - ws.startTime)) AS performance_percentage
    FROM
        (
            -- Calculate total produced within the selected time frame
            SELECT
                SUM(quantity) AS total_produced
            FROM
                products
            WHERE
                endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
                -- Adjust the above timeframe to your specific requirement
        ) ps,
        (
            -- Calculate total time in good state during active work orders
            SELECT
                ws.startTime,
                ws.endTime
            FROM
                work_orders AS wo
            INNER JOIN shifts AS ws ON wo.assetId = ws.assetId
            WHERE
                wo.assetId = 1 -- Asset ID of the printing machine
                AND wo.status BETWEEN 1 AND 2 -- Work orders that are in progress or completed
                AND ws.startTime < wo.endTime
                AND (ws.endTime IS NULL OR ws.endTime > wo.startTime)
        ) ws
),
quality AS (
    -- Calculate quality as the ratio of good products to total products produced
    SELECT
        (ps.total_produced - ps.total_bad)::FLOAT / ps.total_produced AS quality
    FROM
        (
            -- Aggregate total produced and bad quantity within the given timeframe
            SELECT
                SUM(quantity) AS total_produced,
                SUM(badQuantity) AS total_bad
            FROM
                products
            WHERE
                endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
                -- Adjust the above timeframe to your specific requirement
        ) ps
)
SELECT
    availability.availability_percentage,
    performance.performance_percentage,
    quality.quality
FROM
    availability,
    performance,
    quality;
```


### Calculate the stop reasons of our machine

In this example, we calculate the stop reasons of our machine.
The output will be a table with the stop reasons and the time and length of the stops.

```sql
WITH stop_reasons AS (
    -- Select all stop reason occurrences for asset id = 1
    SELECT
        s.state AS stop_reason,
        s.startTime,
        s.endTime,
        -- Calculate duration of each stop; handle ongoing stops by assuming current time as end time if end time is null
        COALESCE(s.endTime, NOW()) - s.startTime AS duration
    FROM
        states s
    WHERE
        s.assetId = 1
        AND (s.state < 10000 OR s.state > 29999) -- Everything not in good state range is a stop reason
    AND 
        s.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' -- Example time frame
)
SELECT
    stop_reason,
    startTime,
    endTime,
    duration
FROM
    stop_reasons
ORDER BY
    startTime;
```

### Calculate the Shifts of our machine

This example calculates the shifts of our machine and creates a timeline.

- The `shift_timeline` CTE selects all shifts for asset id = 1 within the selected time frame.

```sql
WITH shift_timeline AS (
    -- Select all shifts for asset id = 1
    SELECT
        s.startTime,
        s.endTime
    FROM
        shifts s
    WHERE
        s.assetId = 1
    AND 
        s.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' -- Example time frame
)
SELECT
    startTime,
    endTime
FROM
    shift_timeline
ORDER BY
    startTime;
```

### Calculate the Work Orders of our machine

This example calculates the work orders of our machine and creates a timeline.

- The `work_order_timeline` CTE selects all work orders for asset id = 1 within the selected time frame.

```sql
WITH work_order_timeline AS (
    -- Select all work orders for asset id = 1
    SELECT
        wo.startTime,
        wo.endTime
    FROM
        work_orders wo
    WHERE
        wo.assetId = 1
    AND 
        wo.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' -- Example time frame
)
SELECT
    startTime,
    endTime
FROM
    work_order_timeline
ORDER BY
    startTime;
```

### Show the current product type

This example shows the current product type of our machine.

```sql
SELECT
    pt.externalProductTypeId
FROM
    product_types pt
WHERE
    pt.assetId = 1
```

### Show the order table

This example shows the order table of our machine.

```sql
SELECT
    wo.externalWorkOrderId,
    wo.quantity,
    wo.status,
    wo.startTime,
    wo.endTime
FROM
    work_orders wo
WHERE
    wo.assetId = 1
```

### Calculate the total time of all stop reasons grouped by stop reason

This example calculates the total time of all stop reasons grouped by stop reason.

- The `stop_reasons` CTE selects all stop reason occurrences for asset id = 1 within the selected time frame.
- The main query calculates the total time of all stop reasons grouped by stop reason.

```sql
WITH stop_reasons AS (
    -- Select all stop reason occurrences for asset id = 1
    SELECT
        s.state AS stop_reason,
        s.startTime,
        s.endTime,
        -- Calculate duration of each stop; handle ongoing stops by assuming current time as end time if end time is null
        COALESCE(s.endTime, NOW()) - s.startTime AS duration
    FROM
        states s
    WHERE
        s.assetId = 1
        AND (s.state <= 10000 OR s.state >= 29999) -- Everything not in good state range is a stop reason
    AND 
        s.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' -- Example time frame
)
SELECT
    stop_reason,
    SUM(duration) AS total_duration
FROM
    stop_reasons
GROUP BY
    stop_reason
ORDER BY
    stop_reason;
```

### Calculate the production speed over time

This example uses timescale buckets to calculate the production speed over time.

- The `production_speed` CTE calculates the production speed over time using timescale buckets, you can modify the `time_bucket` function to change the bucket size.

```sql
WITH production_speed AS (
    -- Calculate production speed over time using timescale buckets
    SELECT
        time_bucket('5 minutes', p.endTime) AS bucket,
        COUNT(p.productId) AS products
    FROM
        products p
    WHERE
        p.assetId = 1
    AND 
        p.endTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59' -- Example time frame
    GROUP BY
        bucket
)
SELECT
    bucket,
    SUM(products) AS total_products
FROM
    production_speed
GROUP BY
    bucket
ORDER BY
    bucket;
```

