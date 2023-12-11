---
title: "Database"
chapter: true
description: "The database stores all `_historian.md` data"
edition: community
weight: 2000
---

Our database for the umh.v1 datamodel currently consists of three tables.

{{% notice note %}}
To learn more about, how we created our database layout and the trade-offs we did, checkout our [learn article](https://learn.umh.app/lesson/data-modeling-in-the-unified-namespace-mqtt-kafka/).
{{% /notice %}}

{{< mermaid theme="neutral" >}}
erDiagram
    asset {
        int id PK "SERIAL PRIMARY KEY"
        text enterprise "NOT NULL"
        text site "DEFAULT '' NOT NULL"
        text area "DEFAULT '' NOT NULL"
        text line "DEFAULT '' NOT NULL"
        text workcell "DEFAULT '' NOT NULL"
        text origin_id "DEFAULT '' NOT NULL"
    }

    tag {
        timestamptz timestamp "NOT NULL"
        text name "NOT NULL"
        text origin "NOT NULL"
        int asset_id FK "REFERENCES asset(id) NOT NULL"
        real value
    }

    tag_string {
        timestamptz timestamp "NOT NULL"
        text name "NOT NULL"
        text origin "NOT NULL"
        int asset_id FK "REFERENCES asset(id) NOT NULL"
        text value
    }

    asset ||--o{ tag : "id"
    asset ||--o{ tag_string : "id"

{{</ mermaid >}}

# asset
This table holds all assets.
Note that all keys except for `id` and `enterprise` are optional.

# tag

This table is a timescale [hypertable](https://docs.timescale.com/use-timescale/latest/hypertables/about-hypertables/).
It holds the values associated to an asset.

# tag_string

This table is the same as tag, but for string values.