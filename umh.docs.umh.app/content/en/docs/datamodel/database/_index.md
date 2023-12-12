---
title: "Database"
chapter: true
description: "The database stores all `_historian` data"
weight: 2000
---

Our database for the umh.v1 datamodel currently consists of three tables.
These are used for the `_historian` schema.
We choose this layout to enable easy lookups based on the asset features, while maintaining separation between data and names.
The split into `tag` & `tag_string` prevents accidental lookups of the wrong datatype, which might break queries such as aggregations, averages, ...


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
An asset for us is the unique combination of `enterprise`, `site`, `area`, `line`, `workcell` & `origin_id`.

All keys except for `id` and `enterprise` are optional.
In our example we have just started our CNC cutter, so it's unique asset will get inserted into the database.
It already contains some data we inserted before so the new asset will be inserted at `id: 8`

## Example
| id | enterprise         | site     | area       | line        | workcell | origin_id |
|----|--------------------|----------|------------|-------------|----------|-----------|
| 1  | acme-corporation   |          |            |             |          |           |
| 2  | acme-corporation   | new-york |            |             |          |           |
| 3  | acme-corporation   | london   | north      | assembly    |          |           |
| 4  | stark-industries   | berlin   | south      | fabrication | cell-a1  | 3002      |
| 5  | stark-industries   | tokyo    | east       | testing     | cell-b3  | 3005      |
| 6  | stark-industries   | paris    | west       | packaging   | cell-c2  | 3009      |
| 7  | umh                | cologne  | office     | dev         | server1  | sensor0   |
| 8  | cuttingincoperated | cologne  | cnc-cutter |             |          |           |

# tag

This table is a timescale [hypertable](https://docs.timescale.com/use-timescale/latest/hypertables/about-hypertables/).
These tables are optimized to contain a large amount of data which is roughly sorted by time.

In our example we send data to `umh/v1/cuttingincorperated/cologne/cnc-cutter/_historian/head` using the following JSON:
```json
{
 "timestamp_ms": 1670001234567,
  "pos_x": 12.5,
  "pos_y": 7.3,
  "pos_z": 3.2,
  "temperature": 50.0,
  "collision": false
}
```

This will result in the following table entries:

| timestamp     | name             | origin  | asset_id | value |
|---------------|------------------|---------|----------|-------|
| 1670001234567 | head_pos_x       | unknown | 8        | 12.5  |
| 1670001234567 | head_pos_y       | unknown | 8        | 7.3   |
| 1670001234567 | head_pos_z       | unknown | 8        | 3.2   |
| 1670001234567 | head_temperature | unknown | 8        | 50.0  |
| 1670001234567 | head_collision   | unknown | 8        | 0     |



{{% notice note %}}
The origin is a placeholder for a later feature, and currently defaults to `unknown`.
{{% /notice %}}


# tag_string

This table is the same as tag, but for string data.
Our CNC cutter also emits the G-Code currently processed.
`umh/v1/cuttingincorperated/cologne/cnc-cutter/_historian`
```json
{
 "timestamp_ms": 1670001247568,
  "g-code": "G01 X10 Y10 Z0"
}
```

Resulting in this entry:

| timestamp     | name   | origin  | asset_id | value          |
|---------------|--------|---------|----------|----------------|
| 1670001247568 | g-code | unknown | 8        | G01 X10 Y10 Z0 |

# SQL Lookup

TODO