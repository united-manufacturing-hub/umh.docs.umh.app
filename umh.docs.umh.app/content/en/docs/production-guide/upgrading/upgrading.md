---
title: Management Console Upgrades
content_type: task
description: |
  This page describes how to perform the upgrades that are available for the Management Console.
weight: 2000
---

<!-- overview -->

Easily upgrade your UMH instance with the Management Console. This page offers clear, step-by-step instructions
for a smooth upgrade process.

## {{% heading "prerequisites" %}}

Before proceeding with the upgrade of the Companion, ensure that you have the following:

- A functioning UMH instance, verified as "online" and in good health.
- A reliable internet connection.
- Familiarity with the changelog of the new version you are upgrading to, especially to identify any breaking changes
  or required manual interventions.

## Management Companion

Upgrade your UMH instance seamlessly using the Management Console. Follow these steps:

### Navigate to the "Overview" Tab

Access the Management Console's dashboard and click on the "Overview" tab.

### Identify Outdated Instance

Look for an "upgrade" icon next to your instance's name if it has an outdated Companion version. Additionally, find
the "Upgrade Companion" button at the bottom of the "Overview" tab.
   ![Outdated Instance Overview](/images/production-guide/upgrading/instanceOverviewUpgradeButton.png?width=80%)

### Initiate the Upgrade

Click the "Upgrade Companion" button. A changelog will appear, offering a quick overview of the latest changes.
Expand to view the full changelog, including details from your current version to the latest version. Any warnings
for manual intervention will also be displayed.

### Review Important Information

Click the "Next" button to access crucial information about what actions should be taken and avoided during the
upgrade process.

### Start the Upgrade

Click the "Upgrade" button when you are ready. Progress updates, including a progress bar and logs, will be displayed
as the upgrade advances.

### Successful Upgrade

Upon successful completion, a message will confirm the upgrade's success. Click the "Let's Go" button to return to
the dashboard and continue using your UMH instance with the latest enhancements.
   ![Upgrade Success](/images/production-guide/upgrading/upgradingSuccess.png?width=80%)

## United Manufacturing Hub

As of now, the upgrade of the UMH is not yet included in the Management Console, meaning that it has to be performed
manually. However, it is planned to be included in the future. Until then, you can follow the instructions in the
[What's New](/docs/whatsnew/) page.

