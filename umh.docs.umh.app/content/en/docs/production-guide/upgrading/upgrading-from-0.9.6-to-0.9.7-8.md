---
title: "Upgrading v0.9.6 to v0.9.7/v0.9.8"
description: "During the Helm Chart upgrade from v0.9.6 to 0.9.7/8 the following steps need to executed additionally to the following guide."
minimum_version: 0.9.6
maximum_version: 0.9.8
---

## Instructions on upgrading

During the Helm chart upgrade from v0.9.6 to 0.9.7/8 the following steps need to executed additionally to the following guide:

[**Upgrading the Helm Chart**](./upgrading-helm-chart)

# Upgrading (after upgrading the Helm Chart)

1. Open UMHLens
2. Select Workloads → Pods
3. Click on one of the factoryinsight pods
4. Check that “VERSION” is set to 2
    
    ![Lens, show current version](/images/production-guide/upgrading/upgrading-from-0.9.6-to-0.9.7-8/lens_current_version.png)
    
    1. If this is *not* the case:
    2. Select Workloads → Deployments
    3. Click on the factoryinsight deployment and select “edit”
        
        ![Lens, edit factoryinsight deployment](/images/production-guide/upgrading/upgrading-from-0.9.6-to-0.9.7-8/lens_fa_deployment_edit.png)
        
    4. Search for the “Version” tag and set it to 2
        
        ![Lens, edit factoryinsight api version](/images/production-guide/upgrading/upgrading-from-0.9.6-to-0.9.7-8/lens_fa_deployment_editview_version.png)
        
    5. Click “Save & Close”
    6. Go back to Workloads → Pods
5. Click on the Grafana pod
6. Check that the Init Container’s image is unitedmanufacturinghub/grafana-plugin-extrator:0.1.3
    
    ![Lens, grafana plugin extractor version](/images/production-guide/upgrading/upgrading-from-0.9.6-to-0.9.7-8/lens_gf_plugin_extractor.png)
    
    1. If this is not the case:
    2. Remove the Stateful & Deployments, listed in the normal upgrade guid
    3. Goto Helm → Releases and click on the 3 dots left to united-manufacturing-hub
    4. Select “upgrade”
    5. Replace the extraInitContainers from grafana with:
        
        ```yaml
        extraInitContainers:
            - name: init-umh-datasource
              image: unitedmanufacturinghub/grafana-plugin-extractor:0.1.3
              volumeMounts:
                - name: storage
                  mountPath: /var/lib/grafana
              imagePullPolicy: IfNotPresent
        ```
        
    6. Replace
        
        ```yaml
        GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS: umh-datasource,umh-factoryinput-panel
        ```
        
        with
        
        ```yaml
        GF_PLUGINS_ALLOW_LOADING_UNSIGNED_PLUGINS: umh-datasource,umh-factoryinput-panel,umh-v2-datasource
        ```
        
    7. Replace
        
        ```yaml
        datasources:
            datasources.yaml:
              apiVersion: 1
              datasources:
              - access: proxy
                editable: false
                isDefault: true
                jsonData:
                  apiKey: $FACTORYINSIGHT_PASSWORD
                  apiKeyConfigured: true
                  customerId: $FACTORYINSIGHT_CUSTOMERID
                  serverURL: http://united-manufacturing-hub-factoryinsight-service/
                name: umh-datasource
                orgId: 1
                type: umh-datasource
                url: http://united-manufacturing-hub-factoryinsight-service/
                version: 1
        ```
        
        With
        
        ```yaml
        datasources:
            datasources.yaml:
              apiVersion: 1
              datasources:
              - access: proxy
                editable: false
                isDefault: true
                jsonData:
                  apiKey: $FACTORYINSIGHT_PASSWORD
                  apiKeyConfigured: true
                  customerId: $FACTORYINSIGHT_CUSTOMERID
                  serverURL: http://united-manufacturing-hub-factoryinsight-service/
                name: umh-datasource
                orgId: 1
                type: umh-datasource
                url: http://united-manufacturing-hub-factoryinsight-service/
                version: 1
              - access: proxy
                editable: false
                isDefault: false
                jsonData:
                  apiKey: $FACTORYINSIGHT_PASSWORD
                  apiKeyConfigured: true
                  baseURL: http://united-manufacturing-hub-factoryinsight-service/
                  customerID: $FACTORYINSIGHT_CUSTOMERID
                name: umh-v2-datasource
                orgId: 1
                type: umh-v2-datasource
                url: http://united-manufacturing-hub-factoryinsight-service/
                version: 1
        ```
        
    8. Press “Upgrade”
    9. Go to Workloads → Pods
    10. Check in UMHLens if your timescaledb version is pg13.8-ts2.8.0-p1
        1. If not, make sure to place the following code in the timescale-single section
        
        ```yaml
        image:
            repository: timescale/timescaledb-ha
            tag: pg13.8-ts2.8.0-p1
            pullPolicy: Always
        ```
        
    11. Open a pod shell inside timescaledb
        1. Execute
            
            ```yaml
            psql -X
            ALTER EXTENSION timescaledb UPDATE;
            \dx timescaledb
            ```
            
        2. It should show 2.8.0 as timescaledb version
        3. Kill the timescaledb & factoryinsight pods
    

# New Grafana plugins

[UMH-datasource-v2](https://github.com/united-manufacturing-hub/umh-datasource-v2) is included and enabled by default.
