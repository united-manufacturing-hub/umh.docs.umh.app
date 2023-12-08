---
title: "Messages"
chapter: true
description: "All available messages"
---

{{<mermaid theme="neutral" >}}
flowchart LR
    umh --> v1
    v1 --> enterprise
    enterprise -->|Optional| site
    site -->|Optional| area
    area -->|Optional| productionLine
    productionLine -->|Optional| workCell
    workCell -->|Optional| originID
    originID -->|Optional| _schema --> |Optional| tagName
    _schema --> |Optional| tagGroup
    tagGroup --> tagName
    
    classDef mqtt fill:#00aa00,stroke:#333,stroke-width:4px;
    class umh,v1,enterprise,_schema mqtt;
    classDef optional fill:#779977,stroke:#333,stroke-width:4px;
    class site,area,productionLine,workCell,originID,tagGroup,tagName optional;
    
    enterprise -.-> _schema
    site -.-> _schema
    area -.-> _schema
    productionLine -.-> _schema
    workCell -.-> _schema
    tagGroup -.-> |1-N| tagGroup
{{</ mermaid >}}

# Forwarding and processing

{{<mermaid theme="neutral" >}}
flowchart TB
historian[_historian]
analytics[_analytics]
other[Other]
local[_local]

    processed[Processed]
    forwarded[Forwarded]

    historian --> processed
    historian --> forwarded
    analytics --> processed
    analytics --> forwarded
    other --> forwarded

    classDef schema fill:#add8e6,stroke:#333,stroke-width:2px;
    class historian,analytics,local,other schema;

    classDef action fill:#90ee90,stroke:#333,stroke-width:2px;
    class processed,forwarded action;

{{</ mermaid >}}