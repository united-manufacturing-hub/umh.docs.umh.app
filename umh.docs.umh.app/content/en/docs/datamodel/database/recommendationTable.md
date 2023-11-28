---
title: "recommendationTable"
description: "recommendationTable contains given recommendation for the shop floor assets."
aliases:
  - /docs/architecture/datamodel/database/recommendationtable/
---

## Usage

This table stores recommendations

## Structure

| key                    | data type     | description                                     | example                     |
|------------------------|---------------|-------------------------------------------------|-----------------------------|
| `uid`                  | `text`        | Id of the recommendation                        | refill_toner                 |
| `timestamp`            | `timestamptz` | Timestamp of recommendation insertion           | 1                           |
| `recommendationType`   | `integer`     | Used to subscribe people to specific types only | 3                           |
| `enabled`              | `bool`        | Recommendation can be outputted                 | true                        |
| `recommendationValues` | `text`        | Values to change to resolve recommendation      | { "toner-level": 100 }      |
| `diagnoseTextDE`       | `text`        | Diagnose text in german                         | "Der Toner ist leer"        |
| `diagnoseTextEN`       | `text`        | Diagnose text in english                        | "The toner is empty"        |
| `recommendationTextDE` | `text`        | Recommendation text in german                   | "Bitte den Toner auffüllen" |
| `recommendationTextEN` | `text`        | Recommendation text in english                  | "Please refill the toner"   |


## Relations

![recommendationTable](/images/architecture/datamodel/database/recommendationtable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS recommendationTable
(
    uid                     TEXT                                PRIMARY KEY,
    timestamp               TIMESTAMPTZ                         NOT NULL,
    recommendationType      INTEGER                             NOT NULL,
    enabled                 BOOLEAN                             NOT NULL,
    recommendationValues    TEXT,
    diagnoseTextDE          TEXT,
    diagnoseTextEN          TEXT,
    recommendationTextDE    TEXT,
    recommendationTextEN    TEXT
);
```
