+++
title = "Retrofitting with USB barcodereader"
menuTitle = "Retrofitting with USB barcodereader"
description = "Integrate USB barcode scanners with United Manufacturing Hub's barcodereader microservice for seamless data publishing to Unified Namespace. Ideal for inventory, order processing, and quality testing stations."
weight = 4
draft = false
+++

The barcodereader microservice enables the processing of barcodes from USB-linked scanner devices, subsequently publishing the acquired 
data to the [Unified Namespace](https://learn.umh.app/lesson/introduction-into-it-ot-unified-namespace/).
## When should I use it?

When you need to connect a barcode reader or any other USB devices acting as a keyboard (HID). These cases could be to scan an order
at the production machine from the accompanying order sheet. Or To scan material for inventory and track and trace.

## What can I do with it?

You can connect USB devices acting as a keyboard to the Unified Namespace. It will record all inputs and send it out once
a return / enter character has been detected. A lof of barcode scanners work that way. Additionally, you can also connect
something like a quality testing station (we once connected a Mitutoyo quality testing station).

## How can I use it?

To use the microservice barcode reader, you will need configure the helm-chart and enable it.

  1. Enable _000_commonConfig.datasources.barcodereader.enabled in the [Helm Chart](https://umh.docs.umh.app/docs/architecture/helm-chart/#configuration-options)
  2. During startup, it will show all connected USB devices. Remember yours and then change the INPUT_DEVICE_NAME and INPUT_DEVICE_PATH
  3. Also set ASSET_ID, CUSTOMER_ID, etc. as this will then send it into the topic ia/ASSET_ID/.../barcode
  4. Restart the pod
  5. Scan a device, and it will be written into the topic xxx

Once installed, you can [configure](/docs/architecture/microservices/community/barcodereader/) the microservice by
setting the needed environment variables. The program will continuously scan for barcodes using the device and publish
the data to the Kafka topic.

## What are the limitations?

- Sometimes special characters are not parsed correctly. They need to be adjusted afterward in th Unified Namespace.

## Where to get more information?

- [technical documentation of barcodereader](/docs/architecture/microservices/community/barcodereader/) 
