+++
title = "States"
chapter = true
description = "States are the core of the database model. They represent the state of the machine at a given point in time."
+++


# States Documentation Index

## Introduction
This documentation outlines the various states used in the United Manufacturing Hub software stack to calculate OEE/KPI and other production metrics.

## State Categories
- **[Active (10000-29999)](./active)**: These states represent that the asset is actively producing.
- **[Material (60000-99999)](./material)**: These states represent that the asset has issues regarding materials.
- **[Operator (140000-159999)](./operator)**: These states represent that the asset is stopped because of operator related issues.
- **[Planning (160000-179999)](./planning)**: These states represent that the asset is stopped as it is planned to stop (planned idle time).
- **[Process (100000-139999)](./process)**: These states represent that the asset is in a stop, which belongs to the process and cannot be avoided.
- **[Technical (180000-229999)](./technical)**: These states represent that the asset has a technical issue.
- **[Unknown (30000-59999)](./unknown)**: These states represent that the asset is in an unspecified state.
 


## Glossary
- **OEE**: Overall Equipment Effectiveness
- **KPI**: Key Performance Indicator

## Conclusion
This documentation provides a comprehensive overview of the states used in the United Manufacturing Hub software stack and their respective categories. For more information on each state category and its individual states, please refer to the corresponding subpages.
