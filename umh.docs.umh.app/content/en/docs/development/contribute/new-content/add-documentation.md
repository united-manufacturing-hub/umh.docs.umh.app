---
title: Adding Documentation
content_type: concept
description: |
  Learn how to add documentation to the United Manufacturing Hub.
weight: 3
---

<!-- overview -->

This section contains information you should know before contributing new
content.

{{< mermaid >}}
flowchart LR
    subgraph second[Before you begin]
    direction TB
    S[ ] -.-
    A[Sign the CNCF CLA] --> B[Choose Git branch]
    B --> C[One language per PR]
    C --> F[Check out<br>contributor tools]
    end
    subgraph first[Contributing Basics]
    direction TB
       T[ ] -.-
       D[Write docs in markdown<br>and build site with Hugo] --- E[source in GitHub]
       E --- G['/content/../docs' folder contains docs<br>for multiple languages]
       G --- H[Review Hugo page content<br>types and shortcodes]
    end
    first ----> second
classDef grey fill:#dddddd,stroke:#ffffff,stroke-width:px,color:#000000, font-size:15px;
classDef white fill:#ffffff,stroke:#000,stroke-width:px,color:#000,font-weight:bold
classDef spacewhite fill:#ffffff,stroke:#fff,stroke-width:0px,color:#000
class A,B,C,D,E,F,G,H grey
class S,T spacewhite
class first,second white
{{</ mermaid >}}

The figure above depicts the information you should know
prior to submitting new content. The information details follow.

<!-- body -->

## Contributing basics

- Write United Manufacturing Hub documentation in Markdown and build the UMH docs
  site using [Hugo](https://gohugo.io/).
- The source is in [GitHub](https://github.com/united-manufacturing-hub/umh.docs.umh.app).
- [Page content types](/docs/development/contribute/documentation/style/page-content-types/)
  describe the presentation of documentation content in Hugo.
- You can use [Docsy shortcodes](https://www.docsy.dev/docs/adding-content/shortcodes/)
  or [custom Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/)
  to contribute to UMH documentation.
- In addition to the standard Hugo shortcodes, we use a number of
  [custom Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/) in our
  documentation to control the presentation of content.
- Documentation source is available in multiple languages in `/content/`. Each
  language has its own folder with a two-letter code determined by the
  [ISO 639-1 standard](https://www.loc.gov/standards/iso639-2/php/code_list.php)
  . For example, English documentation source is stored in `/content/en/docs/`.
- For more information about contributing to documentation in multiple languages
  or starting a new translation,
  see [localization](/docs/development/contribute/documentation/localization).

## Before you begin {#before-you-begin}

### Sign the CNCF CLA {#sign-the-cla}

All Kubernetes contributors **must** read
the [Getting started guide](/docs/development/contribute/getting-started/)
and [sign the Contributor License Agreement (CLA)](https://github.com/united-manufacturing-hub/united-manufacturing-hub/blob/main/CONTRIBUTOR_LICENSE_AGREEMENT_INDIVIDUAL.md).

Pull requests from contributors who haven't signed the CLA fail the automated
tests. The name and email you provide must match those found in
your `git config`, and your git name and email must match those used for the
CNCF CLA.

### Choose which Git branch to use

When opening a pull request, you need to know in advance which branch to base
your work on.

Scenario | Branch
:---------|:------------
Existing or new English language content for the current release | `main`
Content for a feature change release | The branch which corresponds to the major and minor version the feature change is in, using the pattern dev-\<version>. For example, if a feature changes in the v0.9.11 release, then add documentation changes to the dev-0.9.11 branch.
Content in other languages (localizations) | Use the localization's convention. See the [Localization branching strategy](/docs/development/contribute/documentation/localization/#branching-strategy) for more information.

### Languages per PR

Limit pull requests to one language per PR. If you need to make an identical
change to the same code sample in multiple languages, open a separate PR for
each language.
