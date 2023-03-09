+++
title = "configurationTable"
description = "configurationTable stores the configuration of the UMH system."
+++

## Usage

This table stores the configuration of the system

## Structure

| key                                            | data type   | description                                              | example                                                                                    |
|------------------------------------------------|-------------|----------------------------------------------------------|--------------------------------------------------------------------------------------------|
| `customer`                                     | `text`      | Customer name                                            | factoryinsight                                                                             |
| `MicrostopDurationInSeconds`                   | `integer`   | Stop counts as microstop if smaller than this value      | 120                                                                                        |
| `IgnoreMicrostopUnderThisDurationInSeconds`    | `integer`   | Ignore stops under this value                            | -1                                                                                         |
| `MinimumRunningTimeInSeconds`                  | `integer`   | Minimum runtime of the asset before tracking micro-stops | 0                                                                                          |
| `ThresholdForNoShiftsConsideredBreakInSeconds` | `integer`   | If no shift is shorter than this value, it is a break    | 2100                                                                                       |
| `LowSpeedThresholdInPcsPerHour`                | `integer`   | Threshold once machine should go into low speed state    | -1                                                                                         |
| `AutomaticallyIdentifyChangeovers`             | `boolean`   | Automatically identify changeovers in production         | true                                                                                       |
| `LanguageCode`                                 | `integer`   | 0 is german, 1 is english                                | 1                                                                                          |
| `AvailabilityLossStates`                       | `integer[]` | States to count as availability loss                     | {40000, 180000, 190000, 200000, 210000, 220000}                                            |
| `PerformanceLossStates`                        | `integer[]` | States to count as performance loss                      | {20000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000} |


## Relations

![configurationTable](/images/architecture/datamodel/database/configurationtable.png)

## DDL
```sql
CREATE TABLE IF NOT EXISTS configurationTable
(
    customer TEXT PRIMARY KEY,
    MicrostopDurationInSeconds INTEGER DEFAULT 60*2,
    IgnoreMicrostopUnderThisDurationInSeconds INTEGER DEFAULT -1, --do not apply
    MinimumRunningTimeInSeconds INTEGER DEFAULT 0, --do not apply
    ThresholdForNoShiftsConsideredBreakInSeconds INTEGER DEFAULT 60*35,
    LowSpeedThresholdInPcsPerHour INTEGER DEFAULT -1, --do not apply
    AutomaticallyIdentifyChangeovers BOOLEAN DEFAULT true,
    LanguageCode INTEGER DEFAULT 1, -- english
    AvailabilityLossStates INTEGER[] DEFAULT '{40000, 180000, 190000, 200000, 210000, 220000}',
    PerformanceLossStates INTEGER[] DEFAULT '{20000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000}'
);
```
