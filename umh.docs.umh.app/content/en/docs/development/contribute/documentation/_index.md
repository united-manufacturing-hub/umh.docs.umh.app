---
title: Documentation
content_type: concept
description: |
  Learn how to contribute to the United Manufacturing Hub documentation.
weight: 20
---

<!-- overview -->

## Welcome

Welcome to the United Manufacturing Hub documentation! We're excited that you want
to contribute to the project.

The first place to start is the [Getting Started With Contributing](/docs/development/contribute/getting-started/)
page. It provides a high-level overview of the contribution process.

Once you're familiar with the contribution process, you can prepare for your
first contribution by reading the documents in this section.

United Manufacturing Hub documentation contributors:

- Improve existing content
- Create new content
- Translate the documentation
- Manage and publish the documentation parts of the United Manufacturing Hub release cycle

## Your first contribution

You can prepare for your first contribution by reviewing several steps beforehand.
The next figure outlines the steps nad the details to follow.

{{< mermaid >}}
flowchart LR
    subgraph second[First Contribution]
    direction TB
    S[ ] -.-
    G[Review PRs from other<br>UMH members] -->
    A[Check umh.docs.umh.app<br>issues list for good<br>first PRs] --> B[Open a PR!!]
    end
    subgraph first[Suggested Prep]
    direction TB
       T[ ] -.-
       D[Read contribution overview] -->E[Read UMH content<br>and style guides]
       E --> F[Learn about Hugo page<br>content types<br>and shortcodes]
    end
    first ----> second
classDef grey fill:#dddddd,stroke:#ffffff,stroke-width:px,color:#000000, font-size:15px;
classDef white fill:#ffffff,stroke:#000,stroke-width:px,color:#000,font-weight:bold
classDef spacewhite fill:#ffffff,stroke:#fff,stroke-width:0px,color:#000
class A,B,D,E,F,G grey
class S,T spacewhite
class first,second white
{{</ mermaid >}}

- Read the [Contribution overview](/docs/development/contribute/new-content/) to
  learn about the different ways you can contribute.
- Check [`united-manufacturing-hub/umh.docs.umh.app` issues list](https://github.com/united-manufacturing-hub/umh.docs.umh.app/issues)
  for issues that make good entry points.
- [Open a pull request using GitHub](/docs/development/contribute/new-content/pull-request/)
  to existing documentation and learn more about filing issues in GitHub.
- Read the UMH [content](/docs/development/contribute/documentation/style/content-guide/) and
  [style guides](/docs/development/contribute/documentation/style/style-guide/) so you can leave informed comments.
- Learn about [page content types](/docs/development/contribute/documentation/style/page-content-types/)
  and [Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/).
