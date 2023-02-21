+++
title =  "Setting up the HiveMQ PKI"
description = "Setting up a PKI infrastructure for the MQTT broker HiveMQ"
minimum_version = "0.9.10"
+++

You must use it if you want to connect securely using MQTT over TLS (_MQTTS_) or Secure Web Socket (_WSS_).

We recommend that you read our [blog post about secure communication first](https://www.umh.app/post/an-introduction-into-certificates-and-secure-communication-in-iot-for-normal-people).

## Requirements

  - OpenSSL / LibreSSL
  - Java JRE / OpenJDK JRE


## Structure

HiveMQ requires two [Java Key Stores](https://en.wikipedia.org/wiki/Java_KeyStore)

### Keystore
The keystore stores the HiveMQ certificate and private key.

You should treat this store as **confidential**, since anyone with access to it could generate valid client certificates and read or send messages in your MQTT infrastructure.

### Truststore
The Truststore stores all certificates of clients. HiveMQ uses it to verify their connection to the broker.

The Truststore doesn't contain any private keys and can therefore be shared publicly.


### PEM certificates & keys

Most MQTT clients do not use Java Key Stores (_JKS_), but [PEM](https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail) encoded certificates/keys.

A PEM encoded certificate begins with:

`-----BEGIN CERTIFICATE-----`

A private key begins with:

`-----BEGIN PRIVATE KEY-----`

Treat every private key as **confidential**.

## Setting up a new PKI

### Creating a Key store

```bash
keytool -genkey -keyalg RSA -alias hivemq -keystore hivemq.jks -storepass <password> -validity <days> -keysize 4096 -dname "CN=united-manufacturing-hub-hivemqce-local-service" -ext "SAN=IP:127.0.0.1"
```

Change the storepass `<password>` to a more secure password and the validity `<days>` to the number of days the certificate should be valid.

The command runs for a few minutes and generates a key named `hivemq.jks` in the current directory.

If you want to explore the contents of .jks files, we recommend using [Keystore Explorer](https://keystore-explorer.org/) (FOSS).


#### Creating client certificates

1. Create a new folder for the client certificates.
    ```bash
    mkdir pki
    ```
2. Create a new key pair for the service.
    ```bash
    openssl req -new -x509 -newkey rsa:4096 -keyout "pki/<servicename>-key.pem" -out "pki/<servicename>-cert.pem" -nodes -days <days> -subj "/CN=<servicename>"
    ```
   
    Change the `<servicename>` to the name of the service and the validity `<days>` to the number of days the certificate should be valid.

3. JKS cannot directly import PEM files, so you need to convert them before importing them into the Truststore.
   ```bash
    openssl x509 -outform der -in "pki/<servicename>-cert.pem" -out "pki/<servicename>.crt"
    ```

4. Import the certificate into the Truststore.
    ```bash
     keytool -import -file "pki/<servicename>.crt" -alias "<servicename>" -keystore hivemq-trust-store.jks -storepass <password>
    ```
   
5. Repeat steps 2-4 for every service that should connect to the HiveMQ broker.

#### Importing the PKI into the UMH Stack

If you look at our values.yaml file, you'll find many certificates under the `_000_commonConfig -> infrastructure -> mqtt -> tls` key.

-   To encode your keystore and Truststore, use the following command: `openssl base64 -A -in .\hivemq.jks or openssl base64 -A -in .\hivemq-trust-store.jks.`

    You'll need to do the same for the certificate and key of every microservice.

-   Alternatively, you can use the PowerShell script below to convert every PEM file automatically:
    ```powershell
    Get-ChildItem -Path .\ -Filter *.pem -Recurse -File -Name| ForEach-Object {
        $FileContent = Get-Content $_ -Raw
        $fileContentInBytes = [System.Text.Encoding]::UTF8.GetBytes($FileContent)
        $fileContentEncoded = [System.Convert]::ToBase64String($fileContentInBytes)
        $fileContentEncoded | Set-content ($_ + ".b64")
        Write-Host $_ + ".b64" + "File Encoded Successfully!"
    }
    ```
    
After you've encoded all the files, you can copy them into the values.yaml file.
Make sure to update the Truststore inside the values.yaml every time you add a new microservice.


#### Deep dive

If you like to know more, about HiveMQ’s TLS configuration, [visit their documentation](https://www.hivemq.com/docs/hivemq/4.9/user-guide/howtos.html).