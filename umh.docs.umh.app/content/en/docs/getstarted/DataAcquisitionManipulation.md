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
4. Double click the mqtt-in-node and add a new mqtt broker. Therefore click on edit and use the service name of hivemq as host (located in UMHLens under services→name). Leave the port as autoconfigured and click on **Add**
5. ![Untitled](/images/getStartedDataAcqManServicename)
6. to see all incomming messages from a specific topic type in `ia/#` under **Topic** and click on **Done**. 
   ![Untitled](/images/getStartedDataAcqManiaRaw)
7. To make the changes effective we need to click **Deploy** on the top right. Now to see the debug-information, click on the **Debug-messages** under **Deploy**. 
   ![Untitled](/images/getStartedDataAcqManDebugDeploy)
8. In this column, we can see all the incoming messages and their respective topic. The incoming topics have the format `ia/raw/development/ioTSensors/`. For this tutorial, we are only using the temperature topic, but you can choose whatever you want. Now copy the temperature topic (`ia/raw/development/ioTSensors/Temperature`) , open the **mqtt-in node** and paste the copied topic in **Topic**. Click **Done** and press again **Deploy**.