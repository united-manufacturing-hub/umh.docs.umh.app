---
title: "Process(100000-139999)"
menuTitle: "Process(100000-139999)"
chapter: false
weight: 4
draft: false
description: "These states represent that the asset is in a stop, which belongs to the process and cannot be avoided. "
---




#### 100000: ChangeoverState

The asset is in a changeover process between products.

#### Examples for ChangeoverState

- WS_Cur_Prog: Program-Changeover
- Tobacco: CHANGE OVER

#### 110000: CleaningState

The asset is currently in a cleaning process.

#### Examples for CleaningState

- WS_Cur_Prog: Program-Cleaning
- Tobacco: CLEAN

##### 120000: EmptyingState
 
The asset is currently emptied, e.g. to prevent mold for food products over the long breaks, e.g. the weekend.

##### Examples for EmptyingState

- Tobacco: EMPTY OUT

#### 130000: SettingUpState

This machine is currently preparing itself for production, e.g. heating up. 

##### Examples for SettingUpState

- EUROMAP: PREPARING
