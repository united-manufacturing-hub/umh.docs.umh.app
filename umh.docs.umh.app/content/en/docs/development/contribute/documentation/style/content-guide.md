---
title: Content Guide
description: |
    This page contains guidelines for the United Manufacturing Hub documentation.
weight: 10
---

In this guide, you'll find guidelines regarding the content for the United
Manufacturing Hub documentation, that is what content is allowed and how to
organize it.

For information about the styling, follow the
[style guide](/docs/development/contribute/documentation/style/style-guide), and
for a quick guide to writing a new page, follow the
[quick start guide](/docs/development/contribute/documentation/style/write-new-topic).

## What's allowed

United Manufacturing Hub docs allow content for third-party projects only when:

- Content documents software in the United Manufacturing Hub project
- Content documents software that's out of project but necessary for United
  Manufacturing Hub to function

## Sections

The United Manufacturing Hub documentation is organized into sections. Each
section contains a specific set of pages that are relevant to a user goal.

### Get started

The [Get started](/docs/getstarted/) section contains information to help new
users get started with the United Manufacturing Hub. It's the first section a
reader sees when visiting the website, and it guides users through the
installation process.

### Features

The [Features](/docs/features/) section contains information about the
capabilities of the United Manufacturing Hub. It's a high-level overview of the
project's features, and it's intended for users who want to learn more about them
without diving into the technical details.

### Architecture

The [Architecture](/docs/architecture/) section contains technical information
about the United Manufacturing Hub. It's intended for users who want to learn
more about the project's architecture and design decisions. Here there are
information about the different components of the United Manufacturing Hub and
how they interact with each other.

### Production Guide

The [Production Guide](/docs/production-guide/) section contains a series of
guides that help users to set up and operate the United Manufacturing Hub.

### What's New

The [What's New](/docs/whatsnew/) section contains high-level overview of all
the releases of the United Manufacturing Hub. Usually, only the last 3 to 4
releases are displayed in the sidebar, but all the releases are available in the
section page.

### Development

The [Development](/docs/development/) section contains information about
contributing to the United Manufacturing Hub project. It's intended for users who
want to contribute to the project, either by writing code or documentation.

## Page Organization

This site uses Hugo. In Hugo,
[content organization](https://gohugo.io/content-management/organization/) is a
core concept.

### Page Lists

#### Page Order

The documentation side menu, the documentation page browser etc. are listed
using Hugo's default sort order, which sorts by weight (from 1), date (newest
first), and finally by the link title.

Given that, if you want to move a page or a section up, set a weight in the
page's front matter:

```yaml
title: My Page
weight: 10
```

{{% notice note %}}
For page weights, it can be smart not to use 1, 2, 3 ..., but some other interval,
say 10, 20, 30... This allows you to insert pages where you want later.
Additionally, each weight within the same directory (section) should not be
overlapped with the other weights. This makes sure that content is always organized
correctly, especially in localized content.
{{% /notice %}}

{{% notice note %}}
In some sections, like the What's New section, it's easier to manage the order
using a negative weight. This is because the What's New section is organized by
release version, and the release version is a string, so it's easier to use a
negative weight to sort the releases in the correct order.
{{% /notice %}}

#### Side Menu

The documentation side-bar menu is built from the _current section tree_ starting
below `docs/`.

It will show all sections and their pages.

If you don't want to list a section or page, set the `toc_hide` flag to `true`
in front matter:

```yaml
toc_hide: true
```

When you navigate to a section that has content, the specific section or page
(e.g. `_index.md`) is shown. Else, the first page inside that section is shown.

### Page Bundles

In addition to standalone content pages (Markdown files), Hugo supports
[Page Bundles](https://gohugo.io/content-management/page-bundles/).

One example is [Custom Hugo Shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/).
It is considered a `leaf bundle`. Everything below the directory, including the
`index.md`, will be part of the bundle. This also includes page-relative links,
images that can be processed etc.:

```bash
en/docs/home/contribute/includes
├── example1.md
├── example2.md
├── index.md
└── podtemplate.json
```

Another widely used example is the `includes` bundle. It sets `headless: true`
in front matter, which means that it does not get its own URL. It is only used
in other pages.

```bash
en/includes
├── default-storage-class-prereqs.md
├── index.md
├── partner-script.js
├── partner-style.css
├── task-tutorial-prereqs.md
├── user-guide-content-moved.md
└── user-guide-migration-notice.md
```

Some important notes to the files in the bundles:

- For translated bundles, any missing non-content files will be inherited from
  languages above. This avoids duplication.
- All the files in a bundle are what Hugo calls `Resources` and you can provide
  metadata per language, such as parameters and title, even if it does not supports
  front matter (YAML files etc.). See
  [Page Resources Metadata](https://gohugo.io/content-management/page-resources/#page-resources-metadata).
- The value you get from `.RelPermalink` of a `Resource` is page-relative. See
  [Permalinks](https://gohugo.io/content-management/urls/#permalinks).

## Page Content Types

Hugo uses [archetypes](https://gohugo.io/content-management/archetypes/) to
define page types. The archetypes are located in the `archetypes` directory.

Each archetype informally defines its expected page structure. There are two main
archetypes, described below, but it's possible to create new archetypes for
specific page types that are frequently used.

To create a new page using an archetype, run the following command:

```bash
hugo new -k <archetype> docs/<section>/<page-name>.md
```

### Content Types

#### Concept

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

#### Task

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
see [Expose Grafana to the internet](/docs/production-guide/administration/expose-grafana-to-internet/).
For an example of a longer task page, see [Access the database](/docs/production-guide/administration/access-database/)

### Content Sections

Each page content type contains a number of sections defined by
Markdown comments and HTML headings. You can add content headings to
your page with the `heading` shortcode. The comments and headings help
maintain the structure of the page content types.

Examples of Markdown comments defining page content sections:

```markdown
<!-- overview -->

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

## {{% heading "whatsnext" %}}

- Read the [Style guide](/docs/development/contribute/documentation/style/style-guide).
