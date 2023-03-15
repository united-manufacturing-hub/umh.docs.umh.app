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

If you need to connect a barcodereader or any other USB devices acting as a keyboard. These cases could be to scan an order
at the production machine from the accompanying order sheet. Or To scan material for inventory and track and trace.

## What can I do with it?

With the microservice barcodereader, you can integrate barcode scanning into a larger software system using Kafka as a 
message broker. This can allow for seamless data collection and integration.

## How can I use it?

To use the microservice barcodereader, you will need configure the helm-chart and enable it.
Once installed, you can [configure](/docs/architecture/microservices/community/barcodereader/) the microservice by
setting the needed environment variables. The program will continuously scan for barcodes using the device and publish
the data to the Kafka topic.

## What are the limitations?

- sometimes special characters are not parsed correctly. They need to be adjusted afterwards in th Unified Namespace

## Where to get more information?

- [technical documentation of barcodereader](/docs/architecture/microservices/community/barcodereader/) 