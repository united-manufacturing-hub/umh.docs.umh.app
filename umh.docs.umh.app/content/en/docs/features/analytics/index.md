+++
title = "Shopfloor KPIs / Analytics"
menuTitle = "Shopfloor KPIs / Analytics"
description = ""
weight = 3
+++

Introduction sentence

## When should I use it?

If you want to create "Shopfloor Dashboards" for production transparency consisting out of various KPIs and drill-downs. And you do not want to spend hours or even days to calculate the standard stuff yourself and instead want to rely on a standard, but still configurable approach, that works Plug and Play with the United Manufacturing Hub.

![](/images/features/analytics/grafana-canvas.png?width=50%)
![](/images/features/analytics/oee-dashboard.png?width=50%)
{{% notice tip %}}
Press on the image to enlarge them. More examples can be found [in this YouTube video](https://www.youtube.com/watch?v=n3roOntfsgI) and in our [community-repo on GitHub](https://github.com/united-manufacturing-hub/community-repo). 
{{% /notice %}}

## What can I do with it?

The Shopfloor KPI / Analytics feature of the United Manufacturing Hub allows you for each equipment in the ISA95 model to query, visualize and configure Shopfloor KPIs such as OEE.

## Query and visualize

In Grafana, one has the following options to choose:

- Calculate the OEE (incl. Availability, Performance, and Quality) and view trends over time
- Drill-downs into stop reasons (incl. histograms) to identify the root-causes for a potentially low OEE.
- Job and product tables to list all produced and planned orders including target vs actual produced pieces, the total production time, stop reasons per order, etc.
- Timelines about machine states, shifts and orders to easily see what happened during a certain time range
- Produced Pieces and Production Speed over time, to 

### Configure
In the database, one can configure:
- Configure which stop reasons belong into which category for the OEE calculation and whether they should be included in the OEE calculation at all. Example: some companies define changeovers as availability losses, some as performance losses. You can easily move them into the correct category.
- Configure whether to automatically detect/classify certain types of machine states and stops.
    - **AutomaticallyIdentifyChangeovers:** if the machine state was a further unspecified machine stop (UnknownStop), but a order was recently started, the time between start of the order until the machine state turns to running, will be considered a ChangeoverPreparationState (10010). If this happens at the end of the order, it will be a ChangeoverPostprocessingState (10020).
    - **MicrostopDurationInSeconds:** if a further unspecified stop (UnknownStop) has a smaller duration than a configurable threshold (e.g., 120 seconds), it will be considered a MicrostopState (50000) instead. Some companies put small unknown stops into a different category (performance) than larger unknown stops, which usually land up in the availability loss bucket.
    - **IgnoreMicrostopUnderThisDurationInSeconds:** in some cases, the machine can actually stop for a couple of seconds in routine intervals, which might be unwanted as it makes analysis difficult. One can set a threshold to ignore microstops that are smaller than a configurable threshold (usually like 1-2 seconds)
    - **MinimumRunningTimeInSeconds:** same logic if the machine is running for a couple of seconds only. With this configurable threshold small run-times can be ignored. These can happen for example during the changeover phase.
    - **ThresholdForNoShiftsConsideredBreakInSeconds:** If no shift was planned, an UnknownStop will always be classified as an NoShift state. Some companies move smaller NoShift's into their own category called "Break" and move them either into Availability or Performance.
    - **LowSpeedThresholdInPcsPerHour:** for a simplified performance calculation a threshold can be set and if the machine has a lower speed than this, it could be considered a LowSpeedState and could be categorized into Performance loss bucket

{{% notice tip %}}
You can find the configuration options in the [configurationTable](/docs/architecture/datamodel/database/configurationtable/)
{{% /notice %}}

## How can I use it?

Using it is very easy:
1. Send messages according to the [UMH datamodel](/docs/architecture/datamodel/) to the [Unified Namespace](/docs/features/unified-namespace/) (similar to the [Historian feature](/docs/features/historian/))
2. Configure your OEE calculation by adjusting the configuration table
3. Open Grafana, select your equipment and select the analysis you want to have. More information can be found in the [umh-datasource-v2](/docs/architecture/microservices/grafana-plugins/umh-datasource-v2/).

For more information about what exactly is behind the Analytics feature, check out our [our architecture page](/docs/architecture/) and [our datamodel](/docs/architecture/datamodel/)

## What are the limitations?

Limitations are at the moment:


## Where to get more information?
- Learn more about the benefits of using open-source databases in our blog article, [Historians vs Open-Source databases - which is better?](https://learn.umh.app/blog/historians-vs-open-source-databases-which-is-better/)
- Check out the [Getting Started guide](/docs/getstarted/) to start using the Historian feature.
- Learn more about the United Manufacturing Hub's architecture by visiting [our architecture page](/docs/architecture/).
