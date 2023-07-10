+++
title = "2. Managing the System"
menuTitle = "2. Managing the System"
description = "Learn the basics of the Management Console and how to import Node-RED and Grafana flows."
weight = 2000
+++

  In this chapter, we will guide you through the installation of your first 
  local instance of the UMH using the Management Console. We will also explain
  how the basic components work together. Check out the image below for an 
  overview:

![Untitled](/images/getstarted/managingTheSystem/getStartedUMHSimplifiedpng.png)

  The United Manufacturing Hub is a collection of microservices, which work
  together, to provide a complete solution for your manufacturing needs. From 
  data collection to contextualization and visualization, or data storage. 
  For rare cases that require a special feature, you can add it to your UMH
  stack by creating your own custom microservice.

## 1. Install the UMH

1. In case you have not done it on the previous page, download and install
   the Management Console from [here](https://mgmt.docs.umh.app/docs/getstarted/download/)
   and follow the instructions. When you are finished with the creation of the 
   account, continue on this site.

2. Since this is your first installation, you will be guided by a tutorial in 
   the Management Console, which helps you to install the UMH on your local 
   machine.


   {{% notice note %}}
   A local installation functions similar to an installation on an external device,
   like an edge device or a VM. The benefit is, that you can easily set it up
   without any additional hardware and learn how to use it with simulated data.
   {{% /notice %}}

3. After creating your instance of the UMH, you will be able to access the local 
   installation by clicking on the tile.
   You will open the device overview, where you can see every microservice of
   the stack and access and configure them. While the components of the UMH 
   stack are installed and starting, the icons
   of the services will be red or white. Once the services are running, the icons 
   will turn green. If you have a decent device, you should not be
   waiting longer then 5 minutes. On a slower computer, the start of your stack
   can take up to 15 minutes.

4. If you have no experience with Node-RED or Grafana, we recommend
   to follow the tutorial below.
   If you are already familiar with Node-RED and Grafana, you can skip the
   tutorial below and continue with the [next page](https://umh.docs.umh.app/docs/getstarted/dataacquisitionmanipulation/)
   of this guide, to learn about the UMH data model.

5. To access the web interfaces of the microservices, e.g. node-red or grafana, 
   click on the microservice in the device overview and click on the **open** 
   button.


## 2. Import flows to Node-RED
 
1. Open Node-RED by click on the tile in the device overview, then click on the
   **open** button. You will be redirected to the web interface of Node-RED.
<!--
  ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingCannotGet.png?width=75%)
-->
2. Once you are in the web interface, click on the three lines in the upper 
   right corner and select **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingImport.png?width=75%)

3. Now copy [this json file](/json/getstarted/noderedGetStarted.json) and paste
   it into the import field. Then press **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingPasteJson.png?width=75%)

{{% notice info %}}
Node-RED is a tool, to manage and connect data flows. Simply said, you can 
specify what data is processed how and then send where. 

Each flow starts with an input node, where you can specify the data source.
In this case, the data source is a simulated temperature sensor. After the json 
node, which is used to parse the data, it is then passed to a function node, 
where you can manipulate the data, for example add a timestamp or format it to
the correct unit.
After the manipulation or contextualization, the data is always passed on to
an output node, where you can specify the destination of the data.
{{% /notice %}}

4. To activate the imported flow, simply click on the **Deploy** button located
   at the top right of the screen. If everything is working as expected,
   you should see green dots above the input and output. Once you have confirmed 
   that the data is flowing correctly, you can proceed to display it in Grafana.
   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingDeploy.png?width=75%)


## 3. Import flows to Grafana & view dashboard

1. Go back to the Management Console, close the Node-RED popup and open the
   Grafana popup. Again, click on the **open** button, to access the Grafana 
   web interface. To log in, you need the Grafana log in credentials, which you
   can find in the Grafana popup. Click on the eye to display the username and 
   password and enter it in grafana.

2. Once you are logged in, click on **Dashboards** on the left and select
   **Import**. Now copy [this Grafana json](/json/getstarted/GrafanaGetStarted.json) and paste it into **Import via panel json**. Then click on **Load**. You will then be redirected to **Options** where you need to select the **umh-v2-datasource**. Finally, click on **Import**.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaImport.png?width=75%)
3. If everything is working properly, you should now see a functional dashboard
   with a temperature curve.

   ![Untitled](/images/getstarted/managingTheSystem/getStartedManagingGrafanaDashboard.png?width=75%)

## What's next?

  Next, you can create a Node-RED flow and learn how to create your own dashboard
  in Grafana. Click [here](/docs/getstarted/dataacquisitionmanipulation) 
  to proceed. This guide is also linked in the tutorial in the Management 
  Console.