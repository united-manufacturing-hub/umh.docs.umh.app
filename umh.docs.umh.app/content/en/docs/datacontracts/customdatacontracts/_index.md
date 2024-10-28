---
title: "Custom Data Contracts"
menuTitle: "Custom Data Contracts"
description: "In addition to the standard data contracts provided, you can add your own."
weight: 1725
---



## Example of a custom Data Contract

You can also add your own contracts to your UNS.
For example, implementing a Data Contract to automate MES and PLC interaction.

**Scenario**: When a machine stops, the latest order ID from the MES needs to be automatically written into the PLC.

**Objective**: Utilize data contracts within a Unified Namespace (UNS) to automate data exchange between the MES and PLC, ensuring scalability and maintainability across multiple machines and production lines.

**Approach**:

We begin by utilizing the existing `_historian` data contract to continuously send and store the latest order ID from the MES in the UNS.

Additionally a schema is required to handle action requests and responses, enabling commands like writing data to the PLC, for example `_action`.
Since the `_action` schema does not yet exist, it needs to be manually added first.

Next, implement protocol converters to facilitate communication between systems.
The first **ingiong protocol converter** fetches the latest order ID from the MES and publishes it to the UNS using the `_historian` data contract.
A second **outgoing protocol converter** listens for action requests in the manually added `_action` data contract and executes them by getting the last order ID from the UNS and writing the order ID to the PLC.

Finally, we set up a stream processor that monitors the UNS for specific conditions, such as a machine stoppage. When such a condition is detected, it generates an action request in the `_action` data contract for the output protocol converter to process.

The combination of the Historian Data Contract, the additional `_action` schema, the two Protocol Converters and the stream processor and enforcement of payload and topic structure from this new Data Contract.

**Benefits**:

- **Scalability**: The solution can be templated and applied across various assets.
- **Maintainability**: Leveraging default data contracts reduces complexity and eases system upkeep.
- **Reliability**: Ensures consistent data handling and robust operation within a distributed system.
