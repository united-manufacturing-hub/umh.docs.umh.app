---
title: "Expose Grafana to the Internet"
content_type: task
description: |
  This page describes how to expose Grafana to the Internet.
weight: 22
---

<!-- overview -->

This page describes how to expose Grafana to the Internet so that you can access
it from outside the Kubernetes cluster.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Enable the ingress

Enable the ingress by upgrading the value in the Helm chart.

To do so, run the following command:

```bash
sudo $(which helm) upgrade --set grafana.ingress.enabled=true united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub -n united-manufacturing-hub --reuse-values --version $(sudo $(which helm) get metadata united-manufacturing-hub -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -o json | jq '.version') --kubeconfig /etc/rancher/k3s/k3s.yaml
```

Remember to add a DNS record for your domain name that points to the external IP
address of the Kubernetes host. You can find the external IP address of the
Kubernetes host on the **Nodes** page in {{< resource type="lens" name="name" >}}.

<!-- discussion -->

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See how to [Access Factoryinsight Outside the Cluster](/docs/production-guide/administration/access-factoryinsight-outside-cluster/)
