---
title: "Access Services Outside the Cluster"
content_type: task
description: |
    This page describe how to access services from outside the cluster.
weight: 21
aliases:
   - /docs/production-guide/administration/access-factoryinsight-outside-cluster/
   - /docs/production-guide/administration/access-mqtt-outside-cluster/
---

<!-- overview -->

Some of the microservices in the United Manufacturing Hub are exposed outside
the cluster with a LoadBalancer service. A LoadBalancer is a service
that exposes a set of Pods on the same network as the cluster, but
not necessarily to the entire internet. The LoadBalancer service
provides a single IP address that can be used to access the Pods.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Accessing the services

{{< include "service-list.md" >}}

## Services with LoadBalancer by default

The following services are exposed outside the cluster with a LoadBalancer
service by default:

- [Database](/docs/reference/microservices/database/) at port 5432
- [Kafka Console](/docs/reference/microservices/kafka-console/) at port
  8090
- [Grafana](/docs/reference/microservices/grafana/) at port 8080
- [MQTT Broker](/docs/reference/microservices/mqtt-broker/) at port
  1883
- [OPCUA Simulator](/docs/reference/microservices/opcua-simulator/)
  at port 46010
- [Node-RED](/docs/reference/microservices/node-red/) at port 1880

{{% notice tip %}}
To access Node-RED, you need to use the `/nodered` path, for example
`http://192.168.1.100:1880/nodered`.
{{% /notice %}}

## Services with NodePort by default

The [Kafka Broker](/docs/reference/microservices/kafka-broker/) uses the service type NodePort by default. 

Follow these steps to access the Kafka Broker outside the cluster:

1. Access your instance via SSH
2. Execute this command:

   ```bash
   sudo $(which helm) upgrade --set redpanda.external.type=LoadBalancer united-manufacturing-hub united-manufacturing-hub/united-manufacturing-hub -n united-manufacturing-hub --reuse-values --version $(sudo $(which helm) get metadata united-manufacturing-hub -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml -o json | jq -r '.version') --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```

3. Wait for the changes to be applied.

Access the Kafka Broker at port 9094.

## Services with ClusterIP

Some of the microservices in the United Manufacturing Hub are exposed via
a ClusterIP service. That means that they are only accessible from within the
cluster itself. To access them from outside the cluster, you need to create a
LoadBalancer service.

### Create a LoadBalancer service

If you are looking to expose th Kafka broker, follow the instructions in the
[Access Kafka outside the cluster](/docs/production-guide/administration/access-kafka-outside-cluster/)
page.

For any other microservice, follow these steps to enable the LoadBalancer service:

1. Open {{< resource type="lens" name="name" >}} and navigate to **Network** >
    **Services**.
2. Select the service and click the **Edit** button.
3. Scroll down to the `status.loadBalancer` section and change it to the following:

   ```yaml
   status:
     loadBalancer:
       ingress:
       - ip: <external-ip>
   ```

   Replace `<external-ip>` with the external IP address of the node.
4. Scroll to the `spec.type` section and change the value from ClusterIP to
   LoadBalancer.
5. Click **Save** to apply the changes.

If you installed the United Manufacturing Hub on your local machine, either
using the Management Console or the command line, you also need to map the port
exposed by the k3d cluster to a port on your local machine. To do that, run the
following command:

```bash
k3d cluster edit {{< resource type="cluster" name="name" >}} --port-add "<local-port>:<cluster-port>@server:0"
```

Replace `<local-port>` with a free port number on your local machine, and
`<cluster-port>` with the port number of the service.

### Port forwarding in {{% resource type="lens" name="name" %}}

If you don't want to create a LoadBalancer service, effectively exposing the
microservice to anyone that has access to the host IP address, you can use
{{% resource type="lens" name="name" %}} to forward the port to your local
machine.

1. Open {{< resource type="lens" name="name" >}} and navigate to **Network** >
    **Services**.
2. Select the service that you want to access.
3. Scroll down to the **Connection** section and click the **Forward...** button.
4. From the dialog, you can choose a port on your local machine to forward the
   cluster port from, or you can leave it empty to use a random port.
5. Click **Forward** to apply the changes.
6. If you left the checkbox **Open in browser** checked, then the service will
   open in your default browser.

You can see and manage the forwarded ports of your cluster in the **Network** >
**Port Forwarding** section.

{{< notice warning >}}
Port forwarding can be unstable, especially if the connection to the cluster is
slow. If you are experiencing issues, try to create a LoadBalancer service
instead.
{{< /notice >}}

<!-- discussion -->

## Security considerations

### MQTT broker

There are some security considerations to keep in mind when exposing the MQTT broker.

By default, the MQTT broker is configured to allow anonymous connections. This
means that anyone can connect to the broker without providing any credentials.
This is not recommended for production environments.

To secure the MQTT broker, you can configure it to require authentication. For
that, you can either [enable RBAC](/docs/production-guide/security/enable-rbac-mqtt-broker/)
or [set up HiveMQ PKI](/docs/production-guide/security/setup-pki-mqtt-broker/) (recommended
for production environments).

## {{% heading "troubleshooting" %}}

### LoadBalancer service stuck in Pending state

If the LoadBalancer service is stuck in the Pending state, it probably means
that the host port is already in use. To fix this, edit the service and change
the section `spec.ports.port` to a different port number.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See how to [Expose Grafana to the Internet](/docs/production-guide/administration/expose-grafana-to-internet/)