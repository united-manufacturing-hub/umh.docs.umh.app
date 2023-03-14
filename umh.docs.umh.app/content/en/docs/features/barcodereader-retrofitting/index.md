+++
title = "Retrofitting with USB barcodereader"
menuTitle = "Retrofitting with USB barcodereader"
description = ""
weight = 4
draft = false
+++

The microservice barcodereader can be used to read barcodes from USB-connected barcode scanner
devices and publish the scanned data to a Kafka topic.

## When should I use it?

The microservice barcodereader can be used when there is a need to integrate barcode scanning into a larger software 
system, such as a warehouse management system or an e-commerce platform.

## What can I do with it?

With the microservice barcodereader, you can integrate barcode scanning into a larger software system using Kafka as a 
message broker. This can allow for seamless data collection and integration.

## How can I use it?

To use the microservice barcodereader, you will need configure the helm-chart and enable it.
Once installed, you can [configure](/docs/architecture/microservices/community/barcodereader/) the microservice by
setting the needed environment variables. The program will continuously scan for barcodes using the device and publish
the data to the Kafka topic.

## What are the limitations?

- limited by the capabilities of the USB-connected barcode scanner device

## Where to get more information?

- [technical documentation of barcodereader](/docs/architecture/microservices/community/barcodereader/) 