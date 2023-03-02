+++
title =  "Changing VerneMQ ACL configuration"
description = "How to change the _ACL_ configuration to allow more users to publish to the MQTT broker"
maximum_version = "0.9.5"
+++

## {{% heading "prerequisites" %}}

{{< include "task-tutorial-prereqs.md" >}}

<!-- steps -->

## Changing VerneMQ ACL configuration

1. Go to the **Releases** tab in {{< resource type="lens" name="name" >}}.
2. Search for `AclConfig`
3. There you can adjust it. To allow unrestricted access, add in the first line `pattern #`

   ![AclConfig](/images/production-guide/security/vernemq-acl/acl-config.png)

4. Press **Save** applying the changes.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- [Setting up HiveMQ PKI](/docs/production-guide/security/hivemq-rbac/)