---
title: "Upgrading v0.9.2 to v0.9.4"
description: "During the upgrade some changes need to be done manually"
minimum_version: 0.9.2
maximum_version: 0.9.4
---

## Instructions

1. Change the kafkaBridge.topicmap to the latest value specified here: [https://learn.umh.app/docs/core/helmchart/](https://learn.umh.app/docs/core/helmchart/)
Right now this is 
    
    ```yaml
    topicmap:
        - bidirectional: false
          name: HighIntegrity
          send_direction: to_remote
          topic: ^ia\.(([^r.](\d|-|\w)*)|(r[b-z](\d|-|\w)*)|(ra[^w]))\.(\d|-|\w|_)+\.(\d|-|\w|_)+\.((addMaintenanceActivity)|(addOrder)|(addParentToChild)|(addProduct)|(addShift)|(count)|(deleteShiftByAssetIdAndBeginTimestamp)|(deleteShiftById)|(endOrder)|(modifyProducedPieces)|(modifyState)|(productTag)|(productTagString)|(recommendation)|(scrapCount)|(startOrder)|(state)|(uniqueProduct)|(scrapUniqueProduct))$
        - bidirectional: false
          name: HighThroughput
          send_direction: to_remote
          topic: ^ia\.(([^r.](\d|-|\w)*)|(r[b-z](\d|-|\w)*)|(ra[^w]))\.(\d|-|\w|_)+\.(\d|-|\w|_)+\.(process[V|v]alue).*$
    ```
    
2. When using barcodereader, change the following lines
    
    ```yaml
    barcodereader:
      image: unitedmanufacturinghub/barcodereader
      resources:
        limits:
          cpu: 10m
          memory: 60Mi
        requests:
          cpu: 2m
          memory: 30Mi
    ```
    
    to these lines
    
    ```yaml
    barcodereader:
      enabled: false
      image:
        repository: unitedmanufacturinghub/barcodereader
        pullPolicy: IfNotPresent
      resources:
        requests:
          cpu: "2m"
          memory: "30Mi"
        limits:
          cpu: "10m"
          memory: "60Mi"
      scanOnly: false # Debug mode, will not send data to kafka
    ```
    
3. Follow the other advices in 
    
    [**Upgrading the Helm Chart**](./upgrading-helm-chart)
