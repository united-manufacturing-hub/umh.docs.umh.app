+++
title = "Data Acquisition and Manipulation"
menuTitle = "Data Acquisition and Manipulation"
description = ""
weight = 3000
+++



The United Manufacturing Hub has several simulators. These simulators simulate different data types/protocols such as MQTT, PackML or OPCU/UA. In this chapter we will take the MQTT simulated data and show you how to format it into the UMH data model.


### Creating Node-RED flow with simulated MQTT-Data

1. Access Node-RED with UMHLens.
2. Drag from the left coulmn a **mqtt-in-** , **mqtt-out-** and a **debug-node** into your flow.
3. Connect the **mqtt-in** and the **debug-node**.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqMan1.png)
4. Double click the mqtt-in-node and add a new mqtt broker. Therefore, click on edit and use the service name of hivemq as host (located in UMHLens under services→name). Leave the port as autoconfigured and click on **Add**.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManServicename.png)
5. to see all incomming messages from a specific topic type in `ia/#` under **Topic** and click on **Done**. 

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManiaRaw.png)
6. To make the changes effective we need to click **Deploy** on the top right. Now to see the debug-information, click on the **Debug-messages** under **Deploy**. 

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManDebugDeploy.png)
7. In this column, we can see all the incoming messages and their respective topic. The incoming topics have the format `ia/raw/development/ioTSensors/`. For this tutorial, we are only using the temperature topic, but you can choose whatever you want. Now copy the temperature topic (`ia/raw/development/ioTSensors/Temperature`) , open the **mqtt-in node** and paste the copied topic in **Topic**. Click **Done** and press again **Deploy**.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewTopic.png)
8. Next we need to format the message. In order to do that, drag a json node and a function node into your flow. Now connect the following: mqtt in → json→ function → mqtt out.

   ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewNodes.png)
9. Open the **function** node and paste in the following:

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

10. Drag in another mqtt-in node and give it the topic: `ia/factoryinsight/Aachen/testing/processValue` (Topic of the mqtt-out-node configured in the function-node). Connect a debug node to your new mqtt-in node and hit deploy. 

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewDebug.png)
11. We can now see our new converted message under Debug-messages. You can clear the old messages by clicking the trash bin.

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManDebugWindow.png)
12. Congratulations! You have now successfully converted the incoming message and exported it via mqtt. Since we are now only exporting the temperature but not actually working with the data, we want to create a function that counts the critical temperature exceedances.
13. Drag another **function-node** into your flow, open it and navigate to On Start.

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManOnStart.png)
14. Paste in the following code, which will only run on start:

```jsx
flow.set("count", 0);
flow.set("current", 0)
```

15. Then click on **On-Message** and paste in the following and hit done:

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
    [Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManTemperatureWarning.png)
16. Finally, connect the function-node like shown below and hit deploy.

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManNewFunction.png)
17. If the incoming value of temperature is now greater than 47, you will see another message consisting of TemperatureWarning and a timestamp in debug-messages.

    ![Untitled](/images/getstarted/dataAcquisitionManipulation/getStartedDataAcqManGreaterThan.png)


## What's next?

Next up is data visualization.