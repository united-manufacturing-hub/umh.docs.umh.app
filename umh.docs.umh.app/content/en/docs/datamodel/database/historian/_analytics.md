---
title: "Analytics"
chapter: true
description: "How `_analytics` data is stored and can be queried"
weight: 2000
wip: true
---


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


    product_type {
        product_type_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
        external_product_type_id TEXT NOT NULL
        cycle_time_ms INTEGER NOT NULL
        asset_id INTEGER REFERENCES asset(id)
        _ CONSTRAINT "external_product_asset_uniq UNIQUE (external_product_type_id, asset_id)"
        _ CHECK "(cycle_time_ms > 0)"
    }

    work_order {
        work_order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
        external_work_order_id TEXT NOT NULL
        asset_id INTEGER NOT NULL REFERENCES asset(id)
        product_type_id INTEGER NOT NULL REFERENCES product_type(product_type_id)
        quantity INTEGER NOT NULL
        status INTEGER "NOT NULL DEFAULT 0, -- 0: planned, 1: in progress, 2: completed"
        start_time TIMESTAMPTZ
        end_time TIMESTAMPTZ
        _ CONSTRAINT "asset_workorder_uniq UNIQUE (asset_id, external_work_order_id)"
        _ CHECK "(quantity > 0)"
        _ CHECK "(status BETWEEN 0 AND 2)"
        _ UNIQUE "(asset_id, start_time)"
        _ EXCLUDE "USING gist (asset_id WITH =, tstzrange(start_time, end_time) WITH &&) WHERE (start_time IS NOT NULL AND end_time IS NOT NULL)"
    }

    product {
        product_type_id INTEGER REFERENCES product_type(product_type_id)
        product_batch_id TEXT
        asset_id INTEGER REFERENCES asset(id)
        start_time TIMESTAMPTZ
        end_time TIMESTAMPTZ NOT NULL
        quantity INTEGER NOT NULL
        bad_quantity INTEGER "DEFAULT 0"
        _ CHECK "(quantity > 0)"
        _ CHECK "(bad_quantity >= 0)"
        _ CHECK "(bad_quantity <= quantity)"
        _ CHECK "(start_time <= end_time)"
        _ UNIQUE "(asset_id, end_time, product_batch_id)"
        _ HYPERTABLE "create_hypertable('product', 'end_time', if_not_exists => TRUE)"
        _ INDEX "INDEX idx_products_asset_end_time ON product(asset_id, end_time DESC)"
    }

    shift {
        shift_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY
        asset_id INTEGER REFERENCES asset(id)
        start_time TIMESTAMPTZ NOT NULL
        end_time TIMESTAMPTZ NOT NULL
        _ CONSTRAINT "shift_start_asset_uniq UNIQUE (start_time, asset_id)"
        _ CHECK "(start_time < end_time)"
        _ EXCLUDE "USING gist (asset_id WITH =, tstzrange(start_time, end_time) WITH &&)"
    }

    state {
        asset_id INTEGER REFERENCES asset(id)
        start_time TIMESTAMPTZ NOT NULL
        state INT NOT NULL
        _ CHECK "(state >= 0)"
        _ UNIQUE "(start_time, asset_id)"
        _ HYPERTABLE "create_hypertable('states', 'start_time', if_not_exists => TRUE)"
        _ INDEX "INDEX idx_states_asset_start_time ON states(asset_id, start_time DESC)"
    }

    asset ||--o{ work_order : "id"
    asset ||--o{ product_type : "id"
    asset ||--o{ product  : "id"
    asset ||--o{ shift  : "id"
    asset ||--o{ state  : "id"

    work_order ||--o{ product_type  : "product_type_id"
    product ||--o{ product_type  : "product_type_id"

{{</ mermaid >}}

## asset

This table holds all assets.
An asset for us is the unique combination of `enterprise`, `site`, `area`, `line`, `workcell` & `origin_id`.

All keys except for `id` and `enterprise` are optional.
In our example we have just started our CNC cutter, so it's unique asset will get inserted into the database.
It already contains some data we inserted before so the new asset will be inserted at `id: 8`

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

## work_order

This table holds all work orders.
A work order is a unique combination of `external_work_order_id` and `asset_id`.

| work_order_id | external_work_order_id | asset_id | product_type_id | quantity | status | start_time           | end_time             |
|---------------|------------------------|----------|-----------------|----------|--------|----------------------|----------------------|
| 1             | #2475                  | 8        | 1               | 100      | 0      | 2022-01-01T08:00:00Z | 2022-01-01T18:00:00Z |

## product_type

This table holds all product types.
A product type is a unique combination of `external_product_type_id` and `asset_id`.

| product_type_id | external_product_type_id | cycleTime | asset_id |
|-----------------|--------------------------|-----------|----------|
| 1               | desk-leg-0112            | 10.0      | 8        |

## product

This table holds all products.

| product_type_id | product_batch_id | asset_id | start_time           | end_time             | quantity | bad_quantity |
|-----------------|------------------|----------|----------------------|----------------------|----------|--------------|
| 1               | batch-n113       | 8        | 2022-01-01T08:00:00Z | 2022-01-01T08:10:00Z | 100      | 7            |

## shift

This table holds all shifts.
A shift is a unique combination of `asset_id` and `start_time`.

| shiftId | asset_id | start_time           | end_time             |
|---------|----------|----------------------|----------------------|
| 1       | 8        | 2022-01-01T08:00:00Z | 2022-01-01T19:00:00Z |

## state

This table holds all states.
A state is a unique combination of `asset_id` and `start_time`.

| stateId | asset_id | start_time           | state |
|---------|----------|----------------------|-------|
| 1       | 8        | 2022-01-01T08:00:00Z | 20000 |
| 2       | 8        | 2022-01-01T08:10:00Z | 10000 |
