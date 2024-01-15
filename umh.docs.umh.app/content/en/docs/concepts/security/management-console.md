---
title: "Management Console"
content_type: concept
description: |
    Concepts related to the security of the Management Console.
weight: 10
---

<!-- overview -->
The web-based nature of the Management Console means that it is exposed to the
same security risks as any other web application. This section describes the
measures that we adopt to mitigate these risks.

<!-- body -->

## Encrypted Communication

The Management Console is served over HTTPS, which means that all communication
between the browser and the server is encrypted. This prevents attackers from
eavesdropping on the communication and stealing sensitive information such as
passwords and session cookies.

<!-- 
## Cyphered Messages

All the messages exchanged between the Management Console and your UMH instance,
which inevitably go through our servers, are encrypted using a secret key that
is only known to you and your UMH instance. This ensures that no one, not even
us, can read the content of these messages.
-->

<!-- 
## Authentication

The Management Console lets you authenticate using SSO, which means that you
don't have to remember yet another password. You can just login using your
existing company credentials.
-->
