+++
title = "Alerting"
menuTitle = "Alerting"
description = ""
weight = 50
draft = false
+++

  The United Manufacturing Hub utilizes a TimescaleDB database, which is based 
  on PostgreSQL. Therefore, you can use the PostgreSQL plugin in Grafana to 
  implement and configure alerts and notifications.


## Why should I use it?

  Alerts based on real-time data enable proactive problem detection.
  For example, you will receive a notification if the temperature of machine
  oil or an electrical component of a production line exceeds limitations.
  By utilizing such alerts, you can schedule maintenance, enhance efficiency, 
  and reduce downtime in your factories.

## What can I do with it?

  Grafana alerts help you keep an eye on your production and manufacturing 
  processes. By setting up alerts, you can quickly identify problems,
  ensuring smooth operations and high-quality products. 
  An example of using alerts is the tracking of the temperature 
  of an industrial oven. If the temperature goes too high or too low, you 
  will get an alert, and the responsible team can take action before any damage 
  occurs. Alerts can be configured in many different ways, for example,
  to set off an alarm if a maximum is reached once or if it exceeds a limit when
  averaged over a time period. It is also possible to include several values
  to create an alert, for example if a temperature surpasses a limit and/or the 
  concentration of a component is too low. Notifications can be sent
  simultaneously across many services like Discord, Mail, Slack, Webhook,
  Telegram, or [Microsoft Teams](https://learn.umh.app/blog/how-to-install-grafana-alerts-in-microsoft-teams/). It is also possible to forward the alert with
  SMS over a personal Webhook. A complete list can be found on the
  [Grafana page](https://grafana.com/docs/grafana/latest/alerting/manage-notifications/manage-contact-points/configure-integrations/)
  about alerting.

## How can I use it?

  For a detailed tutorial on how to set up an alert, please visit our learn page 
  with the detailed [step-by-step tutorial](https://learn.umh.app/alerts-in-grafana/). Here you
  can find an overview of the process. 

1. **Install the PostgreSQL plugin in Grafana:**
  Before you can formulate alerts, you need to install the PostgreSQL plugin, 
  which is already integrated into Grafana.
  
2. **Alert Rule:**
  When creating an alert, you first have to set the alert rule in Grafana. Here
  you set a name, specify which values are used for the rule, and
  when the rule is fired. Additionally, you can add labels for your rules,
  to link them to the correct contact points. You have to use SQL to select the 
  desired values.

3. **Contact Point:**
  In a contact point you create a collection of addresses and services that 
  should be notified in case of an alert. This could be a Discord channel or
  Slack for example. When a linked alert is triggered, everyone within the 
  contact point receives a message. The messages can be preconfigured and are 
  specific to every service or contact.

4. **Notification Policies:**
  In a notification policy, you establish the connection of a contact point 
  with the desired alerts. This is done by adding the labels of the desired
  alerts and the contact point to the policy.

5. **Mute Timing:**
  In case you do not want to receive messages during a recurring time 
  period, you can add a mute timing to Grafana. If added to the notification 
  policy, no notifications will be sent out by the contact point. This could be 
  times without shifts, like weekends or during regular maintenance.

6. **Silence:**
  You can also add silences for a specific time frame and labels, in case 
  you only want to mute alerts once.

  An alert is only sent out once 
  after being triggered. For the next alert, it has to return to the normal 
  state, so the data no longer violates the rule.

## What are the limitations?

  It can be complicated to select and manipulate the desired values to create
  the correct function for your application. Grafana cannot
  differentiate between data points of the same source. For example, you
  want to make a  temperature threshold based on a single sensor.
  If your query selects the last three values and two of them are above the
  threshold, Grafana will fire two alerts which it cannot tell apart.
  This results in errors. You have to configure the rule to reduce the selected 
  values to only one per source to avoid this.
  It can be complicated to create such a specific rule with this limitation, and
  it requires some testing. 
  
  Another thing to keep in mind is that the alerts can only work with data from
  the database. It also does not work with the machine status; these values only 
  exist in a raw, unprocessed form in TimescaleDB and are not processed through 
  an API like process values.

## Where to get more information?
  - [Detailed step-by-step tutorial](https://learn.umh.app/https://learn.umh.app/alerts-in-grafana/)
  - [The Grafana page about alerting](https://grafana.com/docs/grafana/latest/alerting/)
  - [How to add Grafana to Teams](https://learn.umh.app/blog/how-to-install-grafana-alerts-in-microsoft-teams/)
