+++
title = "Moving an account"
menuTitle = "Moving an account"
description = "As the login system is passwordless and is based on certificates, you need to copy the certificates in order to access your account on another computer"
aliases =  []
draft = false
weight = 3
+++

**Requirements:**
- an existing installation of the Management Console on Windows
- a created account

To save or backup your certificates, you need to go into the folder `%appdata%/management-console/certificates` and copy its contents. You can now copy this into the same folder on a different computer. For more information, please look at the [Security Concept](/docs/security/concept/) section.

   {{% notice warning %}}
   Please ensure that your keep your certificates safe. Anyone with access to them is able to access your IT / OT infrastructure as well.
   {{% /notice %}}
