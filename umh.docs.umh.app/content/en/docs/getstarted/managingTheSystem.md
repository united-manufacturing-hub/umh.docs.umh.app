+++
title = "Managing the System"
menuTitle = "Managing the System"
description = "You want to get started right away? Go ahead and jump into the action!"
weight = 1000
+++

## Managing the System

**Setting up UMHLens**

1. Download & install UMHLens [here]().
2. If you installed the UMH using the management console, you should see a cluster named "k3d-unite-manufacturing-hub" under Browse. Click on it to connect.3. On the right sied of umhlens under workloads-pods you can check the status of all the pods. Depending on your system it may take a while until all pods start. 
   ![Untitled](/images/getStartedManagingPods.png)
3. To access the web interfaces of the microservices, e.g. node-red or grafana, navigate to network->services on the left-hand side.
   ![Untitled](/images/getStartedManagingservices.png)
4. Click on the appropriate service you wish to connect to, scroll down to "Connection" and forward the port.
   ![Untitled](/images/getStartedManagingForwarding.png)


**Importing Node-RED flows**

1. Access the Node-RED Web UI. To do this, click on the service and forward the port as shown above. When the UI opens in the browser, add "nodered" to the URL as shown in the figure below to avoid the "cannot get" error.
   ![Untitled](/images/getStartedManagingCannotGet.png)
2. Once you are in the web interface, click on the three lines in the upper right corner and select "Import".
   ![Untitled](/images/getStartedManagingImport.png)
3. Now copy this json file and paste it into the import field. Then press "Import".
   ![Untitled](/images/getStartedManagingPasteJson.png)
4. To activate the imported flow, you need to press deploy at the top right. If everything works, you should see green dots above the input and output. If this is the case, you can now display this data in grafana.
   ![Untitled](/images/getStartedManagingDeploy.png)


**Importing Grafana flow**

1. Go into UMhLens and forward the grafana service as you did with node-red. To log in, you need the grafana Secrets, which you can find in UMHLens under Config->Secrets->Grafana-Secret. Click on the eye to display the username and password and enter it in grafana.
   ![Untitled](/images/getStartedManagingGrafanaSecrets.png)
2. Once you are logged in, click on **Dashbaords** on the left and select **Import**. Now copy the Grafana json below and paste it into **Import via panel json**. Then click on **Load**. You will then be redirected to **Options** where you need to select the **umh-v2-datasource**. Finally, click on **Import**.
   ![Untitled](/images/getStartedManagingGrafanaImport.png)
3. If everything is working properly, you should then see the functioning dashboard with a temperature curve.
   ![Untitled](/images/getStartedManagingGrafanaDashboard.png)


## What's next?

Next you can create a node-red flow for yourself and then learn how to create a Dashboard in Grafana.