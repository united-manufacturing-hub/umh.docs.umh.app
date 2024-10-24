---
title: "Technical (180000-229999)"
menuTitle: "Technical (180000-229999)"
chapter: false
weight: 7
draft: false
description: "These states represent that the asset has a technical issue."
---

#### 180000: EquipmentFailureState

The asset itself is defect, e.g. a broken engine.

#### Examples for EquipmentFailureState

- WS_Cur_State: Equipment Failure

#### 190000: ExternalFailureState

There is an external failure, e.g. missing compressed air.

#### Examples for ExternalFailureState

- WS_Cur_State: External Failure

#### 200000: ExternalInterferenceState

There is an external interference, e.g. the crane to move the material is currently unavailable.

#### 210000: PreventiveMaintenanceStop

A planned maintenance action. 

#### Examples for PreventiveMaintenanceStop

- WS_Cur_Prog: Program-Maintenance
- PackML: Maintenance
- EUROMAP: MAINTENANCE
- Tobacco: MAINTENANCE

#### 220000: TechnicalOtherStop

The asset has a technical issue, but it is not specified further.

#### Examples for TechnicalOtherStop

- WS_Not_Of_Fail_Code
- PackML: Held
- EUROMAP: MALFUNCTION
- Tobacco: MANUAL
- Tobacco: SET UP
- Tobacco: REMOTE SERVICE
