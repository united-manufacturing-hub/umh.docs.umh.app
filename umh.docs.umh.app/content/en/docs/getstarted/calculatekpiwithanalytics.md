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
    sh.assetId,
    sh.startTime,
    sh.endTime,
    COUNT(pr.productId) AS products
FROM
    shifts sh
        LEFT JOIN
    products pr
    ON
        sh.assetId = pr.assetId
            AND
        pr.endTime BETWEEN sh.startTime AND sh.endTime
            AND
        pr.endTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
GROUP BY
    sh.assetId,
    sh.startTime,
    sh.endTime
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
         st.assetId,
         SUM(LEAST(st.endTime, tf.end_time) - GREATEST(st.startTime, tf.start_time)) AS good_state_time
     FROM
         states st,
         timeframe tf
     WHERE
         st.state > 10000 AND st.state < 29999
       AND st.startTime < tf.end_time
       AND st.endTime > tf.start_time
     GROUP BY
         st.assetId
 ),
 active_work_order_duration AS (
     SELECT
         wo.assetId,
         SUM(LEAST(wo.endTime, tf.end_time) - GREATEST(wo.startTime, tf.start_time)) AS work_order_time
     FROM
         work_orders wo,
         timeframe tf
     WHERE
         wo.startTime < tf.end_time
       AND wo.endTime > tf.start_time
     GROUP BY
         wo.assetId
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
- Finally, the main query calculates the performance percentage by dividing the total produced by the ideal production.

```sql
WITH total_produced AS (
    SELECT
        SUM(pr.quantity) AS total_produced
    FROM
        products pr
    WHERE
        pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
    ),
    total_hours AS (
SELECT
    SUM(EXTRACT(EPOCH FROM (LEAST(sh.endTime, '2024-01-31T23:59:59Z'::TIMESTAMPTZ) - GREATEST(sh.startTime, '2024-01-01T00:00:00Z'::TIMESTAMPTZ))) / 3600) AS total_hours
FROM
    work_orders wo
    INNER JOIN shifts sh ON wo.assetId = sh.assetId
WHERE
    wo.assetId = 1
  AND wo.status BETWEEN 1 AND 2
  AND sh.startTime < '2024-01-31T23:59:59Z'::TIMESTAMPTZ
  AND (sh.endTime IS NULL OR sh.endTime > '2024-01-01T00:00:00Z'::TIMESTAMPTZ)
    ),
    actual_production_rate AS (
SELECT
    SUM(pr.quantity) / SUM(EXTRACT(EPOCH FROM (pr.endTime - pr.startTime)) / 3600) AS rate
FROM
    products pr
WHERE
    pr.status = 1
  AND pr.assetId = 1
  AND pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
    )
SELECT
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
    SELECT
        SUM(pr.quantity) AS total_produced,
        SUM(pr.badQuantity) AS total_bad
    FROM
        products pr
    WHERE
        pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
    )
SELECT
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
    SELECT
        '2024-01-01T00:00:00Z'::TIMESTAMPTZ AS start_time,
            '2024-01-31T23:59:59Z'::TIMESTAMPTZ AS end_time
),
     availability AS (
         SELECT
             (gs.total_good_time / tt.total_time) AS availability_percentage
         FROM
             (
                 SELECT
                     SUM(LEAST(st.endTime, stf.end_time) - GREATEST(st.startTime, stf.start_time)) AS total_good_time
                 FROM
                     work_orders wo
                         INNER JOIN states st ON wo.assetId = st.assetId
                         INNER JOIN selected_time_frame stf ON st.startTime <= stf.end_time AND st.endTime >= stf.start_time
                 WHERE
                     wo.assetId = 1
                   AND st.state > 10000 AND st.state < 29999
                   AND wo.status BETWEEN 1 AND 2
                   AND st.startTime < wo.endTime
                   AND (st.endTime IS NULL OR st.endTime > wo.startTime)
             ) gs,
             (
                 SELECT
                     (end_time - start_time) AS total_time
                 FROM
                     selected_time_frame
             ) tt
     ),
     performance AS (
         SELECT
             (tp.total_produced / (th.total_hours * apr.rate)) AS performance_percentage
         FROM
             (
                 SELECT
                     SUM(pr.quantity) AS total_produced
                 FROM
                     products pr
                 WHERE
                     pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
             ) tp,
             (
                 SELECT
                     SUM(EXTRACT(EPOCH FROM (LEAST(sh.endTime, '2024-01-31T23:59:59Z'::TIMESTAMPTZ) - GREATEST(sh.startTime, '2024-01-01T00:00:00Z'::TIMESTAMPTZ))) / 3600) AS total_hours
                 FROM
                     work_orders wo
                         INNER JOIN shifts sh ON wo.assetId = sh.assetId
                 WHERE
                     wo.assetId = 1
                   AND wo.status BETWEEN 1 AND 2
                   AND sh.startTime < '2024-01-31T23:59:59Z'::TIMESTAMPTZ
                AND (sh.endTime IS NULL OR sh.endTime > '2024-01-01T00:00:00Z'::TIMESTAMPTZ)
             ) th,
             (
                 SELECT
                     SUM(pr.quantity) / SUM(EXTRACT(EPOCH FROM (pr.endTime - pr.startTime)) / 3600) AS rate
                 FROM
                     products pr
                 WHERE
                     pr.status = 1
                   AND pr.assetId = 1
                   AND pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
             ) apr
     ),
     quality AS (
         SELECT
             (ps.total_produced - ps.total_bad)::FLOAT / ps.total_produced AS quality_percentage
         FROM
             (
                 SELECT
                     SUM(pr.quantity) AS total_produced,
                     SUM(pr.badQuantity) AS total_bad
                 FROM
                     products pr
                 WHERE
                     pr.endTime BETWEEN '2024-01-01T00:00:00Z'::TIMESTAMPTZ AND '2024-01-31T23:59:59Z'::TIMESTAMPTZ
             ) ps
     )
SELECT
    av.availability_percentage,
    pe.performance_percentage,
    qu.quality_percentage
FROM
    availability av,
    performance pe,
    quality qu;
```


### Calculate the stop reasons of our machine

In this example, we calculate the stop reasons of our machine.
The output will be a table with the stop reasons and the time and length of the stops.

```sql
WITH stop_reasons AS (
    SELECT
        st.state AS stop_reason,
        st.startTime,
        st.endTime,
        COALESCE(st.endTime, NOW()) - st.startTime AS duration
    FROM
        states st
    WHERE
        st.assetId = 1
      AND (st.state < 10000 OR st.state > 29999)
      AND st.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
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
    SELECT
        sh.startTime,
        sh.endTime
    FROM
        shifts sh
    WHERE
        sh.assetId = 1
      AND sh.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
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
    SELECT
        wo.startTime,
        wo.endTime
    FROM
        work_orders wo
    WHERE
        wo.assetId = 1
      AND wo.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
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
    SELECT
        st.state AS stop_reason,
        st.startTime,
        st.endTime,
        COALESCE(st.endTime, NOW()) - st.startTime AS duration
    FROM
        states st
    WHERE
        st.assetId = 1
      AND (st.state < 10000 OR st.state > 29999)
      AND st.startTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
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
    SELECT
        time_bucket('5 minutes', pr.endTime) AS bucket,
        COUNT(pr.productId) AS products
    FROM
        products pr
    WHERE
        pr.assetId = 1
      AND pr.endTime BETWEEN '2024-01-01 00:00:00' AND '2024-12-31 23:59:59'
    GROUP BY
        bucket
)
SELECT
    bucket,
    products AS total_products
FROM
    production_speed
ORDER BY
    bucket;
```

## Dynamic queries

If you want to dynamically execute the queries based on your selected timeframe in Grafana, you can replace the hardcoded timeframes with Grafana variables.

For example, to select all work orders within the selected time frame, you can use the following query:

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
  AND wo.startTime BETWEEN $__timeFrom() AND $__timeTo()
```