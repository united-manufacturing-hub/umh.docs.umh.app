To get a list of available services and related ports you can run the following
command from the instance:

```bash
sudo $(which kubectl) get svc -n united-manufacturing-hub --kubeconfig /etc/rancher/k3s/k3s.yaml
```

All of them are available from within the cluster. The ones of type LoadBalancer
are also available from outside the cluster using the node IP and the port listed
in the **Ports** column.

{{% notice tip %}}
Use the port on the left side of the colon (`:`) to connect to the service from
outside the cluster. For example, the database is available on port `5432`.
{{% /notice %}}