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

### Identify Outdated Instance

From the **Overview** tab, check for an upgrade icon next to your instance's name, signaling an outdated Companion version.
Additionally, locate the **Upgrade Companion** button at the bottom of the tab.
![Outdated Instance Overview](/images/production-guide/upgrading/instanceOverviewUpgradeButton.png?width=80%)

### Start the Upgrade

When you're prepared to upgrade your UMH instance, start by pressing the **Upgrade Companion** button. This will open a modal, 
initially displaying a changelog with a quick overview of the latest changes. You can expand the changelog for a detailed view 
from your current version up to the latest one. Additionally, it may highlight any warnings requiring manual intervention.

Navigate through the changelog, and when comfortable, proceed by clicking the **Next** button. This step grants you access to
crucial information about recommended actions and precautions during the upgrade process.

With the necessary insights, take the next step by clicking the **Upgrade** button. The system will guide you through the upgrade
process, displaying real-time progress updates, including a progress bar and logs.

Upon successful completion, a confirmation message will appear. Simply click the **Let's Go** button to return to the dashboard,
where you can seamlessly continue using your UMH instance with the latest enhancements.
   ![Upgrade Success](/images/production-guide/upgrading/upgradingSuccess.png?width=80%)

## United Manufacturing Hub

As of now, the upgrade of the UMH is not yet included in the Management Console, meaning that it has to be performed
manually. However, it is planned to be included in the future. Until then, you can follow the instructions in the
[What's New](/docs/whatsnew/) page.

## {{% heading "troubleshooting" %}}
If you encounter issues during the upgrade process, consider the following steps:

1. **Retry the Process:** Sometimes, a transient issue may cause a hiccup. Retry the upgrade process to ensure it's not a
   temporary glitch.

2. **Check Logs:** Review the logs displayed during the upgrade process for any error messages or indications of what might
   be causing the problem. This information can offer insights into potential issues.

If the problem persists after retrying and checking the logs, and you've confirmed that all prerequisites are met, please
reach out to our support team for assistance.
