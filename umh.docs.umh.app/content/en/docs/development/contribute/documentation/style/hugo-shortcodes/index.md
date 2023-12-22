---
title: Custom Hugo Shortcodes
description: |
    This page explains the custom Hugo shortcodes used in United Manufacturing
    Hub documentation.
content_type: concept
weight: 60
---

<!-- overview -->
One of the powerful features of Hugo is the ability to create custom shortcodes.
Shortcodes are simple snippets of code that you can use to add complex content
to your documentation.

Read more about shortcodes in the [Hugo documentation](https://gohugo.io/content-management/shortcodes).

<!-- body -->

## Code example

You can use the `codenew` shortcode to display code examples in your documentation.
This is especially useful for code snippets that you want to reuse in multiple places.

After you add a new file with a code snippet in the `examples` directory, you can
reference it in your documentation using the `codenew` shortcode with the `file`
parameter set to the path to the file, relative to the `examples` directory.

A *Copy* button is automatically added to the code snippet. When the user clicks
the button, the code is copied to the clipboard.

Here's an example:

```go-html-template
{{</* codenew file="helm/install-umh.sh" */>}}
```

The rendered shortcode looks like this:

{{< codenew file="helm/install-umh.sh" >}}

## Heading

You can use the `heading` shortcode to use localized strings as headings in your
documentation. The available headings are described in the [content types](/docs/development/contribute/documentation/style/page-content-types/)
page.

For example, to create a whatsnext heading, add the heading shortcode with the "whatsnext" string:

```none
## {{%/* heading "whatsnext" */%}}
```

## Include

You can use the `include` shortcode to include a file in your documentation.
This is especially useful for including markdown files that you want to reuse in
multiple places.

After you add a new file in the `includes` directory, you can reference it in your
documentation using the `include` shortcode with the first parameter set to the
path to the file, relative to the `includes` directory.

Here's an example:

```go-html-template
{{</* include "pod-logs.md" */>}}
```

## Mermaid

You can use the `mermaid` shortcode to display Mermaid diagrams in your documentation.
You can find more information in the [diagram guide](/docs/development/contribute/documentation/style/diagram-guide/).

Here's an example:

```go-html-template
{{</* mermaid */>}}
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
{{</* /mermaid */>}}
```

The rendered shortcode looks like this:

{{< mermaid >}}
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
{{< /mermaid >}}

## Notice

You can use the `notice` shortcode to display a notice in your documentation.
There are four types of notices: `note`, `warning`, `info`, and `tip`.

Here's an example:

```go-html-template
{{</* notice note */>}}
This is a note.
{{</* /notice */>}}
{{</* notice warning */>}}
This is a warning.
{{</* /notice */>}}
{{</* notice info */>}}
This is an info.
{{</* /notice */>}}
{{</* notice tip */>}}
This is a tip.
{{</* /notice */>}}
```

The rendered shortcode looks like this:

{{< notice note >}}
This is a note.
{{< /notice >}}
{{< notice warning >}}
This is a warning.
{{< /notice >}}
{{< notice info >}}
This is an info.
{{< /notice >}}
{{< notice tip >}}
This is a tip.
{{< /notice >}}

## Resource

You can use the `resource` shortcode to display a resource in your documentation.
The `resource` shortcode takes these parameters:

- `name`: The name of the resource.
- `type`: The type of the resource.

This is useful for displaying resources which name might change over time, like
a pod name.

Here's an example:

```go-html-template
{{</* resource type="pod" name="database" */>}}
```

The rendered shortcode looks like this: {{< resource type="pod" name="database" >}}

The resources are defined in the `i18n/en.toml` file. You can add a new resource
by adding a new entry like `[resource_<type>_<name>]`

## Table captions

You can make tables more accessible to screen readers by adding a table caption. To add a
[caption](https://www.w3schools.com/tags/tag_caption.asp) to a table,
enclose the table with a `table` shortcode and specify the caption with the `caption` parameter.

{{< notice note >}}
Table captions are visible to screen readers but invisible when viewed in standard HTML.
{{< /notice >}}

Here's an example:

```go-html-template
{{</* table caption="Configuration parameters" >}}
| Parameter  | Description                  | Default |
| :--------- | :--------------------------- | :------ |
| `timeout`  | The timeout for requests     | `30s`   |
| `logLevel` | The log level for log output | `INFO`  |
{{< /table */>}}
```

The rendered table looks like this:

{{< table caption="Configuration parameters" >}}
| Parameter  | Description                  | Default |
| :--------- | :--------------------------- | :------ |
| `timeout`  | The timeout for requests     | `30s`   |
| `logLevel` | The log level for log output | `INFO`  |
{{< /table >}}

If you inspect the HTML for the table, you should see this element immediately
after the opening `<table>` element:

```html
<caption style="display: none;">Configuration parameters</caption>
```

## Tabs

In a markdown page (`.md` file) on this site, you can add a tab set to display
multiple flavors of a given solution.

The `tabs` shortcode takes these parameters:

- `name`: The name as shown on the tab.
- `codelang`: If you provide inner content to the `tab` shortcode, you can tell Hugo
  what code language to use for highlighting.
- `include`: The file to include in the tab. If the tab lives in a Hugo
  [leaf bundle](https://gohugo.io/content-management/page-bundles/#leaf-bundles),
  the file -- which can be any MIME type supported by Hugo -- is looked up in the bundle itself.
  If not, the content page that needs to be included is looked up relative to the current page.
  Note that with the `include`, you do not have any shortcode inner content and must use the
  self-closing syntax. For example,
  `{{</* tab name="Content File #1" include="example1" /*/>}}`. The language needs to be specified
  under `codelang` or the language is taken based on the file name.
  Non-content files are code-highlighted by default.
- If your inner content is markdown, you must use the `%`-delimiter to surround the tab.
  For example, `{{%/* tab name="Tab 1" %}}This is **markdown**{{% /tab */%}}`
- You can combine the variations mentioned above inside a tab set.

Below is a demo of the tabs shortcode.

{{< notice note >}}
The tab **name** in a `tabs` definition must be unique within a content page.
{{< /notice >}}

### Tabs demo: Code highlighting

```go-text-template
{{</* tabs name="tab_with_code" >}}
{{< tab name="Tab 1" codelang="bash" >}}
echo "This is tab 1."
{{< /tab >}}
{{< tab name="Tab 2" codelang="go" >}}
println "This is tab 2."
{{< /tab >}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_code" >}}
{{< tab name="Tab 1" codelang="bash" >}}
echo "This is tab 1."
{{< /tab >}}
{{< tab name="Tab 2" codelang="go" >}}
println "This is tab 2."
{{< /tab >}}
{{< /tabs >}}

### Tabs demo: Inline Markdown and HTML

```go-html-template
{{</* tabs name="tab_with_md" >}}
{{% tab name="Markdown" %}}
This is **some markdown.**
{{< note >}}
It can even contain shortcodes.
{{< /note >}}
{{% /tab %}}
{{< tab name="HTML" >}}
<div>
  <h3>Plain HTML</h3>
  <p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tab >}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_md" >}}
{{% tab name="Markdown" %}}
This is **some markdown.**

{{< notice note >}}
It can even contain shortcodes.
{{< /notice >}}

{{% /tab %}}
{{< tab name="HTML" >}}
<div>
  <h3>Plain HTML</h3>
  <p>This is some <i>plain</i> HTML.</p>
</div>
{{< /tab >}}
{{< /tabs >}}

### Tabs demo: File include

```go-text-template
{{</* tabs name="tab_with_file_include" >}}
{{< tab name="Content File #1" include="example1" />}}
{{< tab name="Content File #2" include="example2" />}}
{{< tab name="JSON File" include="podtemplate" />}}
{{< /tabs */>}}
```

Renders to:

{{< tabs name="tab_with_file_include" >}}
{{< tab name="Content File #1" include="example1" />}}
{{< tab name="Content File #2" include="example2" />}}
{{< tab name="JSON File" include="podtemplate.json" />}}
{{< /tabs >}}

## Version strings

To generate a version string for inclusion in the documentation, you can choose from
several version shortcodes. Each version shortcode displays a version string derived from
the value of a version parameter found in the site configuration file, `config.toml`.
The two most commonly used version parameters are `latest` and `version`.

### `{{</* param "version" */>}}`

The `{{</* param "version" */>}}` shortcode generates the value of the current
version of the Kubernetes documentation from the `version` site parameter. The
`param` shortcode accepts the name of one site parameter, in this case:
`version`.

{{< notice note >}}
In previously released documentation, `latest` and `version` parameter values
are not equivalent.  After a new version is released, `latest` is incremented
and the value of `version` for the documentation set remains unchanged. For
example, a previously released version of the documentation displays `version`
as `v1.19` and `latest` as `v1.20`.
{{< /notice >}}

Renders to:

{{< param "version" >}}

### `{{</* latest-version */>}}`

The `{{</* latest-version */>}}` shortcode returns the value of the `latest` site parameter.
The `latest` site parameter is updated when a new version of the documentation is released.
This parameter does not always match the value of `version` in a documentation set.

Renders to:

{{< latest-version >}}

### `{{</* latest-semver */>}}`

The `{{</* latest-semver */>}}` shortcode generates the value of `latest`
without the "v" prefix.

Renders to:

{{< latest-semver >}}

### `{{</* version-check */>}}`

The `{{</* version-check */>}}` shortcode checks if the `min-kubernetes-server-version`
page parameter is present and then uses this value to compare to `version`.

Renders to:

{{< version-check >}}

## {{% heading "whatsnext" %}}

- Read the [Hugo documentation](https://gohugo.io/documentation/).
- Learn how to [write a new topic](/docs/development/contribute/documentation/write-new-topic/).
- Read the [Content guide](/docs/development/contribute/documentation/style/content-guide/).
