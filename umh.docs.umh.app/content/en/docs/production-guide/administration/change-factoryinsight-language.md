---
title: "Change the Language in Factoryinsight"
content_type: task
description: |
  This page describes how to change the language in Factoryinsight, in order to
  display the returned text in a different language.
weight: 70
---

<!-- overview -->

You can change the language in Factoryinsight if you want to localize the returned
text, like stop codes, to a different language.

## {{% heading "prerequisites" %}}

{{< include "task-aftinst-prereqs.md" >}}

<!-- steps -->

## Access the database shell

{{< include "open-database-shell.md" >}}

## Change the language

Execute the following command to change the language:

```sql
INSERT INTO configurationtable (customer, languagecode) VALUES ('factoryinsight', <code>) ON CONFLICT(customer) DO UPDATE SET languagecode=<code>;
```

 where `<code>` is the language code. For example, to change the language to
 German, use `0`.

<!-- discussion -->
## Supported languages

Factoryinsight supports the following languages:

{{< table caption="Supported languages" >}}
| Language | Code |
| :------- | :--- |
| German   | 0    |
| English  | 1    |
| Turkish  | 2    |
{{< /table >}}

<!-- Optional section; add links to information related to this topic. -->
## {{% heading "whatsnext" %}}

- See [Access the Database](/docs/production-guide/administration/access-database)
