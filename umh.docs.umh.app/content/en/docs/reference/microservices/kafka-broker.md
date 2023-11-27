---
title: "Kafka Broker"
content_type: reference
description: |
    The technical documentation of the kafka-broker microservice,
    which handles the communication between the microservices.
weight: 0
---

<!-- overview -->

<!-- body -->

## {{% heading "kuberesources" %}}

- StatefulSet: `{{< resource type="statefulset" name="kafkabroker" >}}`
- Service:
  - Internal ClusterIP (headless): `{{< resource type="service" name="kafkabroker-headless" >}}`
  - External NodePort: `{{< resource type="service" name="kafkabroker-ext" >}}` at
    port 9094 for the Kafka API listener, port 9644 for the Admin API listener,
    port 8083 for the HTTP Proxy listener, and port 8081 for the Schema Registry
    listener.
- ConfigMap: `{{< resource type="configmap" name="kafkabroker" >}}`
- Secret: `{{< resource type="secret" name="kafkabroker" >}}`
- PersistentVolumeClaim: `{{< resource type="pvc" name="kafkabroker" >}}`

## {{% heading "configuration" %}}

You shouldn't need to configure the Kafka broker manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the [`redpanda`](/docs/architecture/helm-chart/#dz-kafka-broker)
section of the Helm chart values file.

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name  | Description                         | Type   | Allowed values | Default                                                |
| -------------- | ----------------------------------- | ------ | -------------- | ------------------------------------------------------ |
| `HOST_IP`      | The IP address of the host machine. | string | Any            | _Random IP_                                            |
| `POD_IP`       | The IP address of the pod.          | string | Any            | _Random IP_                                            |
| `SERVICE_NAME` | The name of the service.            | string | Any            | {{< resource type="statefulset" name="kafkabroker" >}} |
{{< /table >}}
