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

The [Kafka Broker](/docs/reference/microservices/kafka-broker/) uses the service 
type NodePort by default. 

Follow these steps to access the Kafka Broker outside the cluster:

1. Access your instance via SSH
2. Execute this command to check the host port of the Kafka Broker:

   ```bash
   sudo $(which kubectl) get svc united-manufacturing-hub-kafka-external -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```

3. In the `PORT(S)` column, you should be able to see the port with `9094:<host-port>/TCP`.
4. To access the Kafka Broker, use `<instance-ip-address>:<host-port>`.


## Services with ClusterIP

Some of the microservices in the United Manufacturing Hub are exposed via
a ClusterIP service. That means that they are only accessible from within the
cluster itself. There are two options for enabling access them from outside the cluster: 
- [Creating a LoadBalancer service](/docs/production-guide/administration/access-services-from-outside-cluster/#create-a-loadbalancer-service):
A LoadBalancer is a service that exposes a set of Pods on the same network 
as the cluster, but not necessarily to the entire internet.
- [Port forwarding](/docs/production-guide/administration/access-services-from-outside-cluster/#port-forwarding):
You can just forward the port of a service to your local machine.

{{% notice warning %}}
Port forwarding can be unstable, especially if the connection to the cluster is
slow. If you are experiencing issues, try to create a LoadBalancer service
instead.
{{% /notice %}}

### Create a LoadBalancer service

Follow these steps to enable the LoadBalancer service for the corresponding microservice:

1. Execute the following command to list the services and note the name of 
the one you want to access.
   ```bash
   sudo $(which kubectl) get svc -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```
2. Start editing the service configuration by running this command:
   ```bash
   sudo $(which kubectl) edit svc <service-name> -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```
3. Find the `status.loadBalancer` section and update it to the following:

   ```yaml
   status:
     loadBalancer:
       ingress:
       - ip: <external-ip>
   ```

   Replace `<external-ip>` with the external IP address of the node.
4. Go to the `spec.type` section and change the value from `ClusterIP` to
   `LoadBalancer`. 
5. After saving, your changes will be applied automatically and the service will 
   be updated. Now, you can access the service at the configured address.

### Port forwarding

1. Execute the following command to list the services and note the name of the one 
you want to port-forward and the internal port that it use.
   ```bash
   sudo $(which kubectl) get svc -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```
2. Run the following command to forward the port:
   ```bash
   sudo $(which kubectl) port-forward service/<your-service> <local-port>:<remote-port> -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
   ```
   Where `<local-port>` is the port on the host that you want to use, 
   and `<remote-port>` is the service port that you noted before. 
   Usually, it's good practice to pick a high number (greater than 30000) 
   for the host port, in order to avoid conflicts.
3. You should be able to see logs like:
   ```text
   Forwarding from 127.0.0.1:31922 -> 9121
   Forwarding from [::1]:31922 -> 9121
   Handling connection for 31922
   ```

   You can now access the service using the IP address of the node and 
   the port you choose.

<!-- discussion -->

## Security considerations

### MQTT broker

There are some security considerations to keep in mind when exposing the MQTT 
broker.

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