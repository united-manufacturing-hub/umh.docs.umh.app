+++
title = "Alerts in Grafana using PostgreSQL"
menuTitle = "Alerts in Grafana using PostgreSQL"
description = ""
weight = 50
draft = false
+++

Introduction sentence

## When should I use it?

  Alerts in Grafana offer real-time monitoring and proactive problem detection, 
  enabling users to swiftly identify and address performance issues or system 
  anomalies. 

## What can I do with it?

  By leveraging custom threshold-based notifications, teams can
  enhance operational efficiency, reduce downtime, and maintain optimal system
  health.

## How can I use it?


### Important Expressions

- **Alert rule:** Define the event and it´s duration that should trigger the alert.
- **Contact point:** Define the contacts and the contact methode (Slack, Discord, …).
- **Notification policies:** Link the contact points to the alert rules.
- **Label:** Labels are tags for the alerts. For example different teams, 
  factories, production lines or a priority.
- **Silences and mute time:** You can mute an alert for a specific amount of time
  or a planed time frame (for example maintenance).

### Installation

1. **Install the PostgreSQL plugin in Grafana**
   - Hover over the "Configuration" button in the bottom left corner and 
        click on "Data sources".
   - Click on "Plugins" and search for PostgreSQL, then install the plugin.
  
2. **Add an alert rule**

   The first thing to do is create the alert rule itself, which specifies when
   Grafana should trigger an alert. To add a new rule, hover over the bell 
   symbol on the far left and click on "Alert Rules". Then click on the blue
   "+ Create alert rule" button.
   
     1. First, choose a name for your rule.
     2. In the second section, you need to select and manipulate the value that 
       triggers your alert and set the rule itself.
        - Subsection A is by default the selection of your values: You can use
          the Grafana builder for this, but it is not very useful, as it cannot  
          select a time interval even though there is a selector for it. If you
          choose, for example, now-20s to now, your query will select values from
          hours ago. Therefore, it is necessary to use SQL directly. To add code
          manually, switch to "Code" in the right corner of the section.
          - First, you must select the value you want to create an alert for. In 
            the UMH data structure, a process value is stored in the table
            ['processvaluetable']
            (https://umh.docs.umh.app/docs/architecture/datamodel/database/processvaluetable/)
            under the column 'value'. Unfortunately Grafana cannot differentiate 
            between different values; if you select the "ConcentrationNH3" value 
            from the example and more than one of the selected values violates
            your rule in the selected time interval, it will trigger multiple
            alerts but Grafana will not be able to differentiate them. This results
            in errors. Therefore, you must filter the values. To do this, you
            need the "timestamp" value. So the first part of the SQL command is:
            "**SELECT value, "timestamp"**".
          - The source is 'processvaluetable', so add "**FROM processvaluetable**"
            at the end.
          - The different values are distinguished by the variable
            'valuename' in the 'processvaluetable', so add
            "**WHERE valuename= 'Name you chose in NodeRed'**" to select only the
            value you need. If you followed the tutorial linked above, use 
            'ConcentrationNH3' as the name.
          - Since the selection of the time interval in Grafana is not working,
            you must add this manually as an addition to the "**WHERE**" command:
            "**WHERE valuename= 'Name you chose in NodeRed' AND "timestamp" > 
            (NOW() - INTERVAL 'X seconds')**". 'X' is the number of seconds of
            you want to query. It's not useful to set 'X' to less than
            10 seconds, as this is the fastest interval Grafana can check your
            rule, and you might miss values at the beginning.

          The complete command is: **SELECT value, "timestamp" FROM 
          processvaluetable WHERE valuename= 'ConcentrationNH3' AND "timestamp"> 
          (NOW() - INTERVAL '10 seconds')**. The ‘ and " might not be copied 
          correctly and produce an error.
   
        - In subsection B, you need to reduce the values to numbers, 
          Grafana can work with. 
          By default, the "Reduce" function will already be selected. However,
          you can change the function by clicking the pencil icon next to the 
          letter "B". For this example, we will create an upper limit. So 
          selecting "Max" as the "Function" is the best choice. Set "Input" as
          "A" (the output of the first section) and choose "Strict" for the "Mode."
        - In subsection C, you can establish the rule. If you select "Math," you
          can utilize expressions like "$B > 50" to trigger an alert when a value
          from section "B" ($B means the output from section B) exceeds 50. In 
          this case, only the largest value selected in A is passed through the 
          reduce function form B to C.
          A simpler way to set such a limit is by choosing "Threshold" instead
          of "Math."
       
        To add queries or expressions, find the buttons at the end of Section 2 
        and click on the desired option. You can also preview the results of your
        querys and functions by clicking on "preview".
     
     3. Section 3 outlines the rule location, timer interval for rule checking, 
        and the duration before an alert is triggered.
        - Select a name for your rule's folder or add it to an existing 
          one by clicking the arrow. Find all your rules grouped in these folders 
          on the "Alert rules" page under "Alerting".
        - The "Evaluation group" is a grouping of rules, which are checked 
          after the same time interval. Creating a new group requires setting a
          time interval for rule checking. The minimum interval
          from Grafana is 10 seconds.
        - Specify the duration the rule must be violated before triggering an
          alert. For example, with a 10-second check interval and a 20-second
          duration, the rule must be broken twice before an alert is fired.
   
     4. In section 4, you can add details and descriptions for your rule.
     
     5. In section 5, you are required to assign labels to your alerts, ensuring
        they are directed to the appropriate contacts. For instance, you may
        designate a label "team" with "alertrule1: team = operator" and
        "alertrule2: team = management".  It can be usefully to use labels more
        than once, like  "alertrule3: team = operator".
     
     Your rule is now completed, click on “Save and Exit” on the right upper 
     corner, next to section one.

3. **Create a Contact Point** 

     A contact point consolidates addresses and services to be notified. When a
     linked alert is triggered, everyone within the contact point receives a 
     message.
   - Click on the blue "+ Add contact point" button.
   - Choose a name for your contact point.
   - Pick the receiving service, here Discord.
   - Generate a new Webhook in your Discord server (Server Settings → Integrations
     → View Webhooks → New Webhook / create Webhook). Assign a name to the Webhook 
     and designate the messaging channel. Copy the Webhook URL from Discord and 
     insert it into the corresponding field in Grafana. Customize the message to 
     Discord under "Optional Discord settings" if desired.
   - Add more services to the contact point, if needed, by clicking "+ Add 
     contact point integration".
   - Save the contact point to see it in the "Contact points" list, below the
     "grafana-default-email" contact point.

4. **Configure Notification Policies**

     The notification policy page allows you to link alerts with their contact 
     points.

   - Select "+ New specific policy" to create a new policy followed by "+ Add 
     matcher" to choose the label and value from the alert
     (e.g., "team = operator" for alertrule1 and alertrule3). In the provided 
     example, both alert1 and alert3 will be forwarded to the associated contact
     point. You can include multiple labels in a single notification policy.
   - Choose the contact point designated to receive the alert notifications.
   - Press "Save policy" to finalize your settings. Your new policy will now be 
     displayed in the list.

5. **Configure Mute Policies and Silences**

   To avoid receiving alerts during specific time periods, create a mute policy
   that allows you to designate the hours, days, months, and years when alerts 
   will be silenced. To set up a mute policy, remain in the 
   "Notification Policies" section.
   - Select "+ Add mute timing".
   - Choose a name for the policy.
   - Specify the time during which notifications should be suppressed.
     - Time should be in UTC and formatted as HH:MM. Use "06:00" instead of 
       "6:00" to avoid an error in Grafana.
   - Click "Submit" to save your settings.
   - To apply the mute timing to a notification policy, click "edit" on the
     right side of the notification policy, and then select the desired mute 
     timing from the drop-down menu at the bottom of the policy.
   
   You can also add “Silences” for a specific time frame and labels, in case 
   you only want to mute alerts once.

## What are the limitations?

It can be difficult to select and manipulate the desired values to
create the correct function for your desired use.

## Where to get more information?
- [The Grafana Page for Alerting](https://grafana.com/docs/grafana/latest/alerting/)
- [The ProcessValueTable](https://umh.docs.umh.app/docs/architecture/datamodel/database/processvaluetable/)
- [Access the Database](https://umh.docs.umh.app/docs/production-guide/administration/access-database/#access-the-database-using-grafana)

