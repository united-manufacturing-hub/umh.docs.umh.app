---
title: "Active (10000-29999)"
menuTitle: "Active (10000-29999)"
chapter: false
weight: 1
draft: false
description: "These states represent that the asset is actively producing"
---

#### 10000: ProducingAtFullSpeedState

This asset is running at full speed.

#### Examples for ProducingAtFullSpeedState

- WS_Cur_State: Operating
- PackML/Tobacco: Execute

#### 20000: ProducingAtLowerThanFullSpeedState

Asset is producing, but not at full speed.

#### Examples for ProducingAtLowerThanFullSpeedState

- WS_Cur_Prog: StartUp
- WS_Cur_Prog: RunDown
- WS_Cur_State: Stopping
- PackML/Tobacco : Stopping
- WS_Cur_State: Aborting
- PackML/Tobacco: Aborting
- WS_Cur_State: Holding
- Ws_Cur_State: Unholding
- PackML:Tobacco: Unholding
- WS_Cur_State Suspending
- PackML/Tobacco: Suspending
- WS_Cur_State: Unsuspending
- PackML/Tobacco: Unsuspending
- PackML/Tobacco: Completing
- WS_Cur_Prog: Production
- EUROMAP: MANUAL_RUN
- EUROMAP: CONTROLLED_RUN

Currently not included: 

- WS_Prog_Step: all
