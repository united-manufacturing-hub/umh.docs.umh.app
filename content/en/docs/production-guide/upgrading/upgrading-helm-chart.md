---
title: "Upgrading the Helm Chart"
description: "Upgrading the United Manufacturing Hub is done by upgrading the Helm chart."
---
Upgrading a Helm chart in UMHLens allows you to update the deployment of your services to the latest version. This tutorial will guide you through the process of adding the Helm repository in UMHLens, deleting previous deployments and stateful sets, and upgrading the release in the Helm tab. Please note that this process may not be smooth and may require some manual work. Follow the instructions carefully to successfully upgrade your Helm chart. Additionally make sure you also follow the steps to upgrade from a specific version to another. 

## Instructions

Step-by-step:

1. Add Helm repo in UMHLens (Preferences>Kubernetes>Helm Chart “repo.umh.app”).
    
    ![picture_1.jpg](/images/production-guide/upgrading/upgrading-helm-chart/picture_1.jpg)
    
    ![picture_2.jpg](/images/production-guide/upgrading/upgrading-helm-chart/picture_2.jpg)
    
    ![picture_3.png](/images/production-guide/upgrading/upgrading-helm-chart/picture_3.png)
    
2. Connect to Cluster via UMHLens
3. Open the Workloads tab
    1. Delete stateful set of `node-red`, `barcodereader`, `sensorconnect`, `mqttbridge`, `hivemqce` , there might be some missing if you have not activated those services
        
        ![picture_4.jpg](/images/production-guide/upgrading/upgrading-helm-chart/picture_4.jpg)
        
    2. Delete deployments of `factoryinsight`, `iotsensorsmqtt`, `kafka-to-postgres`, `opcuasimulator` and `mqttkafkabridge` 
        
        ![picture_5.png](/images/production-guide/upgrading/upgrading-helm-chart/picture_5.png)
        
4. Open the Helm tag
    1. Click on Releases
    2. Click on the release that you want to upgrade and click update
        
        ![picture_6.png](/images/production-guide/upgrading/upgrading-helm-chart/picture_6.png)
        

<aside>
{{% notice warning %}}  ️ If a warning appears regarding deployments or statefulset, try deleting these and trying again. The upgrade process in is not smooth yet and requires some manual work.  {{% /notice %}} 

</aside>
