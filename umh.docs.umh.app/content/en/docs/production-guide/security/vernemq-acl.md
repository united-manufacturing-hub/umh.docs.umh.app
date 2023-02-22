+++
title =  "Changing VerneMQ ACL configuration"
description = "How to change the _ACL_ configuration to allow more users to publish to the MQTT broker"
maximum_version = "0.9.5"
+++

1. Go to the **Releases** tab in Lens.
2. Search for `AclConfig`
3. There you can adjust it. To allow unrestricted access, add in the first line `pattern #`

   ![AclConfig](/images/production-guide/security/vernemq-acl/acl-config.png)

4. Press **Save** applying the changes.