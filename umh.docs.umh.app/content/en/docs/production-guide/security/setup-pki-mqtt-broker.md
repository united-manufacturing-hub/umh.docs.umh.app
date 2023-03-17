---
title: "Setup PKI for the MQTT Broker"
content_type: task
description: |
    This page describes how to setup the Public Key Infrastructure (PKI) for the
    MQTT broker.
weight: 50
minimum_version: 0.9.10
---

<!-- overview -->

If you want to use MQTT over TLS (MQTTS) or Secure Web Socket (WSS) you need
to setup a Public Key Infrastructure (PKI).

Read the blog article about
[secure communication in IoT](https://www.umh.app/post/an-introduction-into-certificates-and-secure-communication-in-iot-for-normal-people)
to learn more about encryption and certificates.

## Structure overview

The Public Key Infrastructure for HiveMQ consists of two Java Key Stores (JKS):

- **Keystore**: The Keystore contains the HiveMQ certificate and private keys.
  This store must be confidential, since anyone with access to it could generate
  valid client certificates and read or send messages in your MQTT infrastructure.
- **Truststore**: The Truststore contains all the clients public certificates.
  HiveMQ uses it to verify the authenticity of the connections.

## {{% heading "prerequisites" %}}

You need to have the following tools installed:

- OpenSSL. If you are using Windows, you can install it with
  [Chocolatey](https://chocolatey.org/packages/openssl).
- [Java](https://www.java.com/en/download/manual.jsp)

<!-- steps -->

## Create a Keystore

Open a terminal and run the following command:

```bash
keytool -genkey -keyalg RSA -alias hivemq -keystore hivemq.jks -storepass <password> -validity <days> -keysize 4096 -dname "CN={{< resource type="service" name="mqttbroker" >}}" -ext "SAN=IP:127.0.0.1"
```

Replace the following placeholders:

- `<password>`: The password for the keystore. You can use any password you want.
- `<days>`: The number of days the certificate should be valid.

The command runs for a few minutes and generates a file named `hivemq.jks` in
the current directory, which contains the HiveMQ certificate and private key.

If you want to explore the contents of the keystore, you can use
[Keystore Explorer](https://keystore-explorer.org/).

## Generate client certificates

Open a terminal and create a directory for the client certificates:

```bash
mkdir pki
```

Follow these steps for each client you want to generate a certificate for.

1. Create a new key pair:

    ```bash
    openssl req -new -x509 -newkey rsa:4096 -keyout "pki/<servicename>-key.pem" -out "pki/<servicename>-cert.pem" -nodes -days <days> -subj "/CN=<servicename>"
    ```

2. Convert the certificate to the correct format:

   ```bash
   openssl x509 -outform der -in "pki/<servicename>-cert.pem" -out "pki/<servicename>.crt"
   ```

3. Import the certificate into the Truststore:

   ```bash
   keytool -import -file "pki/<servicename>.crt" -alias "<servicename>" -keystore hivemq-trust-store.jks -storepass <password>
   ```

Replace the following placeholders:

- `<servicename>` with the name of the client. Use the service name
from the **Network** > **Services** tab in {{< resource type="lens" name="name" >}}.
- `<days>` with the number of days the certificate should be valid.
- `<password>` with the password for the Truststore. You can use any password you want.

## Import the PKI into the United Manufacturing Hub

First you need to encode in base64 the Keystore, the Truststore and all the PEM
files. Use the following script to encode everything automatically:
  
{{< tabs name="base64" >}}
{{% tab name="Windows" %}}

  ```powershell
  Get-ChildItem .\ -Recurse -Include *.jks,*.pem | ForEach-Object {
      $FileContent = Get-Content $_ -Raw
      $fileContentInBytes = [System.Text.Encoding]::UTF8.GetBytes($FileContent)
      $fileContentEncoded = [System.Convert]::ToBase64String($fileContentInBytes)
      $fileContentEncoded > $_".b64"
      Write-Host $_".b64 File Encoded Successfully!"
  }
  ```

{{% /tab %}}
{{% tab name="macOS/Linux" %}}

  ```bash
  find ./ -regex '.*\.jks\|.*\.pem' -exec openssl base64 -A -in {} -out {}.b64 \;
  ```

{{% /tab %}}
{{< /tabs >}}

You could also do it manually with the following command:

  ```bash
  openssl base64 -A -in <filename> -out <filename>.b64
  ```

Now you can import the PKI into the United Manufacturing Hub. To do so:

1. Open {{< resource type="lens" name="name" >}}.
2. Navigate to **Helm** > **Releases**.
3. Select the {{< resource type="helm" name="release" >}} release.
4. Click the **Upgrade** button.
5. Find the `_000_commonConfig.infrastructure.mqtt.tls` section.
6. Update the value of the `keystoreBase64` field with the content of the
   `hivemq.jks.b64` file and the value of the `keystorePassword` field with the
   password you used for the keystore.
7. Update the value of the `truststoreBase64` field with the content of the
   `hivemq-trust-store.jks.b64` file and the value of the `truststorePassword`
   field with the password you used for the truststore.
8. Update the value of the `<servicename>.cert` field with the content of the
   `<servicename>-cert.pem.b64` file and the value of the `<servicename>.key` field
   with the content of the `<servicename>-key.pem.b64` file.
9. Click the **Upgrade** button to apply the changes.

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- Learn more about HiveMQ's TLS configuration in the
  [HiveMQ documentation](https://www.hivemq.com/docs/hivemq/4.9/user-guide/howtos.html).
