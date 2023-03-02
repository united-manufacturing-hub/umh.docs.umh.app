---
title: "Upgrading v0.9.8 to v0.9.9"
description: "During the Helm Chart upgrade from v0.9.8 to 0.9.9 the following steps need to executed additionally to the following guide."
minimum_version: 0.9.8
maximum_version: 0.9.9
---

## Instructions on upgrading

During the Helm chart upgrade from v0.9.8 to 0.9.9 the following steps need to executed additionally to the following guide:

[**Upgrading the Helm Chart**](./upgrading-helm-chart)

# Upgrading (after upgrading the Helm Chart)

1. Open UMHLens
2. Select Workloads → Pods
3. Click on the Grafana pod
4. Check that the Init Container’s image is unitedmanufacturinghub/grafana-plugin-extrator:0.1.4
    
    ![Lens, grafana plugin extractor version](/images/production-guide/upgrading/upgrading-from-0.9.8-to-0.9.9/lens_gf_plugin_extractor.png)
    
    1. If this is not the case:
    2. [Optional] Remove the Stateful & Deployments, listed in the normal upgrade guide
    3. Goto Helm → Releases and click on the 3 dots left to united-manufacturing-hub
    4. Select “upgrade”
    5. Replace the extraInitContainers from grafana with:
        
        ```yaml
        extraInitContainers:
            - name: init-umh-datasource
              image: unitedmanufacturinghub/grafana-plugin-extractor:0.1.4
              volumeMounts:
                - name: storage
                  mountPath: /var/lib/grafana
              imagePullPolicy: IfNotPresent
        ```
        
        1. If you are upgrading from 0.9.8, the only change should be the version (0.1.3 → 0.1.4)
