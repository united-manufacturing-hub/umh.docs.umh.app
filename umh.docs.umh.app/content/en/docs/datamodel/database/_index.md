---
title: "Database"
chapter: true
description: "The database stores all `_historian` data"
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

## Example
| id | enterprise       | site     | area   | line        | workcell | origin_id |
|----|------------------|----------|--------|-------------|----------|-----------|
| 1  | acme-corporation |          |        |             |          |           |
| 2  | acme-corporation | new-york |        |             |          |           |
| 3  | acme-corporation | london   | north  | assembly    |          |           |
| 4  | stark-industries | berlin   | south  | fabrication | cell-a1  | 3002      |
| 5  | stark-industries | tokyo    | east   | testing     | cell-b3  | 3005      |
| 6  | stark-industries | paris    | west   | packaging   | cell-c2  | 3009      |
| 7  | umh              | cologne  | office | dev         | server1  | sensor0   |

# tag

This table is a timescale [hypertable](https://docs.timescale.com/use-timescale/latest/hypertables/about-hypertables/).
It holds the values associated to an asset.

`origin` holds the origin as set by the `x-origin` header, if unset it defaults to `unknown`

## Example
If you send data to `umh/v1/umh/cologne/office/dev/server1/sensor0` using this payload:
```json
{
  "timestamp_ms": 1702290705,
  "temperature_c": 80
}
```
This will insert 

# tag_string

This table is the same as tag, but for string values.