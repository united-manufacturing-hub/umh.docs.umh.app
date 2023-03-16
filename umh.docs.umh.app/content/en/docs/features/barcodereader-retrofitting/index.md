+++
title = "Retrofitting with USB barcodereader"
menuTitle = "Retrofitting with USB barcodereader"
description = ""
weight = 4
draft = false
+++

The microservice barcodereader can be used to read barcodes from USB-connected barcode scanner
devices and publish the scanned data to the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/).

## When should I use it?

If you need to connect a barcodereader or any other USB devices acting as a keyboard. These cases could be to scan an order
at the production machine from the accompanying order sheet. Or To scan material for inventory and track and trace.

## What can I do with it?

You can connect USB devices acting as a keyboard to the Unified Namespace. It will record all inputs and send it out once
a return / emter character has been detected. A lof of barcodescanners work that way. Additionally, you can also connect
something like a quality testing station (we once connected a mitutoyu quality testing station).

## How can I use it?

To use the microservice barcodereader, you will need configure the helm-chart and enable it.
Once installed, you can [configure](/docs/architecture/microservices/community/barcodereader/) the microservice by
setting the needed environment variables. The program will continuously scan for barcodes using the device and publish
the data to the Kafka topic.

## What are the limitations?

- sometimes special characters are not parsed correctly. They need to be adjusted afterwards in th Unified Namespace

## Where to get more information?

- [technical documentation of barcodereader](/docs/architecture/microservices/community/barcodereader/) 