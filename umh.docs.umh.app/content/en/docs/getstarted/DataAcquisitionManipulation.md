[_index.md](_index.md)+++
title = "Get Started!"
menuTitle = "Get Started!"
description = "You want to get started right away? Go ahead and jump into the action!"
weight = 1000
+++

We are glad that you want to start setting up right away! This guide is divided into 5 steps: Installation, Managing the System,
Data Acquisition & Manipulation and Moving it to Production.


## Data Acquisition and Manipulation

The United Manufacturing Hub has several simulators. These simulators simulate different data types/protocols such as MQTT, PackML or OPCU/UA. In this chapter we will take the MQTT simulated data and show you how to format it into the UMH data model.

**Creating Node-RED flow with simulated MQTT-Data**

1. Access Node-RED with UMHLens getStartedDataAcqMan1
2. Drag from the left coulmn a **mqtt-in-** , **mqtt-out-** and a **debug-node** into your flow.
3. Connect the **mqtt-in** and the **debug-node**.
   ![Untitled](/images/getStartedDataAcqMan1)
4. Double click the mqtt-in-node and add a new mqtt broker. Therefore, click on edit and use the service name of hivemq as host (located in UMHLens under services→name). Leave the port as autoconfigured and click on **Add**
5. ![Untitled](/images/getStartedDataAcqManServicename)
6. to see all incomming messages from a specific topic type in `ia/#` under **Topic** and click on **Done**. 
   ![Untitled](/images/getStartedDataAcqManiaRaw)
7. To make the changes effective we need to click **Deploy** on the top right. Now to see the debug-information, click on the **Debug-messages** under **Deploy**. 
   ![Untitled](/images/getStartedDataAcqManDebugDeploy)
8. In this column, we can see all the incoming messages and their respective topic. The incoming topics have the format `ia/raw/development/ioTSensors/`. For this tutorial, we are only using the temperature topic, but you can choose whatever you want. Now copy the temperature topic (`ia/raw/development/ioTSensors/Temperature`) , open the **mqtt-in node** and paste the copied topic in **Topic**. Click **Done** and press again **Deploy**.
   ![Untitled](/images/getStartedDataAcqManNewTopic)
9. Next we need to format the message. In order to do that, drag a json node and a function node into your flow. Now connect the following: mqtt in → json→ function → mqtt out.
   ![Untitled](/images/getStartedDataAcqManNewNodes)
10. Open the **function** node and paste in the following:

```jsx
msg.payload ={
    
    "timestamp_ms": Date.now(), 
    "temperature": parseFloat(msg.payload, 10)
}

msg.topic = "ia/factoryinsight/Aachen/testing/processValue";

return msg;
```

Quick explanation: We are creating a new object (array) with two keys`timestamp_ms` and `temperature` and their corresponding value `Date.now()` and `parseFloat(msg.payload,10)`.

The `parseFloat` function converts the incoming string into a float with the base 10 and the `Date.now()` creates a timestamp.

We also created a `msg.topic` for the **mqtt-out node**, which will automatically apply this topic, and therefore we don't need to configure the **mqtt-out node,** but we still have to open **our mqtt-out-node** and select the created broker.

11. Drag in another mqtt-in node and give it the topic: `ia/factoryinsight/Aachen/testing/processValue` (Topic of the mqtt-out-node configured in the function-node). Connect a debug node to your new mqtt-in node and hit deploy. 
    ![Untitled](/images/getStartedDataAcqManNewDebug)
12. We can now see our new converted message under Debug-messages. You can clear the old messages by clicking the trash bin.
    ![Untitled](/images/getStartedDataAcqManDebugWindow)
13. Congratulations! You have now successfully converted the incoming message and exported it via mqtt. Since we are now only exporting the temperature but not actually working with the data, we want to create a function that counts the critical temperature exceedances.
14. Drag another function-node into your flow, open it and navigate to On Start.
    ![Untitled](/images/getStartedDataAcqManOnStart)
15. 15. Paste in the following code, which will only run on start:

```jsx
flow.set("count", 0);
flow.set("current", 0)
```

16. Then click on **On-Message** and paste in the following and hit done:

```jsx
flow.set("current",msg.payload);
if (flow.get("current")>47){
    flow.set("count", flow.get("count")+1);
    msg.payload = {"TemperatureWarning":flow.get("count"),"timestamp_ms":Date.now()}
    msg.topic = "ia/factoryinsight/Aachen/testing/processValue";
    return msg;
}
```

The pasted in code will work as shown in the diagram below.
    [Untitled](/images/getStartedDataAcqManTemperatureWarning)
17. Finally, connect the function-node like shown below and hit deploy.
    ![Untitled](/images/getStartedDataAcqManNewFunction)
18. If the incoming value of temperature is now greater than 47, you will see another message consisting of TemperatureWarning and a timestamp in debug-messages. getStartedDataAcqManGreaterThan
    ![Untitled](/images/getStartedDataAcqManGreaterThan)


## What's next?
t