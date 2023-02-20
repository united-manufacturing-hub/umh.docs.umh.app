+++
title = "1. Download & install"
description = "This guide will help you get started with installing and setting up the Management Console on your local computer."
weight = 1
aliases = ["/download"]
+++

**Requirements:** 
- Windows 10 with at least 4 cores, 8 GB of RAM, and 20GB SSD with admin privileges
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed (required for the next chapter)

If your computer meets these requirements, follow these steps to download and install the Management Console:

<a class="btn btn-primary" href="https://download.mgmt.docs.umh.app/UMH%20Management%20Console_latest_x64_en-US.msi" target="_blank" role="button" aria-label="Download the latest version (Windows x64)">Download the latest version (Windows x64)</a>

Now proceed with the installation.

## Installation


1. The installation dialogue opens. Click **"Next"**

    ![The installation wizard](/images/getstarted/installation-wizard.png)

2. Select the installation location. We recommend leaving it at the default option. Click **"Next"**

    ![The installation wizard](/images/getstarted/installation-wizard-2.png)

3. Click **"Next"** to proceed and grant admin privileges when prompted

    ![The installation wizard](/images/getstarted/installation-wizard-3.png)

4. The installation was successful! Check the box "Launch ManagementConsoleFrontend" and click **"Finish"**

    ![The installation wizard](/images/getstarted/installation-wizard-4.png)

The Management Console will automatically open, and you can proceed to create an account.

![The installation wizard](/images/getstarted/installation-wizard-new-account.png)


## Creating an account

1. To create a new account, choose your authentication method (without Yubikey or with Yubikey *(coming soon)*), enter your first name, last name, company name, and email address. You will also need to agree to the general terms of use and privacy policy. 
    
   {{% notice note %}}
   Please note that each email address can only be registered once. To reuse an existing account on a different computer, you will need to [move your account](/docs/account-and-licensing/moving-account/)
   {{% /notice %}}

    ![The installation wizard](/images/getstarted/installation-wizard-new-account.png)

2. When you create an account, the Management Console generates certificates that will be used to identify you in the future when communicating with the Management Server or your instances. These certificates are also used to secure communication to prevent unauthorized access to your data and IT/OT infrastructure. The public part of these certificates is stored on our Management Server, which enables licensing.


## What's next?

After installation, [you can set up the UMH locally on your computer](/docs/getstarted/local-setup/).

If you need more information about the security concept behind the Management Console, please read our [Security Concept](/docs/security/concept/) section.
