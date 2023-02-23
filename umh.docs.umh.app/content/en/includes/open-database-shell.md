1. From the Pod section in {{< resource type="lens" name="name" >}}, click on **{{% resource type="pod" name="database" %}}**
   to open the details page.
2. {{< include "pod-shell.md" >}}
3. Enter the postgres shell:

   ```bash
   psql
   ```

4. Connect to the database:

   ```bash
   \c factoryinsight
   ```
