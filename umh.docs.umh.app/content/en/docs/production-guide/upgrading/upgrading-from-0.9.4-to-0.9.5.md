---
title: "Upgrading v0.9.4 to v0.9.5"
description: "During the Helm Hart upgrade from v0.9.4 to 0.9.5 the following steps need to executed additionally to the following guide."
minimum_version: 0.9.4
maximum_version: 0.9.5
---

## Instructions on upgrading

During the Helm Hart upgrade from v0.9.4 to 0.9.5 the following steps need to executed additionally to the following guide:

1.  [**Upgrading the Helm Chart**](/docs/production-guide/upgrading/upgrading-helm-chart) 
2. [Migrating DB ordertable (< 0.9.5 to ≥ 0.9.5)](/docs/production-guide/upgrading/migrating-ordertable) 
3. The default language is now English. If you want to keep using German, you need to follow this guide:
    
    [Changing the language in factoryinsight](/docs/production-guide/administration/change-factoryinsight-language)
    
4. The Kafka StatefulSet has now a startupProbe to work with long startup times. For this you need to change the following values in the values.yaml:
    
    ```yaml
    	startupProbe:
        enabled: true
        failureThreshold: 600
        periodSeconds: 10
        timeoutSeconds: 10
    ```
    
    ![Set startup probe](/images/production-guide/upgrading/upgrading-from-0.9.4-to-0.9.5/setStartupProbe.png)
    
5. Minor API changes to availability and performance, which will both behave similar to OEE now and return multiple values for longer time ranges. In Grafana panels using them must be change to use not the “last” calculation, but the “mean” calculation.
6. If you are using the modifyState message, ensure that your messages use the “timestamp_ms” & “timestamp_ms_end” notion, instead of the old “start_time_stamp” & “end_time_stamp” (https://github.com/united-manufacturing-hub/united-manufacturing-hub/pull/1137/files)
7. If you where using “deleteShiftByAssetIdAndBeginTimestamp” or “deleteShiftById”, please use “deleteshift” instead
8. If you where using “modifyProducedPieces”, please ensure that you now also send a timestamp_ms
