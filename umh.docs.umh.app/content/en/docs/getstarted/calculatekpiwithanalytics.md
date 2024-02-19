---
title: 6. (optional) Calculating business KPIs such as OEE with _analytics
menuTitle: 6. (optional) Calculating business KPIs such as OEE with _analytics
description: Generate business KPIs such as OEE with _analytics
weight: 6000
draft: true
---

This chapter we build a simple example of how to calculate business KPIs such as OEE with _analytics.
The first part will be setting up a printing machine and the second part will be calculating the OEE.

## Setting up a printing machine

In these steps we will setup a simple printing machine using Node-RED.
If you are not interested in the setup, you can import the flow from [here](/json/getstarted/flows.json).

This guide assumes that you have some basic knowledge of Node-RED. If you are new to Node-RED, you can find a good introduction [here](https://nodered.org/docs/tutorials/first-flow/).

### Creating the product-type/create function

Before producing anything our system first needs to know what we are producing. This is done by creating a product-type. In this example we will create a product-type called "otto-poster" (Prints of our beloved mascot Otto).
Therefore, we create an inject node and a mqtt node (to publish the product-type to the UNS).
Since we are dealing with a printer, we use a low cycle time of 10 milliseconds.

1. Drag an inject node from the palette to the flow.
2. Double-click the inject node and set the payload to:
```json
{
  "externalProductID": "otto-poster",
  "cycleTime": 10
}
```
3. Set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product-type/create`.
4. Drag an mqtt out node from the palette to the flow.
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.

### Creating the shift/add function

In order to calculate the OEE, we need to know when a shift starts and ends. Therefore, we create a shift. In this example our shift will be 8 hours long, beginning now.
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
7. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
8. Connect the inject node to the function node and the function node to the mqtt node.
9. Deploy the flow.

### Creating the work-order/create function

Now that we have a product-type and a shift, we can create a work-order. In this example we will create a work-order for 7500 "otto-poster" prints.
Each work-order has an work order id, which is unique per asset. In this example we will use the work order id "#1247".
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
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.

### Creating the work-order/start function

We are ready to start the work-order. This is done by creating a work-order/start event. In this example we will start the work-order "#1247", which we created in the previous step.

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
7. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
8. Connect the inject node to the function node and the function node to the mqtt node.
9. Deploy the flow.


### Creating the state machine

This step is quite complex. We will create a state machine to simulate the printing process.
It will listen for the work-order/start event and then simulate produce the prints.
While producing it will change to different states, and might output some failed prints.

1. Drag an mqtt in node from the palette to the flow.
2. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server and set the topic to `umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/start`.
3. Drag a function node from the palette to the flow. This function will setup the state machine.
4. Double-click the function node and set the following code:
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
5. Connect the mqtt node to the function node.
6. Drag a switch node from the palette to the flow. This node will stop the process when the work-order is finished.
7. Set the switch node to check if `msg.payload.produced` is greater than or equal to `7500` (the quantity of the work-order).
8. Add another rule to check if `msg.payload.produced` is less than `7500`.
9. Connect the function node to the switch node.
10. Drag a function node from the palette to the flow. This function will handle the end of the work-order.
11. Double-click the function node and set the following code:
```javascript
// We produced every product in this order, so let's stop it
msg.payload = {
    "externalWorkOrderId": "#1247",
    "endTime": Date.now(),
}
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/work-order/stop";
return msg;
```
12. Connect the first rule (top output) of the switch node to the function node.
13. Drag an mqtt out node from the palette to the flow.
14. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the function node.
15. Connect the function node from step 10 to the mqtt node.
16. Now we will create the loop for the state machine.
17. Drag a function node from the palette to the flow. This function will simulate state changes.
18. Double-click the function node and set the following code:
```javascript
const now = Date.now();
const lastChange = msg.payload.state.lastchange;
const duration = now - lastChange;
const cycleTime = 10;

msg.delay = cycleTime;

// Function to calculate dynamic delay
function calculateDynamicDelay(duration, startDelay, endDelay, rampTime) {
    if (duration >= rampTime) return endDelay;
    const delayRange = startDelay - endDelay;
    const delayStep = delayRange / rampTime;
    return startDelay - (delayStep * duration);
}

switch (msg.payload.state.id) {
    case 10000:
        // ProducingAtFullSpeedState
        // After 10 seconds it has a 10% chance of changing the state
        if (Math.random() < 0.1 && duration >= 10000) {
            if (Math.random() < 0.5) {
                // Simulate a CleaningState
                msg.payload.state.id = 110000;
                msg.payload.state.lastchange = Date.now();
            } else {
                // Simulate an OutletJamState
                msg.payload.state.id = 70000;
                msg.payload.state.lastchange = Date.now();
            }
        }
        break;
    case 20000:
        // ProducingAtLowerThanFullSpeedState
        // The machine takes 30s to ramp to full speed
        if (duration >= 30000) {
            msg.payload.state.id = 10000;
            msg.payload.state.lastchange = Date.now();
        }
        // Calculate dynamic delay starting from 500 to 100 over 30 seconds
        msg.delay = calculateDynamicDelay(duration, 500, 100, 30000);
        break;
    default:
        if (msg.payload.state.id == 110000) {
            // We have a cleaning state, this one takes 10 seconds to complete
            if (duration >= 10000) {
                // Machine needs to ramp up after cleaning
                msg.payload.state.id = 20000;
                msg.payload.state.lastchange = Date.now();
            }
        } else if (msg.payload.state.id == 70000) {
            // We have an outlet jam state, this one takes 15 seconds to complete
            if (duration >= 15000) {
                // Machine needs to ramp up after fixing the jam
                msg.payload.state.id = 20000;
                msg.payload.state.lastchange = Date.now();
            }
        }
}

if (msg.payload.state.id < 30000) {
    return [null, msg];
}

return [msg, null];
```
19. Ensure that "Outputs" is set to 2 in the function node.
20. Connect the second rule (bottom output) of the switch node to the function node.
21. We will now create the flow to publish state changes to the UNS.
22. Drag a filter node from the palette to the flow. This node will filter out the state changes.
23. Set the filter node to block unless value changes and set the property to `msg.payload.state.id`.
24. Connect both outputs of the function node from step 17 to the filter node.
25. Drag a function node from the palette to the flow. This function will publish the state changes to the UNS.
26. Double-click the function node and set the following code:
```javascript
// We have a state change, let's publish it
msg.payload = {
    "startTime": Date.now(),
    "state": msg.payload.state.id
};
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/state/add";

return msg;
```
27. Connect the filter node to the function node.
28. Drag an mqtt out node from the palette to the flow.
29. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the function node.
30. Connect the function node from step 25 to the mqtt node.
31. Now we will create the producer functions.
32. Drag a function node from the palette to the flow. This function will increase the produced amount.
33. Double-click the function node and set the following code:
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
35. Connect the bottom output of the function node from step 17 to the function node.
36. Create another function node from the palette to the flow. This function will publish the produced amount to the UNS.
37. Double-click the function node and set the following code:
```javascript
// An insecure implementation of uuid4
// It's fine for this example but shouldn't be used in production
// See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random for more details
function uuid4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

msg.payload = {
    "externalProductTypeId": "otto-poster",
    "productId": uuid4(),
    "endTime": Date.now(),
    "quantity": 1
};
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product/add";

// 5% chance of a bad product
const failureChance = 0.05;

if (Math.random() < failureChance){
    return [msg, msg];
}

return [msg, null];
```
38. Ensure that "Outputs" is set to 2 in the function node.
39. Connect the bottom output of the function node from step 33 to the function node.
40. Drag a mqtt out node from the palette to the flow.
41. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the function node.
42. Connect the top output of the function node from step 37 to the mqtt node.
43. Create a function node from the palette to the flow. This function will randomly scrap some products.
44. Double-click the function node and set the following code:
```javascript
// This works for us, as we produce one at a time
msg.badQuantity = msg.quantity;

// setBadQuantiy doesn't have these keys, so we just delete them
delete msg.quantity;
delete msg.productId;

msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product/setBadQuantity";
return msg;
```
45. Connect the bottom output of the function node from step 37 to the function node.
46. Drag a mqtt out node from the palette to the flow.
47. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the function node.
48. Connect the function node from step 43 to the mqtt node.
49. Great, now we just need to create a feedback loop to continue the state machine.
50. Drag a delay node from the palette to the flow.
51. Set the delay node to 10 milliseconds.
52. Set "Fixed Delay" to "Override delay with msg.delay".
53. Connect the top output of the function node from step 33 to the delay node.
54. Connect the top output of the delay node to the function node from step 17.
55. Connect the delay node to the switch node from step 6.
56. Deploy the flow.


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
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
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
5. Configure the mqtt node to use `united-manufacturing-hub-mqtt` as the Server, you can leave the topic empty as we have already set it in the inject node.
6. Connect the inject node to the mqtt node.
7. Deploy the flow.
8. Click the inject node to overwrite the state.