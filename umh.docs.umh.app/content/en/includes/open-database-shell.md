```bash
sudo $(which kubectl) exec -it $(sudo $(which kubectl) get pods --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -l app.kubernetes.io/component=timescaledb -o jsonpath="{.items[0].metadata.name}") --kubeconfig /etc/rancher/k3s/k3s.yaml -n united-manufacturing-hub -- psql -U postgres
```

This command will open a `psql` shell connected to the default postgres database.