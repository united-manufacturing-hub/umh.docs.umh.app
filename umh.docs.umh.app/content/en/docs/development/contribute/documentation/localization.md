---
title: Localizing UMH documentation
description: |
  This page shows you how to localize the docs for a different language.
content_type: concept
weight: 50
---

<!-- overview -->

This page shows you how to
[localize](https://blog.mozilla.org/l10n/2011/12/14/i18n-vs-l10n-whats-the-diff/)
the docs for a different language.

<!-- body -->

## Contribute to an existing localization

You can help add or improve the content of an existing localization.

{{< notice note >}}
For extra details on how to contribute to a specific localization,
look for a localized version of this page.
{{< /notice >}}

### Find your two-letter language code

First, consult the [ISO 639-1
standard](https://www.loc.gov/standards/iso639-2/php/code_list.php) to find your
localization's two-letter language code. For example, the two-letter code for
German is `de`.

Some languages use a lowercase version of the country code as defined by the
ISO-3166 along with their language codes. For example, the Brazilian Portuguese
language code is `pt-br`.

### Fork and clone the repo

First, [create your own
fork](/docs/development/contribute/new-content/add-documentation/#fork-the-repo) of the
[united-manufacturing-hub/umh.docs.umh.app](https://github.com/united-manufacturing-hub/umh.docs.umh.app) repository.

Then, clone your fork and `cd` into it:

```shell
git clone https://github.com/<username>/umh.docs.umh.app
cd umh.docs.umh.app
```

The website content directory includes subdirectories for each language. The
localization you want to help out with is inside `content/<two-letter-code>`.

### Suggest changes

Create or update your chosen localized page based on the English original. See
[translating content](#translating-content) for more details.

If you notice a technical inaccuracy or other problem with the upstream
(English) documentation, you should fix the upstream documentation first and
then repeat the equivalent fix by updating the localization you're working on.

Limit changes in a pull requests to a single localization. Reviewing pull
requests that change content in multiple localizations is problematic.

Follow [Suggesting Content Improvements](/docs/development/contribute/documentation/suggesting-improvements/)
to propose changes to that localization. The process is similar to proposing
changes to the upstream (English) content.

## Start a new localization

If you want the United Manufacturing Hub documentation localized into a new language, here's
what you need to do.

All localization teams must be self-sufficient. The United Manufacturing Hub website is happy
to host your work, but it's up to you to translate it and keep existing
localized content current.

You'll need to know the two-letter language code for your language. Consult the
[ISO 639-1 standard](https://www.loc.gov/standards/iso639-2/php/code_list.php)
to find your localization's two-letter language code. For example, the
two-letter code for Korean is `ko`.

If the language you are starting a localization for is spoken in various places
with significant differences between the variants, it might make sense to
combine the lowercased ISO-3166 country code with the language two-letter code.
For example, Brazilian Portuguese is localized as `pt-br`.

When you start a new localization, you must localize all the
[minimum required content](#minimum-required-content) before
the United Manufacturing Hub project can publish your changes to the live
website.

### Modify the site configuration

The United Manufacturing Hub website uses Hugo as its web framework. The website's Hugo
configuration resides in the
[`config.toml`](https://github.com/united-manufacturing-hub/umh.docs.umh.app/blob/main/umh.docs.umh.app/config.toml)
file. You'll need to modify `config.toml` to support a new localization.

Add a configuration block for the new language to `config.toml` under the
existing `[languages]` block. The German block, for example, looks like:

```toml
[languages.de]
title = "United Manufacturing Hub"
description = "Dokumentation des United Manufacturing Hub"
languageName = "Deutsch (German)"
languageNameLatinScript = "Deutsch"
contentDir = "content/de"
weight = 8
```

The language selection bar lists the value for `languageName`. Assign "language
name in native script and language (English language name in Latin script)" to
`languageName`. For example, `languageName = "한국어 (Korean)"` or `languageName =
"Deutsch (German)"`.

`languageNameLatinScript` can be used to access the language name in Latin
script and use it in the theme. Assign "language name in latin script" to
`languageNameLatinScript`. For example, `languageNameLatinScript ="Korean"` or
`languageNameLatinScript = "Deutsch"`.

When assigning a `weight` parameter for your block, find the language block with
the highest weight and add 1 to that value.

For more information about Hugo's multilingual support, see
"[Multilingual Mode](https://gohugo.io/content-management/multilingual/)".

### Add a new localization directory

Add a language-specific subdirectory to the
[`content`](https://github.com/united-manufacturing-hub/umh.docs.umh.app/tree/main/umh.docs.umh.app/content/) folder in
the repository. For example, the two-letter code for German is `de`:

```shell
mkdir content/de
```

You also need to create a directory inside `i18n/` for
[localized strings](#site-strings-in-i18n); look at existing localizations
for an example.

For example, for German the strings live in `i18n/de.toml`.

### Open a pull request

Next, [open a pull request](/docs/development/contribute/new-content/add-documentation/#open-a-pr)
(PR) to add a localization to the `united-manufacturing-hub/umh.docs.umh.app` repository. The PR must
include all the [minimum required content](#minimum-required-content) before it
can be approved.

### Add a localized README file

To guide other localization contributors, add a new
[`README-**.md`](https://help.github.com/articles/about-readmes/) to the top
level of [united-manufacturing-hub/umh.docs.umh.app](https://github.com/united-manufacturing-hub/umh.docs.umh.app/), where
`**` is the two-letter language code. For example, a German README file would be
`README-de.md`.

Guide localization contributors in the localized `README-**.md` file.
Include the same information contained in `README.md` as well as:

- A point of contact for the localization project
- Any information specific to the localization

After you create the localized README, add a link to the file from the main
English `README.md`, and include contact information in English. You can provide
a GitHub ID, email address, [Discord channel](https://slack.com/), or another
method of contact.

### Launching your new localization

When a localization meets the requirements for workflow and minimum output, the
UMH team does the following:

- Enables language selection on the website.
- Publicizes the localization's availability through the [United Manufacturing Hub blog](TODO: learn blog).

## Translating content

Localizing _all_ the United Manufacturing Hub documentation is an enormous task. It's okay to
start small and expand over time.

### Minimum required content

At a minimum, all localizations must include:

Description | URLs
-----|-----
Administration | [All heading and subheading URLs](/docs/administration/)
Architecture | [All heading and subheading URLs](/docs/architecture/)
Getting started | [All heading and subheading URLs](/docs/getstarted/)
Produciton guide | [All heading and subheading URLs](/docs/production-guide)
Site strings | [All site strings](#site-strings-in-i18n) in a new localized TOML file

Translated documents must reside in their own `content/**/` subdirectory, but otherwise, follow the
same URL path as the English source. For example, to prepare the
[Getting started](/docs/getstarted/) tutorial for translation into German,
create a subfolder under the `content/de/` folder and copy the English source:

```shell
mkdir -p content/de/docs/getstarted
cp content/en/docs/getstarted/installation.md content/de/docs/getstarted/installation.md
```

Translation tools can speed up the translation process. For example, some
editors offer plugins to quickly translate text.

{{< notice tip >}}
Machine-generated translation is insufficient on its own. Localization requires
extensive human review to meet minimum standards of quality.
{{< /notice >}}

To ensure accuracy in grammar and meaning, members of your localization team
should carefully review all machine-generated translations before publishing.

### Source files

Localizations must be based on the English files from a specific release
targeted by the localization team. Each localization team can decide which
release to target, referred to as the _target version_ below.

To find source files for your target version:

1. Navigate to the United Manufacturing Hub website repository at
   [united-manufacturing-hub/umh.docs.umh.app](https://github.com/united-manufacturing-hub/umh.docs.umh.app/).

2. Select a branch for your target version from the following table:

Target version | Branch
-----|-----
Latest version | [`main`](https://github.com/united-manufacturing-hub/umh.docs.umh.app/tree/main)

The `main` branch holds content for the current release `{{< latest-version >}}`.

### Site strings in i18n

Localizations must include the contents of
[`i18n/en.toml`](https://github.com/united-manufacturing-hub/umh.docs.umh.app/main/i18n/en.toml)
in a new language-specific file. Using German as an example:
`i18n/de.toml`.

Add a new localization file to `i18n/`. For example, with German (`de`):

```bash
cp i18n/en.toml i18n/de.toml
```

Revise the comments at the top of the file to suit your localization, then
translate the value of each string. For example, this is the German-language
placeholder text for the search form:

```toml
[ui_search_placeholder]
other = "Suchen"
```

Localizing site strings lets you customize site-wide text and features: for
example, the legal copyright text in the footer on each page.
