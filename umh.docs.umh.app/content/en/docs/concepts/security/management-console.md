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

## Cyphered Messages

{{% notice warning %}}
This feature is currently in development and is subject to change.
{{% /notice %}}

Other than the standard TLS encryption provided by HTTPS, we also provide an
additional layer of encryption for the messages exchanged between the Management
Console and your UMH instance.
Every action that you perform on the Management Console, such as creating a new
data source, and every information that you retrieve, such as the messages in
the Unified Namespace, is encrypted using a secret key that is only known to
you and your UMH instance. This ensures that no one, not even us, can see, read
or reverse engineer the content of these messages.

The process we use (which is now patent pending) is simple yet effective:

1. When you create a new user on the Management Console, we generate a new
   private key and we encrypt it using your password. This means that only you
   can decrypt it.
2. The encrypted private key and your hashed password are stored in our database.
3. When you login to the Management Console, the encrypted private key associated
   with your user is downloaded to your browser and decrypted using your
   password. This ensures that your password is never sent to our server, and
   that the private key is only available to you.
4. When you add a new UMH instance to the Management Console, it generates a
   token that the Management Companion (aka your instance) will use to
   authenticate itself. This token works the same way as your user password: it
   is used to encrypt a private key that only the UMH instance can decrypt.
5. The instance encrypted private key and the hashed token are stored in our
   database. A relationship is also created between the user and the instance.
6. All the messages exchanged between the Management Console and the UMH
   instance are encrypted using the private keys, and then encrypted again using
   the TLS encryption provided by HTTPS.

The only drawback to this approach is that, if you forget your password, we
won't be able to recover your private key. This means that you will have to
create a new user and reconfigure all your UMH instances. But your data will
still be safe and secure.

However, even though we are unable to read any private key, there is some information
that we can inevitably see:

- IP addresses of the devices using the Management Console and of the UMH instances
  that they are connected to
- The time at which the devices connect to the Management Console
- Amount of data exchanged between the devices and the Management Console (but
  **not** its content)

<!-- 
## Authentication

The Management Console lets you authenticate using SSO, which means that you
don't have to remember yet another password. You can just login using your
existing company credentials.
-->
