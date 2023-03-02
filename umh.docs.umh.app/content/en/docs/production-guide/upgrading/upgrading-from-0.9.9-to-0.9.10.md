---
title: "Upgrading v0.9.9 to v0.9.10"
description: "During the Helm Chart upgrade from v0.9.9 to 0.9.10 the following steps need to executed additionally to the following guide."
minimum_version: 0.9.9
maximum_version: 0.9.10
---

For every Helm Chart upgrade, the steps in the following guide need to be executed.

[**Upgrading the Helm Chart**](./upgrading-helm-chart)

Additionally, the following are the steps to upgrade from v0.9.9 to v0.9.10.

## Steps before upgrading

### New Grafana version

In this release we updated the Grafana version from 8.5.9 to 9.3.1. Check the [release notes](https://grafana.com/docs/grafana/latest/whatsnew/) for further information about possible breaking changes that could affect you.

### Grafana

If you don’t have any custom Grafana plugins installed, **skip to step 4.**

1. From Grafana, navigate to the Plugins section inside the Configuration tab
2. Make sure that only the installed plugins are selected
    
    ![Show installed grafana plugins](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/installed.png)
    
3. Write down all the plugins that you manually installed. You can recognize them by **not** having the `Core` tag. Also, the following ones already come with the UMH stack, thereby you don’t need to note them.
    - ACE.SVG by Andrew Rodgers
    - Button Panel by UMH Systems Gmbh
    - Button Panel by CloudSpout LLC
    - Discrete by Natel Energy
    - Dynamic Text by Marcus Olsson
    - FlowCharting by agent
    - Pareto Chart by isaozler
    - Pie Chart (old) by Grafana Labs
    - Timepicker Buttons Panel by williamvenner
    - UMH Datasource by UMH Systems Gmbh
    - Untimely by factry
    - Worldmap Panel by Grafana Labs
    
    ![Image of core and signed plugins](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/core_signed.png)
    
4. From Lens, under Deployments, remove the Grafana deployment. This will cause a brief downtime, but no data will be lost.
5. Now you can proceed with the other steps on this guide before upgrading.

### Updating the Grafana init container

1. Search for “grafana-plugin-extractor”
2. Replace
    
    ```yaml
    extraInitContainers:
      - image: unitedmanufacturinghub/grafana-plugin-extractor:0.1.4
        imagePullPolicy: IfNotPresent
        name: init-umh-datasource
        volumeMounts:
        - mountPath: /var/lib/grafana
          name: storage
    ```
    
3. With
    
    ```yaml
    extraInitContainers:
        - image: unitedmanufacturinghub/grafana-umh:1.1.2
          name: init-plugins
          imagePullPolicy: IfNotPresent
          command: ['sh', '-c', 'cp -r /plugins /var/lib/grafana/']
          volumeMounts:
            - name: storage
              mountPath: /var/lib/grafana
    ```
    

### Increasing the Kafka memory limit

1. Open Lens and navigate to Helm > Releases and press on Upgrade.
    
    ![Lens, upgrade deployment](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/lens_upgrade_deployment.png)
    
2. You will be presented with the `values.yaml` file. Press `CTRL + F` to open the search menu.
3. Type `cpu: 1000m` and find the line that matches that value in the `kafka` section.
    
    ![Lens, set resource limits](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/lens_set_limits.png)
    
4. Replace these lines:
    
    ```yaml
    resources:
        limits:
          cpu: 1000m
          memory: 1Gi
        requests:
          cpu: 100m
          memory: 250Mi
    ```
    
    with these
    
    ```yaml
    resources:
        limits:
          cpu: 1000m
          memory: 4Gi
        requests:
          cpu: 100m
          memory: 2560Mi
    ```
    
    1. Ensure, that the indentation is correct
        1. Wrong
            
            ![Lens, wrong indentation](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/lens_wrong_indentation.png)
            
        2. Correct
            
            ![Lens, correct indentation](/images/production-guide/upgrading/upgrading-from-0.9.9-to-0.9.10/lens_correct_indentation.png)
            
5. Now search for `heapOpts`
    1. If you can’t find the line, go back to your previous search (by searching again) and add the heapOpts line, so it looks like this
        
        ```yaml
        resources:
            limits:
              cpu: 1000m
              memory: 4Gi
            requests:
              cpu: 100m
              memory: 2560Mi
        heapOpts: -Xmx2048m -Xms2048m
        ```
        
    2. If the line is already existing, check if the Xmx and Xms values are at least 2048m and lower then the request.memory

Once you completed all the previous steps, you can press the upgrade button.

## Steps after upgrading

After the upgrade is successful, you need to follow these additional steps.

### Replacing VerneMQ with HiveMQ (recommended)

In this upgrade we switched from using VerneMQ to HiveMQ as our MQTT Broker (you can read our [blog article](https://www.umh.app/post/comparing-mqtt-brokers-for-the-industrial-iot) if you want to learn more about this). While this process is fully backwards compatible, we suggest to update NodeRed flows, and any other additional service that uses MQTT, to use the new broker called `united-manufacturing-hub-mqtt`. The old `united-manufacturing-hub-venremq` is still functional and despite the name also uses HiveMQ, but in future upgrades will be removed.

Additionally, it is highly recommended to enable password authentication for MQTT in a production environment. Follow this guide to learn how:

[Enabling RBAC for MQTT Broker](/docs/production-guide/security/hivemq-rbac)

Also, all services might now communicate via encrypted MQTT (MQTTS).

<aside>
{{% notice warning %}}  ️ Please double-check if all of your services can connect to the new MQTT broker. It might be needed for them to be restarted, so that they can resolve the DNS name and get the new IP. Also, it can happen with tools like chirpstack, that you need to specify the client-id as the automatically generated ID worked with VerneMQ, but is now declined by HiveMQ.  {{% /notice %}} 

</aside>
