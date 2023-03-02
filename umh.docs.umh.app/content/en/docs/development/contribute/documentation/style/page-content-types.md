---
title: Page content types
content_type: concept
description: |
  This page describes the types of content you can add to the United Manufacturing Hub documentation.
weight: 50
---

<!-- overview -->

The United Manufacturing Hub documentation follows several types of page content:

- Concept
- Task
- Tutorial

<!-- body -->

## Content sections

Each page content type contains a number of sections defined by
Markdown comments and HTML headings. You can add content headings to
your page with the `heading` shortcode. The comments and headings help
maintain the structure of the page content types.

Examples of Markdown comments defining page content sections:

```markdown
<!-- overview -->
```

```markdown
<!-- body -->
```

To create common headings in your content pages, use the `heading` shortcode with
a heading string.

Examples of heading strings:

- whatsnext
- prerequisites
- objectives
- cleanup
- synopsis
- seealso
- options

For example, to create a `whatsnext` heading, add the heading shortcode with the "whatsnext" string:

```none
## {{%/* heading "whatsnext" */%}}
```

You can declare a `prerequisites` heading as follows:

```none
## {{%/* heading "prerequisites" */%}}
```

The `heading` shortcode expects one string parameter.
The heading string parameter matches the prefix of a variable in the `i18n/<lang>.toml` files.
For example:

`i18n/en.toml`:

```toml
[heading_whatsnext]
other = "What's next"
```

## Content types

Each content type informally defines its expected page structure.
Create page content with the suggested page sections.

### Concept

A concept page explains some aspect of United Manufacturing Hub. For example, a
concept page might describe a specific component of the United Manufacturing Hub
and explain the role it plays as an application while it is deployed, scaled,
and updated. Typically, concept pages don't include sequences of steps, but
instead provide links to tasks or tutorials.

To write a new concept page, create a Markdown file with the following characteristics:

Concept pages are divided into three sections:

| Page section  |
|---------------|
| overview      |
| body          |
| whatsnext     |

The `overview` and `body` sections appear as comments in the concept page.
You can add the `whatsnext` section to your page with the `heading` shortcode.

Fill each section with content. Follow these guidelines:

- Organize content with H2 and H3 headings.
- For `overview`, set the topic's context with a single paragraph.
- For `body`, explain the concept.
- For `whatsnext`, provide a bulleted list of topics (5 maximum) to learn more about the concept.

### Task

A task page shows how to do a single thing. The idea is to give readers a sequence
of steps that they can actually do as they read the page. A task page can be short
or long, provided it stays focused on one area. In a task page, it is OK to blend
brief explanations with the steps to be performed, but if you need to provide a
lengthy explanation, you should do that in a concept topic. Related task and
concept topics should link to each other.

To write a new task page, create a Markdown file with the following characteristics:

| Page section  |
|---------------|
| overview      |
| prerequisites |
| steps         |
| discussion    |
| whatsnext     |

The `overview`, `steps`, and `discussion` sections appear as comments in the task page.
You can add the `prerequisites` and `whatsnext` sections to your page
with the `heading` shortcode.

Within each section, write your content. Use the following guidelines:

- Use a minimum of H2 headings (with two leading `#` characters). The sections
  themselves are titled automatically by the template.
- For `overview`, use a paragraph to set context for the entire topic.
- For `prerequisites`, use bullet lists when possible. Start adding additional
  prerequisites below the `include`. The default prerequisites include a running Kubernetes cluster.
- For `steps`, use numbered lists.
- For discussion, use normal content to expand upon the information covered
  in `steps`.
- For `whatsnext`, give a bullet list of up to 5 topics the reader might be
  interested in reading next.

For an example of a short task page,
see [Expose Grafana to the internet](/docs/production-guides/administration/expose-grafana-to-internet/).
For an example of a longer task page, see [Access the database](/docs/production-guides/administration/access-database/)

### Tutorial

A tutorial page shows how to accomplish a goal that ties together several United
Manufacturing Hub features. A tutorial might provide several sequences of steps
that readers can actually do as they read the page. Or it might provide explanations
of related pieces of code. For example, a tutorial could provide a walkthrough
of a code sample. A tutorial can include brief explanations of the United
Manufacturing Hub features that are being tied together, but should link to
related concept topics for deep explanations of individual features.

To write a new tutorial page, create a Markdown file with the following characteristics:

| Page section  |
|---------------|
| overview      |
| prerequisites |
| objectives    |
| lessoncontent |
| cleanup       |
| whatsnext     |

The `overview`, `objectives`, and `lessoncontent` sections appear as comments in the tutorial page.
You can add the `prerequisites`, `cleanup`, and `whatsnext` sections to your page
with the `heading` shortcode.

Within each section, write your content. Use the following guidelines:

- Use a minimum of H2 headings (with two leading `#` characters). The sections
  themselves are titled automatically by the template.
- For `overview`, use a paragraph to set context for the entire topic.
- For `prerequisites`, use bullet lists when possible. Add additional
  prerequisites below the ones included by default.
- For `objectives`, use bullet lists.
- For `lessoncontent`, use a mix of numbered lists and narrative content as
  appropriate.
- For `cleanup`, use numbered lists to describe the steps to clean up the
  state of the cluster after finishing the task.
- For `whatsnext`, give a bullet list of up to 5 topics the reader might be
  interested in reading next.

## {{% heading "whatsnext" %}}

- Learn about the [Style guide](/docs/development/contribute/documentation/style/style-guide/)
- Learn about the [Content guide](/docs/development/contribute/documentation/style/content-guide/)
- Learn about [content organization](/docs/development/contribute/documentation/style/content-organization/)
