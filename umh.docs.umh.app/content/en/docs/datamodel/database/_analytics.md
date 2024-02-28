---
title: "Analytics"
chapter: true
description: "How `_analytics` data is stored and can be queried"
weight: 2000
---

Our database for the umh.v1 `_analytics` datamodel currently consists of three tables.
These are used for the `_historian` schema.
We choose this layout to enable easy lookups based on the asset features, while maintaining separation between data and names.
The split into `tag` & `tag_string` prevents accidental lookups of the wrong datatype, which might break queries such as aggregations, averages, ...

<!--
-- Context for Github Copilot
-- Work Order Table
CREATE TABLE work_orders (
    workOrderId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    externalWorkOrderId TEXT UNIQUE NOT NULL,
    assetId INTEGER NOT NULL REFERENCES assets(id),
    productTypeId INTEGER NOT NULL REFERENCES product_types(productTypeId),
    quantity INTEGER NOT NULL,
    status INTEGER NOT NULL DEFAULT 0, -- 0: planned, 1: in progress, 2: completed
    startTime TIMESTAMPTZ,
    endTime TIMESTAMPTZ,
    CONSTRAINT asset_workorder_uniq UNIQUE (assetId, externalWorkOrderId),
    CHECK (quantity > 0),
    CHECK (status BETWEEN 0 AND 2),
    EXCLUDE USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&) WHERE (startTime IS NOT NULL AND endTime IS NOT NULL)
);

-- Product Type Table
CREATE TABLE product_types (
    productTypeId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    externalProductTypeId TEXT UNIQUE NOT NULL,
    cycleTime REAL NOT NULL,
    assetId INTEGER REFERENCES assets(id),
    CONSTRAINT external_product_asset_uniq UNIQUE (externalProductTypeId, assetId),
    CHECK (cycleTime > 0)
);

-- Product Table
CREATE TABLE products (
    productId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    externalProductTypeId INTEGER REFERENCES product_types(productTypeId),
    assetId INTEGER REFERENCES assets(id),
    startTime TIMESTAMPTZ,
    endTime TIMESTAMPTZ NOT NULL,
    quantity INTEGER NOT NULL,
    badQuantity INTEGER DEFAULT 0,
    CHECK (quantity > 0),
    CHECK (badQuantity >= 0),
    CHECK (startTime <= endTime),
    CONSTRAINT product_endtime_asset_uniq UNIQUE (endTime, assetId)
);

-- creating hypertable
SELECT create_hypertable('products', 'endTime');

-- creating an index to increase performance
CREATE INDEX idx_products_asset_endtime ON products(assetId, endTime DESC);

-- Shifts Table
CREATE TABLE shifts (
    shiftId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    assetId INTEGER REFERENCES assets(id),
    startTime TIMESTAMPTZ NOT NULL,
    endTime TIMESTAMPTZ NOT NULL,
    CONSTRAINT shift_start_asset_uniq UNIQUE (startTime, assetId),
    CHECK (startTime < endTime),
    EXCLUDE USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&)
);

-- State Table
CREATE TABLE states (
    stateId INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    assetId INTEGER REFERENCES assets(id),
    startTime TIMESTAMPTZ NOT NULL,
    state INT NOT NULL,
    CHECK (state >= 0),
    CONSTRAINT state_start_asset_uniq UNIQUE (startTime, assetId)
);
-- creating hypertable
SELECT create_hypertable('states', 'startTime');

-- creating an index to increase performance
CREATE INDEX idx_states_asset_starttime ON states(assetId, startTime DESC);

-->

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

    work_orders {
        workdOrderId INT "GENERATED ALWAYS AS IDENTITY PRIMARY KEY"
        externalWorkOrderId TEXT "UNIQUE NOT NULL"
        assetId INTEGER "REFERENCES assets(id) NOT NULL"
        productTypeId INTEGER "REFERENCES product_types(productTypeId) NOT NULL"
        quantity INTEGER "NOT NULL"
        status INTEGER "NOT NULL DEFAULT 0"
        startTime TIMESTAMPTZ
        endTime TIMESTAMPTZ
        _ CONSTRAINT "asset_workorder_uniqe UNIQUE (assetId, externalWorkOrderId)"
        _ CHECK "(quantity > 0)"
        _ CHECK "(status BETWEEN 0 AND 2)"
        _ EXCLUDE "USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&) WHERE (startTime IS NOT NULL AND endTime IS NOT NULL)"
    }

    product_types {
        productTypeId INT "GENERATED ALWAYS AS IDENTITY PRIMARY KEY"
        externalProductTypeId TEXT "UNIQUE NOT NULL"
        cycleTime REAL "NOT NULL"
        assetId INTEGER "REFERENCES assets(id)"
        _ CONSTRAINT "external_product_asset_uniq UNIQUE (externalProductTypeId, assetId)"
        _ CHECK "(cycleTime > 0)"
    }

    products {
        productId INT "GENERATED ALWAYS AS IDENTITY PRIMARY KEY"
        externalProductTypeId INTEGER "REFERENCES product_types(productTypeId)"
        assetId INTEGER "REFERENCES assets(id)"
        startTime TIMESTAMPTZ
        endTime TIMESTAMPTZ "NOT NULL"
        quantity INTEGER "NOT NULL"
        badQuantity INTEGER "DEFAULT 0"
        _ CHECK "(quantity > 0)"
        _ CHECK "(badQuantity >= 0)"
        _ CHECK "(startTime <= endTime)"
        _ CONSTRAINT "product_endtime_asset_uniq UNIQUE (endTime, assetId)"
        _ HYPERTABLE "create_hypertable('products', 'endTime')"
        _ INDEX "idx_products_asset_endtime ON products(assetId, endTime DESC)"
    }

    shifts {
        shiftId INT "GENEREATED ALWAYS AS IDENTITY PRIMARY KEY"
        assetId INTEGER "REFERENCES assets(id)"
        startTime TIMESTAMPTZ "NOT NULL"
        endTime TIMESTAMPTZ "NOT NULL"
        _ CONSTRAINT "shift_start_asset_uniq UNIQUE (startTime, assetId)"
        _ CHECK "(startTime < endTime)"
        _ EXCLUDE "USING gist (assetId WITH =, tstzrange(startTime, endTime) WITH &&)"
    }

    states {
        stateId INT "GENERATED ALWAYS AS IDENTITY PRIMARY KEY"
        assetId INTEGER "REFERENCES assets(id)"
        startTime TIMESTAMPTZ "NOT NULL"
        state INT "NOT NULL"
        _ CONSTRAINT "state_start_asset_uniq UNIQUE (startTime, assetId)"
        _ CHECK "(state >= 0)"
        _ HYPERTABLE "create_hypertable('states', 'startTime')"
        _ INDEX "INDEX idx_states_asset_starttime ON states(assetId, startTime DESC)"
    }

    asset ||--o{ work_orders : "id"
    asset ||--o{ product_types : "id"
    asset ||--o{ products  : "id"
    asset ||--o{ shifts  : "id"
    asset ||--o{ states  : "id"

    work_orders ||--o{ product_types  : "productTypeId"
    products ||--o{ product_types  : "productTypeId"

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

## work_orders

This table holds all work orders.
A work order is a unique combination of `externalWorkOrderId` and `assetId`.

| workOrderId | externalWorkOrderId | assetId | productTypeId | quantity | status | startTime            | endTime              |
|-------------|---------------------|---------|---------------|----------|--------|----------------------|----------------------|
| 1           | #2475               | 8       | 1             | 100      | 0      | 2022-01-01T08:00:00Z | 2022-01-01T18:00:00Z |

## product_types

This table holds all product types.
A product type is a unique combination of `externalProductTypeId` and `assetId`.

| productTypeId | externalProductTypeId | cycleTime | assetId |
|---------------|-----------------------|-----------|---------|
| 1             | desk-leg-0112         | 10.0      | 8       |

## products

This table holds all products.

| productId | externalProductTypeId | assetId | startTime            | endTime              | quantity | badQuantity |
|-----------|-----------------------|---------|----------------------|----------------------|----------|-------------|
| 1         | 1                     | 8       | 2022-01-01T08:00:00Z | 2022-01-01T08:10:00Z | 100      | 7           |

## shifts

This table holds all shifts.
A shift is a unique combination of `assetId` and `startTime`.

| shiftId | assetId | startTime            | endTime              |
|---------|---------|----------------------|----------------------|
| 1       | 8       | 2022-01-01T08:00:00Z | 2022-01-01T19:00:00Z |

## states

This table holds all states.
A state is a unique combination of `assetId` and `startTime`.

| stateId | assetId | startTime            | state |
|---------|---------|----------------------|-------|
| 1       | 8       | 2022-01-01T08:00:00Z | 20000 |
| 2       | 8       | 2022-01-01T08:10:00Z | 10000 |
