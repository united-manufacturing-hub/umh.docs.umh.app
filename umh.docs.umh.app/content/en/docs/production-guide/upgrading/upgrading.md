---
title: Management Console Upgrades
content_type: task
description: |
  This page describes how to perform the upgrades that are available for the Management Console.
weight: 2000
---

<!-- overview -->

The Management Console simplifies the upgrade process for both the Management Companion and the UMH stack (not yet available).
This page provides detailed instructions on executing these upgrades.

## Management Companion

Upgrade the Management Companion of your UMH instance to leverage the latest features and improvements.

### {{% heading "prerequisites" %}}

Before proceeding with the upgrade of the Companion, ensure that you have the following:

- A functioning UMH instance, verified as "online" and in good health.
- A reliable internet connection.
- Familiarity with the changelog of the new version you are upgrading to, especially to identify any breaking changes or required manual interventions.

### Steps

1. Navigate to the "Overview" tab on the Management Console's dashboard.

2. If your instance has an outdated Companion version, an "upgrade" icon will appear next to the instance's name. Additionally, find the
   "Upgrade Companion" button at the bottom of the "Overview" tab.
   ![Outdated Instance Overview](/images/production-guide/upgrading/instanceOverviewUpgradeButton.png?width=80%)

3. Click the "Upgrade Companion" button. The changelog provides a brief overview of the latest changes and an expandable section to
   view the full changelog, detailing changes from your current version to the latest version. It also displays a warning if manual intervention is required.
   ![Upgrade Changelog](/images/production-guide/upgrading/upgradeChangelog.png?width=80%)

4. Click the "Next" button to access important information about what should be done and avoided during the upgrade process.
   ![Upgrade Important Information](/images/production-guide/upgrading/upgradeImportantInfo.png?width=80%)

5. Once ready, click the "Upgrade" button. A progress bar and logs will be displayed during the upgrade process.
   ![Upgrade Progress](/images/production-guide/upgrading/upgradingProgress.png?width=80%)

6. Upon success, a message will indicate a successful upgrade. Click the "Let's Go" button to return to the dashboard and continue using your UMH instance with the latest enhancements.
   ![Upgrade Success](/images/production-guide/upgrading/upgradingSuccess.png?width=80%)

## United Manufacturing Hub

As of now, the upgrade of the UMH is not yet included in the Management Console, meaning that it has to be performed manually.
However, it is planned to be included in the future. Until then, you can follow the instructions in the
[Archive Upgrading page](/docs/production-guide/upgrading/archive/) section of the Production Guide.
