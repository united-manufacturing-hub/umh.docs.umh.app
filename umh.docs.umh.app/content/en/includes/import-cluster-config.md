1. From your SSH session, run the following command to get the cluster configuration:

   ```bash
   sudo kubectl config view --raw
   ```

   The output should look similar to this:

   ```yaml
   apiVersion: v1
   clusters:
   - cluster:
       certificate-authority-data: <long string>
       server: https://127.0.0.1:6443
     name: default
   contexts:
   - context:
       cluster: default
       user: default
     name: default
   current-context: default
   kind: Config
   preferences: {}
   users:
   - name: default
     user:
       client-certificate-data: <long string>
       client-key-data: <long string>
   ```

2. Copy the output.
3. Open {{< resource type="lens" name="name" >}}, click on the three horizontal
   lines in the upper left corner and choose **Files** > **Add Cluster**.
4. Paste the output.
5. Update the `server` field to the IP address of the device, e.g.:

   ```yaml
   apiVersion: v1
   clusters:
   - cluster:
       certificate-authority-data: <long string>
       server: https://192.168.0.123:6443 # <- update this
   ...
   ```

6. If you want, you can also update the `name` field to something more meaningful,
   e.g.:

   ```yaml
   apiVersion: v1
   clusters:
   - cluster:
       certificate-authority-data: <long string>
       server: https://192.168.0.123:6443
       name: my-edge-device # <- update this
   ...
   ```

7. Click on **Add clusters**.
