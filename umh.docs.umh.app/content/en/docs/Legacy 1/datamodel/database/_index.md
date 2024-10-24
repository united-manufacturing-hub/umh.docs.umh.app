---
title: "Historian"
chapter: true
description: "Describes databases of all available _schema"
weight: 2000
---

# Custom PostgreSQL Functions

## get_asset_id_immutable

This function is an optimized version of `get_asset_id` that is defined as [immutable](https://www.postgresql.org/docs/current/xfunc-volatility.html).
It is the fastest of the three functions and should be used for all queries, except when you plan to *manually* modify values inside the `asset` table.

Example:
```sql
SELECT * FROM tag WHERE get_asset_id_immutable(
                                '<enterprise>', 
                                '<site>', 
                                '<area>', 
                                '<line>', 
                                '<workcell>',
                                '<origin_id>'
                        ) LIMIT 1;
```

## get_asset_id_stable

This function is an optimized version of `get_asset_id` that is defined as [stable](https://www.postgresql.org/docs/current/xfunc-volatility.html).
It is a good choice over `get_asset_id` for all queries.

Example:
```sql
SELECT * FROM tag WHERE get_asset_id_stable(
                                '<enterprise>', 
                                '<site>', 
                                '<area>', 
                                '<line>', 
                                '<workcell>',
                                '<origin_id>'
                        ) LIMIT 1;
```


## [Legacy] get_asset_id

This function returns the id of the given asset.
It takes a variable number of arguments, where only the first (enterprise) is mandatory.
This function is only kept for compatibility reasons and should not be used in new queries, see [get_asset_id_stable](#get_asset_id_stable) or [get_asset_id_immutable](#get_asset_id_immutable) instead.

Example:
```sql
SELECT * FROM tag WHERE get_asset_id(
                                '<enterprise>', 
                                '<site>', 
                                '<area>', 
                                '<line>', 
                                '<workcell>',
                                '<origin_id>'
                        ) LIMIT 1;
```



## get_asset_ids_stable

This function is an optimized version of `get_asset_ids` that is defined as [stable](https://www.postgresql.org/docs/current/xfunc-volatility.html).
It is a good choice over `get_asset_ids` for all queries.

Example:
```sql
SELECT * FROM tag WHERE get_asset_ids_stable(
                                '<enterprise>', 
                                '<site>', 
                                '<area>', 
                                '<line>', 
                                '<workcell>',
                                '<origin_id>'
                        ) LIMIT 1;
```

## get_asset_ids_immutable

There is no immutable version of `get_asset_ids`, as the returned values will probably change over time.


## [Legacy] get_asset_ids

This function returns the ids of the given assets.
It takes a variable number of arguments, where only the first (enterprise) is mandatory.
It is only kept for compatibility reasons and should not be used in new queries, see [get_asset_ids_stable](#get_asset_ids_stable) instead.

Example:
```sql
SELECT * FROM tag WHERE get_asset_ids(
                                '<enterprise>', 
                                '<site>', 
                                '<area>', 
                                '<line>', 
                                '<workcell>',
                                '<origin_id>'
                        ) LIMIT 1;
```