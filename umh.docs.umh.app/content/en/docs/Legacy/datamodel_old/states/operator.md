---
title: "Operator (140000-159999)"
menuTitle: "Operator (140000-159999)"
chapter: false
weight: 5
draft: false
deprecated: true
description: "These states represent that the asset is stopped because of operator related issues."
aliases:
  - /docs/architecture/datamodel_old/states/operator/
---


#### 140000: OperatorNotAtMachineState

The operator is not at the machine. 

#### 150000: OperatorBreakState

The operator is taking a break. 

{{% notice tip %}}
This is different from a planned shift as it could contribute to performance losses. 
{{% /notice %}}

#### Examples for OperatorBreakState

- WS_Cur_Prog: Program-Break

