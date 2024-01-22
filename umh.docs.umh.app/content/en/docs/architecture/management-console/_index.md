---
title: "Management Console"
menuTitle: "Management Console"
description: |
  Delve into the functionalities and components of the UMH's Management Console,
  ensuring efficient system management.
weight: 3000
---

The Management Console is pivotal in configuring, managing, and monitoring the
United Manufacturing Hub. It comprises a [web application](https://management.umh.app/),
a backend API and the management companion agent, all designed to ensure secure and
efficient operation.

![Management Console Architecture](/images/architecture/container-management-console.png)

## Web Application

The client-side Web Application, available at [management.umh.app](https://management.umh.app/)
enables users to register, add, and manage instances, and monitor the
infrastructure within the United Manufacturing Hub. All communications between
the Web Application and the user's devices are end-to-end encrypted, ensuring
complete confidentiality from the backend.

## Management Companion

Deployed on each UMH instance, the Management Companion acts as an agent responsible
for decrypting messages coming from the user via the Backend and executing
requested actions. Responses are end-to-end encrypted as well, maintaining a
secure and opaque channel to the Backend.

## Management Updater

The Updater is a custom Job run by the Management Companion, responsible for
updating the Management Companion itself. Its purpose is to automate the process
of upgrading the Management Companion to the latest version, reducing the
administrative overhead of managing UMH instances.

## Backend

The Backend is the public API for the Management Console. It functions as a bridge
between the Web Application and the Management Companion. Its primary role is to
verify user permissions for accessing UMH instances. Importantly, the backend
does not have access to the contents of the messages exchanged between the Web
Application and the Management Companion, ensuring that communication remains
opaque and secure.
