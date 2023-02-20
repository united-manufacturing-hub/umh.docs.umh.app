+++
title = "Concept"
menuTitle = "Concept"
description = "The security concept of the Management Console is based on the concept of Public-Key-Infrastructure (PKI). This article explains how it works exactly."
aliases =  []
draft = false
weight = 3
+++

The security concept of the Management Console is based on the concept of Public-Key-Infrastructure (PKI). If you do not know this, we can recommend reading our [article about certificates and Public-Key-Infrastructure](https://www.umh.app/post/an-introduction-into-certificates-and-secure-communication-in-iot-for-normal-people). In the following, we assume that you know the basic concepts of certificates, especially the functionality of Certificate Authorities (CA). 

## How it works

![The security concept](/images/security/concept1.png)

When a technician creates an account, two certificates are generated:

1. a root CA for the entire company (*"root CA"*) and
2. user certificate signed by the root CA (*"technician certificate"*)

The *root CA* public key is stored on the *Management Server*, enabling pre-authentication of users, preventing DoS/DDoS attacks on your infrastructure and enabling licensing. The *root CA* is backed up and stored in a secure location, and is only needed to add or remove technicians or instances, or change permissions.

When a new instance is created, a *device certificate* is generated and signed by the *root CA*. It is then transfered to the instance using either a Yubikey, or any other non-digital method. Specifically, it is transfered to the *"Management Companion"* microservice. This concept can now be scaled out to an endless amount of technicians and instances. Additionally, using the PKI you have a fine-grained control over what technician can access which instances and what they can do on it.

## What information we can see

With our security approach, technicians can communicate with newly created instances via our *Management Server* using their Management Console, and all communication is fully encrypted. The Management Server will never see any private keys, which makes it technically impossible for us or any third party to decrypt the communication. However, we are theoretically able to store the following information:

- Metadata of the certificates, including First Name, Last Name, E-mail, and Company. This information is used for licensing purposes and to keep track of how many technicians and instances your company has.
- IP addresses of the technician and the instance.
- Date and time of communication.
- Encrypted data, which allows us to estimate how much each technician is communicating with their instances, but we cannot determine the content of the communication.

We take privacy and security very seriously, and we will always be transparent about the information we collect and how we use it. We only collect the necessary information to ensure the security and functionality of our service, and we never share this information with any third party without your explicit consent.

## Where the certificates are stored

At the moment, the certificates are stored in the folder `%appdata%/management-console/certificates`. The root folder contains the *root CA*, the sub-folder the *technician certificate*. In the future, there will be an option to protect these certificates with a password, or store them on a Yubikey altogether.
