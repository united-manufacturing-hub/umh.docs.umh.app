---
title: "Unknown (30000-59999)"
menuTitle: "Unknown (30000-59999)"
chapter: false
weight: 2
draft: false
deprecated: true
description: "These states represent that the asset is in an unspecified state"
aliases:
  - /docs/architecture/datamodel_old/states/unknown/
---

#### 30000: UnknownState

Data for that particular asset is not available (e.g. connection to the PLC is disrupted)

#### Examples for UnknownState

- WS_Cur_Prog: Undefined
- EUROMAP: Offline

#### 40000 UnspecifiedStopState

The asset is not producing, but the reason is unknown at the time. 

#### Examples for UnspecifiedStopState

- WS_Cur_State: Clearing
- PackML/Tobacco: Clearing
- WS_Cur_State: Emergency Stop
- WS_Cur_State: Resetting
- PackML/Tobacco: Clearing
- WS_Cur_State: Held
- EUROMAP: Idle
- Tobacco: Other
- WS_Cur_State: Stopped
- PackML/Tobacco: Stopped
- WS_Cur_State: Starting
- PackML/Tobacco: Starting 
- WS_Cur_State: Prepared
- WS_Cur_State: Idle
- PackML/Tobacco: Idle
- PackML/Tobacco: Complete
- EUROMAP: READY_TO_RUN

#### 50000: MicrostopState

The asset is not producing for a short period (typically around five minutes), but the reason is unknown at the time.
