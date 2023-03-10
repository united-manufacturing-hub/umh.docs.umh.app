1. Open {{< resource type="lens" name="name" >}} on your device.
2. From the homepage, click on **Browse Clusters in Catalog**. You should see
   all your clusters.
3. Click on a cluster to connect to it.
4. Navigate to **Helm** > **Releases** and change the namespace from default to
   {{< resource type="ns" name="umh" >}} in the upper right corner.

   ![lens-namespaces](/images/lens-namespaces.png)
5. Select the {{< resource type="helm" name="release" >}} Release to inspect the
   release details, the installed resources, and the Helm values.
