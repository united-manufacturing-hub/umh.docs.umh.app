---
title: "Material (60000-99999)"
menuTitle: "Material (60000-99999)"
chapter: false
weight: 3
draft: false
description: "These states represent that the asset has issues regarding materials."
---

#### 60000 InletJamState

This machine does not perform its intended function due to a lack of material flow in the infeed of the machine, detected by the sensor system of the control system (machine stop). In the case of machines that have several inlets, the condition o lack  in the inlet refers to the main flow , i.e. to the material (crate, bottle) that is fed in the direction of the filling machine (Central machine). The defect in the infeed is an extraneous defect, but because of its importance for visualization and technical reporting, it is recorded separately. 

#### Examples for InletJamState

- WS_Cur_State: Lack

#### 70000: OutletJamState

The machine does not perform its intended function as a result of a jam in the good flow discharge of the machine, detected by the sensor system of the control system (machine stop). In the case of machines that have several discharges, the jam in the discharge condition refers to the main flow, i.e.  to the good (crate, bottle) that is fed in the direction of the filling machine (central machine) or is fed away from the filling machine. The jam in the outfeed is an external fault 1v, but it is recorded separately, because of its importance for visualization and technical reporting. 

#### Examples for OutletJamState

- WS_Cur_State: Tailback

#### 80000: CongestionBypassState

The machine does not perform its intended function due to a shortage in the bypass supply or a jam in the bypass discharge of the machine, detected by the sensor system of the control system (machine stop). This condition can only occur in machines with two outlets or inlets and in which the bypass is in turn the inlet or outlet of an upstream or downstream machine of the filling line (packaging and palleting machines). The jam/shortage in the auxiliary flow is an external fault, but it is recoded separately due to its importance for visualization and technical reporting. 

#### Examples for the CongestionBypassState

- WS_Cur_State: Lack/Tailback Branch Line

#### 90000: MaterialIssueOtherState

The asset has a material issue, but it is not further specified.

#### Examples for MaterialIssueOtherState

- WS_Mat_Ready (Information of which material is lacking)
- PackML/Tobacco: Suspended
