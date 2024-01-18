---
title: Management Console Upgrades
content_type: task
description: |
  This section contains all available upgrades that can be performed on the Management Console.
weight: 2000
---

## Management Companion

Here you'll find the instructions on how to upgrade the Mangement Companion of your UMH instance. The Companion plays a crucial
role for a well-functioning UMH instance, therefore it is recommended to keep it up-to-date to take advantage of the latest
features and improvements.

### Prerequisites

Before proceeding with the upgrade of the Companion, ensure that you have the following:

- A functioning UMH instance, verified as "online" and in good health.
- A reliable internet connection.
- Familiarity with the changelog of the new version you are upgrading to, especially to identify any breaking changes or required manual interventions.

### Upgrade Steps

1. Go to the "Overview" tab on the Management Console's dashboard.

2. If your instance has an outdated Companion version, an "upgrade" icon will appear next to the instance's name. Additionally, you'll find the
   "Upgrade Companion" button at the bottom of the "Overview" tab.
   ![Outdated Instance Overview](/images/production-guide/upgrading/instanceOverviewUpgradeButton.png?width=80%)

3. Click the "Upgrade Companion" button. You'll see the changelog, it provides a brief overview of the latest changes, as well as an expandable section to
   view the full changelog, detailing all changes from your current version to the latest version. Additionally, it displays a warning if the upgrade
   requires manual intervention.
   ![Upgrade Changelog](/images/production-guide/upgrading/upgradeChangelog.png?width=80%)

4. Click the "Next" button. You'll see important information to know about, such as what should be done and what should be avoided during the upgrade process.
   ![Upgrade Important Information](/images/production-guide/upgrading/upgradeImportantInfo.png?width=80%)

5. Once you're sure that you're ready to proceed, click the "Upgrade" button. The upgrade process will immediately start, and you'll see a progress bar
   as well as logs of the upgrade process.
   ![Upgrade Progress](/images/production-guide/upgrading/upgradingProgress.png?width=80%)

6. Finally, you should see a success message, indicating that the upgrade was successful. You can now click the "Let's Go" button to return to the dashboard
   and continue using your UMH instance with the latest features and improvements.
   ![Upgrade Success](/images/production-guide/upgrading/upgradingSuccess.png?width=80%)
