+++
title = "Retrofitting with ifm IO-link gateways and sensorconnect"
menuTitle = "Retrofitting with ifm IO-link gateways and sensorconnect"
description = ""
weight = 4
draft = false
+++

## Introduction

Retrofitting older machines with sensors is sometimes the only-way to capture process-relevant information for valuable insights.
In this article, we will focus on retrofitting with ifm IO-link gateways and Sensorconnect, a microservice of the 
united manufacturing hub, that finds and reads out ifm IO-link masters in the network and pushes sensor data to 
MQTT/Kafka for further processing.

## When should I use it?

Retrofitting with ifm IO-link gateways and using Sensorconnect is ideal when dealing with older machines that are not
equipped with any connectable hardware to read relevant information out of the machine itself. By placing sensors on 
the machine and connecting them with ifm IO-link gateways, required information can be gathered for valuable
insights. Sensorconnect helps to easily connect to all sensors to correctly and properly capture the large 
amount of sensor data provided.

## What can I do with it?

With ifm IO-link gateways and Sensorconnect, you can collect data from sensors and make it accessible for further use. 
Sensorconnect offers: 
- automatic detection of ifm IO-link master in the network
- identification of IO-Link or other digital sensors connected to the gateways
- constant polling of data from the detected sensors with a high frequency
- interpreting the received data based on a sensor database containing thousands of entries
- sending data in JSON format to MQTT and Kafka for further data processing


## How can I use it?
To use ifm IO-link gateways and [Sensorconnect](/docs/architecture/microservices/core/sensorconnect/), you need to first
retrofit the machine with the desired sensors and connect them with ifm IO-link gateways. Then, you can use 
Sensorconnect to detect the IO-link master in the network, poll data from the connected sensors, and interpret the data based on a sensor database. Finally, you can send the data
in JSON format to MQTT and Kafka for further processing with your preferred software solutions.

## What are the limitations?

- the current ifm firmware has a software bug, that will cause the IO-link master to crash if it receives to many requests.
  An experimental firmware is available upon request

## Where to get more information?

- [retrofitting the shopfloor with plug play sensors](https://learn.umh.app/blog/connectivity-retrofitting-the-shopfloor-with-plug-play-sensors/)
- [retrofitting](https://learn.umh.app/lesson/introduction-into-it-ot-retrofitting/)
- [documentation of sensorconnet](/docs/architecture/microservices/core/sensorconnect/)