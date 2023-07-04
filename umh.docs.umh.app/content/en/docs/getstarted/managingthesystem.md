+++
title = "2. Managing the System"
menuTitle = "2. Managing the System"
description = "Basics of UMHLens and importing Node-RED and Grafana flows"
weight = 2000
+++

  In this chapter, we will guide you through the installation of your first local 
  instance of the UMH using the Management Console. We will also explain how the
  basic components work together. Check out the image below for a general overview:

![Untitled](/images/getstarted/managingTheSystem/getStartedUMHSimplifiedpng.png)

  The United Manufacturing Hub is a collection of microservices, which work
  together, to provide a complete solution for your manufacturing needs. From 
  data collection to contextualization and visualization, or data storage:
  the UMH provides every tool you need. In the rare case, that you need a special 
  feature, you can add it to the UMH by creating your own custom microservice.

##  Install the UMH

1. In case you have not done it on the previous page, download and install
   the Management Console from [here](https://mgmt.docs.umh.app/docs/getstarted/download/)
   and follow the instructions.
2. First, create an account. Since this is your first installation, you will be
   guided by a tutorial which helps you to install the UMH on your local machine.

   {{% notice note %}}
   A local installation is the similar to an installation on an external device,
   like an edge device or a VM. The benefit is, that you can easily set it up
   without any additional hardware and learn how to use it.
   {{% /notice %}}

3. After creating your instance of the UMH, you will be able to access the local 
   installation by clicking on the tile.
   You will open the device overview, where you can see every microservice of
   the stack and access and configure them. While the components of the UMH 
   stack are installed and starting, the icons
   of the services will be red or white. Once the services are running, the icons 
   will turn green. Continue to follow the tutorial, to
   learn how to create Node-RED flows and Grafana Dashboards.

4. To access the web interfaces of the microservices, e.g. node-red or grafana, 
   click on the microservice in the device overview and click on the **open** 
   button.

<!---
## 2. Import flows to Node-RED

1. Access the Node-RED Web UI. To do this, click on the service in the 
  Management Console
 above. When the UI opens 
   in the browser, add `nodered` to the URL as shown in the figure below to avoid the [cannot get error](https://learn.umh.app/course/how-to-fix-cannot-get-error-in-node-red/).

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingCannotGet.png?width=75%)
2. Once you are in the web interface, click on the three lines in the upper right corner and select **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingImport.png?width=75%)

3. Now copy [this json file](/json/getstarted/noderedGetStarted.json) and paste it into the import field. Then press **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingPasteJson.png?width=75%)
4. To activate the imported flow, simply click on the **Deploy** button located at the top right of the screen. 
   If everything is working as expected, you should see green dots above the input and output. Once you've confirmed 
   that the data is flowing correctly, you can proceed to display it in Grafana
   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingDeploy.png?width=75%)


## 3. Import flows to Grafana & view dashboard

1. Go into UMHLens and forward the grafana service as you did with node-red. To log in, you need the grafana Secrets, 
   which you can find in UMHLens under **Config** -> **Secrets** -> **Grafana-Secret**. Click on the eye to display the username and password and enter it in grafana.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaSecrets.png?width=75%)
2. Once you are logged in, click on **Dashboards** on the left and select **Import**. Now copy [this Grafana json](/json/getstarted/GrafanaGetStarted.json) and paste it into **Import via panel json**. Then click on **Load**. You will then be redirected to **Options** where you need to select the **umh-v2-datasource**. Finally, click on **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaImport.png?width=75%)
3. If everything is working properly, you should now see a functional dashboard with a temperature curve.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaDashboard.png?width=75%)
-->

## What's next?

Next, you can create a node-red flow for yourself and then learn how to create a dashboard in Grafana. Click [here](/docs/getstarted/dataacquisitionmanipulation) to proceed.