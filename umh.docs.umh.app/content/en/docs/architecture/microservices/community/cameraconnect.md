---
title: "Cameraconnect"
content_type: microservices
description: |
    This page contains information about the cameraconnect microservice
weight: 10
---

<!-- overview -->

Cameraconnect is a microservice that connects to the camera and saves pictures.

## {{% heading "howitworks" %}}

<!-- body -->

## {{% heading "kuberesources" %}}

- Deployment: `{{< resource type="deployment" name="cameraconnect" >}}`

## {{% heading "configuration" %}}

### {{% heading "envvars" %}}

{{< table caption="Environment variables" >}}
| Variable name                 | Description                                                                                    | Type   | Allowed values                | Default                                                                              |
| ----------------------------- | ---------------------------------------------------------------------------------------------- | ------ | ----------------------------- | ------------------------------------------------------------------------------------ |
| `ACQUISITION_DELAY`           | The delay between the trigger and the acquisition of the image.                                | string | Valid float number            | 0.0                                                                                  |
| `BROKER_URL`                  | URL of the MQTT broker                                                                         | string | Any                           | ssl://united-manufacturing-hub-hivemq-ce-local-service.united-manufacturing-hub:8883 |
| `CAMERA_INTERFACE`            | The interface of the camera                                                                    | string | Any                           | GenICam                                                                              |
| `CUBE_TRANSMITTERID`          | The hostname of the device to which the camera is connected                                    | string | Any                           | default                                                                              |
| `CYCLE_TIME`                  | The time between two consecutive acquisitions. Only relevant when trigger is set to Continuous | string | Valid integer number          | 4                                                                                    |
| `DEFAULT_GENTL_PRODUCER_PATH` | The default path to the GenTL producer                                                         | string | Any                           | /app/assets/producer_files                                                           |
| `EXPOSURE_AUTO`               | Whether the exposure time is automatically adjusted.                                           | string | Once, Off, Continuous         | Off                                                                                  |
| `EXPOSURE_TIME`               | The exposure time of the camera in milliseconds.                                               | string | Valid integer number          | 1000                                                                                 |
| `IMAGE_CHANNELS`              | The number of color channels of the image.                                                     | string | Valid integer number          | 3                                                                                    |
| `IMAGE_HEIGHT`                | The height of the image in number of pixels.                                                   | string | Valid integer number          | 800                                                                                  |
| `IMAGE_WIDTH`                 | The width of the image in number of pixels.                                                    | string | Valid integer number          | 800                                                                                  |
| `LOGGING_LEVEL`               | Defines which logging level is used, mostly relevant for developers.                           | string | PRODUCTION, DEVELOPMENT       | PRODUCTION                                                                           |
| `MAC_ADDRESS`                 | The MAC address of the camera.                                                                 | string | Valid MAC address             | 02-2625A-09849                                                                       |
| `PIXEL_FORMAT`                | The pixel format used in the image.                                                            | string | Mono8, RGB8Packed, BGR8Packed | Mono8                                                                                |
| `TRIGGER`                     | How the camera is triggered, either via MQTT or continuosly.                                   | string | MQTT, Continuous              | MQTT                                                                                 |
{{< /table >}}
