---
title: "Key Performance Indicators"
content_type: task
description: |
    This page explains which KPIs are calculated and how these calculations look specifically.
weight: 1000
---


## Introduction

Key performance indicators, or KPIs, are metrics that are used to measure the performance of a business or organization against its goals.
They are often used to track progress, identify areas for improvement, and make data-driven decisions. Some examples of KPIs include: revenue, profit, customer satisfaction,
employee turnover, and efficiency. These indicators can be specific to a particular department or function within an organization, or they can be more general and apply to the organization as a whole.
The key to using KPIs effectively is to choose the right metrics for your organization and track them regularly to inform decision-making and drive success.

While you are of course free to calculate your own KPIs based on the incoming messages, for example through Node-RED, the United
Manufacturing Hub already calculates some KPIs right out of the box. All you need to do is sending some certain
messages, as we will specify below.



### Availability


The calculation for availability is done to show how much of the time the work cell was planned to run was actually spent productively.
The calculation can be done as long as the work cell uses [state](/docs/production-guide/datamodel/messages/state/)  messages to log its own status.

In this algorithm, the duration of states are calculated for each state. Then the state durations are added up. Full production state durations are
added to the total planned work time, while stopped state durations are added to the total planned work time and the
availability time.

Then the stopped time is subtracted from the planned time and divided by the total planned time to calculate the percentage of the planned time during
which the work cell was not stopped.

```
availability = (planned work time - stopped time) / planned work time
```

### Performance

The calculation for the performance is somewhat more complex. To be able to calculate the performance of a work cell, [state](/docs/production-guide/datamodel/messages/state/)
messages need to be sent regularly, so our system can track if the work cell is running or not.

First the algorithm calculates the durations of the states in the specific timeframe. It then matches the states to either
the machine running or the machine being stopped. Then it calculated the total timeframe, by adding the total running-time and the total stopped
time. The running time of the machine is then divided by the total time the machine was in a state. So the performance equals
the percentage of production time the work cell is running. States that belong to neither of the categories will not be added.



```
performance = running time / (running time + stopped time)
```


### Quality

The quality of a work cell can be calculated if the [count and scrap](/docs/production-guide/datamodel/messages/count/) data for the work cell is present.

To calculate the quality, first the amount of functional products are calculated by subtracting the amount of scrapped items from the total amount of items.

```good items = total items - scrapped items```

Then the good items are divided by the total item count, to gain a percentage of items, which are of adequate quality:

```quality = good items / total items```

### OEE

The Overall Equipment Effectiveness, colloquially knows as the OEE is a measurement, which shows the productivity and profitability
of a production unit. For the OEE of a work cell to be able to be calculated with the United Manufacturing Hub, both [count](/docs/production-guide/datamodel/messages/count/) messages and
[state](/docs/production-guide/datamodel/messages/state/)  messages need to be sent from it

As with the other KPIs, this algorithm first calculates the duration of each state and adds it up for each state.
It then calculates the total running time and stop time of the machine in the time frame.

With these values the "availability and performance rate" is calculated by dividing the running time by the sum of running time and stop time.

The quality of the products is by dividing the adequate quality items by the total amount of items.

As you can tell, the OEE then is a percentage, that gets higher, the more the availability, performance and quality of the
work cell improves.


```
availability and performance rate = running time / (running time + stop time)

quality rate = good items / total items

OEE = availability and performance rate * quality rate
```

### Minor KPIs

These are also very useful metrics, you can request them from factoryinsight through Grafana, like the other KPIs.

#### ProductionSpeed

Production Speed returns you the added count per minute of the work cell. For this type to work, you need to send [count](/docs/production-guide/datamodel/messages/count) messages
with the topic of that particular work cell. This can shed some light onto a situation where the amount of produced pieces is low, even though
the OEE is fairly high.

#### aggregatedStates

AggregatedStates gets all states for the work cell. For this calculation to work exactly as intended, the work cell needs
to have previous information through [state](/docs/production-guide/datamodel/messages/state) messages, [addShift](/docs/production-guide/datamodel/messages/addshift) messages, [endShift](/docs/production-guide/datamodel/messages/endshift) messages,
[count](/docs/production-guide/datamodel/messages/count) messages and [addOrder](/docs/production-guide/datamodel/messages/addorder), [startOrder](/docs/production-guide/datamodel/messages/startorder/) as well as [endOrder](/docs/production-guide/datamodel/messages/endorder) messages.
The order, shift and count messages are required as the algorithm will infer certain states from that data, such as low speed production,
changeover and downtime due to no shifts.

#### Shifts

To get the "Shifts" aggregation of the work cell, you need to send appropriate [addShift](/docs/production-guide/datamodel/messages/addShift)
and [endShift](/docs/production-guide/datamodel/messages/endShift) messages. It aggregates and cleans up the shifts for the designated timeframe.
This includes merging shifts that are adjacent to each other within 10 minutes or less adding "noshift" entries in between shifts.


#### StateHistogram

To create a State Histogram you need data similar to the ones for aggregatedStates. The work cell needs to have sent information
through [state](/docs/production-guide/datamodel/messages/state) messages, [addShift](/docs/production-guide/datamodel/messages/addshift) messages, [endShift](/docs/production-guide/datamodel/messages/endshift) messages,
[count](/docs/production-guide/datamodel/messages/count) messages and [addOrder](/docs/production-guide/datamodel/messages/addorder), [startOrder](/docs/production-guide/datamodel/messages/startorder/) as well as [endOrder](/docs/production-guide/datamodel/messages/endorder) messages.
It then calculates a histogram based on these inputs. The output is a JSON with entries of corresponding states and their length
in the requested timeframe.

#### averageCleaningTime

To calculate the average cleaning time also utilizes the following messages: [state](/docs/production-guide/datamodel/messages/state), [addShift](/docs/production-guide/datamodel/messages/addshift), [endShift](/docs/production-guide/datamodel/messages/endshift),
[count](/docs/production-guide/datamodel/messages/count), and [addOrder](/docs/production-guide/datamodel/messages/addorder), [startOrder](/docs/production-guide/datamodel/messages/startorder/),  as well as [endOrder](/docs/production-guide/datamodel/messages/endorder).
It is then cleaning up the states and calculates the average state times per day and filters for the cleaning time.


#### averageChangeoverTime

To calculate the average changeover time also utilizes the following messages: [state](/docs/production-guide/datamodel/messages/state), [addShift](/docs/production-guide/datamodel/messages/addshift), [endShift](/docs/production-guide/datamodel/messages/endshift),
[count](/docs/production-guide/datamodel/messages/count), [startOrder](/docs/production-guide/datamodel/messages/startorder/), and [addOrder](/docs/production-guide/datamodel/messages/addorder) as well as [endOrder](/docs/production-guide/datamodel/messages/endorder).
It is then cleaning up the states and calculates the average state times per day and filters for the changing time.



#### upcomingMaintenanceActivities

For this calculation to work [maintenanceActivity](/docs/production-guide/datamodel/messages/maintenanceActivity/) messages need to be sent.
It then returns the maintenance activities scheduled for the asset with component name, interval in hours, activity type,
duration and next activity, if possible.

#### maintenanceComponents

For this calculation [maintenanceActivity](/docs/production-guide/datamodel/messages/maintenanceActivity/) messages need to be sent.
The function then returns the distinct names of component saved in the database for this particular work cell.

#### maintenanceActivities

For this calculation [maintenanceActivity](/docs/production-guide/datamodel/messages/maintenanceActivity/) messages need to be sent.
It then works similar to upcomingMaintenanceActivities, it returns the Maintenances with names, timestamps and the components used.
It returns both maintenances in the past and future.

#### orderTable

For this calculation to work as intended, messages on the topics [addOrder](/docs/production-guide/datamodel/messages/addorder/) , [startOrder](/docs/production-guide/datamodel/messages/startorder/), [endOrder](/docs/production-guide/datamodel/messages/endorder/) ,
[count](/docs/production-guide/datamodel/messages/count/) , [state](/docs/production-guide/datamodel/messages/state/) , [addShift](/docs/production-guide/datamodel/messages/addshift/)
and [endShift](/docs/production-guide/datamodel/messages/endshift/).
This is one of our more complicated algorithms and returns a table with all details of orders in this workcells, including:
name of the order, name of the product, start time, end time, target units, actual produced units, target duration, actual duration,
target time per unit, actual time per unit, and the duration of each state during the order.

#### orderTimeline

For this calculation to work, [addOrder](/docs/production-guide/datamodel/messages/addorder) messages and [endOrder](/docs/production-guide/datamodel/messages/endorder) messages need to be sent
for the work cell. The output is a table with the orders and their detailed information, ordered chronologically.

#### accumulatedProducunts

To allow for these calculations, the following message types need to be used: [addOrder](/docs/production-guide/datamodel/messages/addorder/) , [startOrder](/docs/production-guide/datamodel/messages/startorder/), [endOrder](/docs/production-guide/datamodel/messages/endorder/) ,
[count](/docs/production-guide/datamodel/messages/count/) , [state](/docs/production-guide/datamodel/messages/state/) , [addShift](/docs/production-guide/datamodel/messages/addshift/)
and [endShift](/docs/production-guide/datamodel/messages/endshift/).
This algorithm is used to list all produced products with additional information, like target output, actual output, scrap units,
order IDs where this product was relevent, predicted outputs via regression, predicted scraps via regression.

#### unstartedOrderTable

This algorithm is mostly functioning as the regular orderTable, with the difference that the listed orders are not started yet.
For this calculation to work as intended, messages on the topic [addOrder](/docs/production-guide/datamodel/messages/addorder/) needs to be sent.  
This is one of our more complicated algorithms and returns a table with all details of unstarted orders in this workcells, including:
name of the order, name of the product, target units,  target duration and
target time per unit.