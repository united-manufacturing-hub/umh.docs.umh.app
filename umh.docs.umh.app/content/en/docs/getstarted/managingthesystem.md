+++
title = "2. Managing the System"
menuTitle = "2. Managing the System"
description = "Basics of UMHLens and importing Node-RED and Grafana flows"
weight = 2000
+++

In this chapter, we'll guide you through connecting to our Kubernetes cluster using UMHLens. Then, we'll walk you through importing a [Node-RED](https://learn.umh.app/guides/troubleshootingcommunity/node-red/nodered-import-export/) and Grafana flow to help you visualize how data flows through the stack. Check out the image below for a sneak peek


![Untitled](/images/getstarted/managingTheSystem/getStartedUMHSimplifiedpng.png)

##  1. Connect to UMH

1. Download & install UMHLens [here](https://github.com/united-manufacturing-hub/UMHLens/releases).
2. If you installed the UMH using the management console, you should see a cluster named "k3d-united-manufacturing-hub" under **Browse**. Click on it to connect.
3. On the right side of UMHLens under **workloads** -> **pods** you can check the status of all pods. Depending on your system, it may take a while for all pods to start.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingPods.png?width=75%)
4. To access the web interfaces of the microservices, e.g. node-red or grafana, navigate to **network**->**services** on the left-hand side.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingServices.png?width=75%)
5. Click on the appropriate service you wish to connect to, scroll down to **Connection** and forward the port.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingForwarding.png?width=75%)


## 2. Import flows to Node-RED

1. Access the Node-RED Web UI. To do this, click on the service and forward the port as shown above. When the UI opens in the browser, add `nodered` to the URL as shown in the figure below to avoid the [cannot get error]().

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingCannotGet.png?width=75%)
2. Once you are in the web interface, click on the three lines in the upper right corner and select **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingImport.png?width=75%)

3. Now copy [this json file](/json/getstarted/noderedGetStarted.json) and paste it into the import field. Then press **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingPasteJson.png?width=75%)
4. To activate the imported flow, simply click on the **Deploy** button located at the top right of the screen. If everything is working as expected, you should see green dots above the input and output. Once you've confirmed that the data is flowing correctly, you can proceed to display it in Grafana
   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingDeploy.png?width=75%)


## 3. Import flows to Grafana & view dashboard

1. Go into UMHLens and forward the grafana service as you did with node-red. To log in, you need the grafana Secrets, which you can find in UMHLens under **Config** -> **Secrets** -> **Grafana-Secret**. Click on the eye to display the username and password and enter it in grafana.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaSecrets.png?width=75%)
2. Once you are logged in, click on **Dashboards** on the left and select **Import**. Now copy [this Grafana json](/json/getstarted/GrafanaGetStarted.json) and paste it into **Import via panel json**. Then click on **Load**. You will then be redirected to **Options** where you need to select the **umh-v2-datasource**. Finally, click on **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaImport.png?width=75%)
3. If everything is working properly, you should now see a functional dashboard with a temperature curve.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaDashboard.png?width=75%)


## What's next?

Next, you can create a node-red flow for yourself and then learn how to create a dashboard in Grafana. Click [here](/docs/getstarted/dataacquisitionmanipulation) to proceed.