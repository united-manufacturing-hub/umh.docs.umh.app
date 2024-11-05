---
title: "Historian Data Contract"
menuTitle: "Historian Data Contract"
description: "This page is a deepdive of the Historian Data Contract of the UMH including the configuration and rules associated to it."
weight: 1000
---

## Historian

This section will focus on the specific details and configurations of the Historian Data Contract.
If you are not yet familiar with Data Contracts, you should first read the [Data Contracts / API](https://umh.docs.umh.app/docs/datacontracts/) page.

The purpose of the Historian Data Contract is to govern the data flow to the data base.
It enforces rules for the structure of the message payloads and topics, and provides the necessary infrastructure to bridge data in the Unifies Namespace and to write it into the data base.

This makes sure, that data is only stored in a format accepted by the data base, and makes integrating services like Grafana easier as the data structure is already known.

## Topics in the Historian

The prefix and Location of the topic in the Historian Data Contract follows the same rules as alreads described on the general [Data Contracts](https://umh.docs.umh.app/docs/datacontracts/#topic-structure) page.

### Schema: _historian

The only schema in the Historian Data Contract is `_historian`.
Without it, your messages will not be processed.

### Tag groups

In addition to the Location, you can also use tag groups.
A tag group is just an additional part after the schema:

`umh.v1.location._historian.tag-group.tagname`

You can add as many tag groups as you wish:

`umh.v1.location._historian.tag-group1.tag-group2.tagname`

In the tag browser a tag group will look like any field of the Location, exept it is located after the schema.

#### Example

Tag groups can be usefull to further add context to your tags or to keep an overview of them in the tag browser.
For example you can use them to categorize the sensors of a CNC mill.

- One group for the positions of the x,y,z axis:

`umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.axis.tagname`

- A second group for the machine state:

`umh.v1.umh.cologne.ehrenfeld.development.cnc-mill-1234._historian.machine-state.tagname`

## Payload structure

The Historian Data Contracts requires your messages to be a JSON file with a specific structure and inclue a timestamp.
For a simple message wiht one tag it looks like this:

```json
{
  "timestamp_ms": (timestamp_unix_nano() / 1000000).floor(),
  "tagname": 42
}
```

The timestamp must be called `"timestamp_ms"` and contain the timestamp in milliseconds.
The value can be either a number `"key": 123` or a string `"key": "string"`.
The `"tagname"` is the name of the tag and will be used in the tag browser or for Grafana.

It is also possible to include several tags in a single payload.

```json
{
  "timestamp_ms": (timestamp_unix_nano() / 1000000).floor(),
  "tagname1": 123,
  "tagname2": "string",
  "tagname3": "string"
}
```

If you want to use taggroups, you can also do this in the payload.

```json
{
  "timestamp_ms": (timestamp_unix_nano() / 1000000).floor(),
  "taggroup": 
  {
    "tagname1": 123,
    "tagname2": "string"
  }
}
```

Both tags will appear in the `[...]._historian.taggroup` topic.

You can check out the full json schema below:

## Data Flow Components

## Data Bridges

## Data Base

## Tables

### SQL

## Schema validation ??
