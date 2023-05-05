---
title: Setup Local Environment
description: |
    This document describes how to set up your local environment for contributing
    to United Manufacturing Hub documentation website.
weight: 5
---

The following instructions describe how to set up your local environment for
contributing to United Manufacturing Hub documentation website.

You can use any text editor to contribute to the documentation. However, we
recommend using [Visual Studio Code](https://code.visualstudio.com/) with the
[Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
extension. Additional extensions that can be useful are:

- [GoHugo](https://marketplace.visualstudio.com/items?itemName=phoenisx.gohugo)
- [Hugo Language and Syntax Support](https://marketplace.visualstudio.com/items?itemName=budparr.language-hugo-vscode)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)

## Requirements

The following tools are required to contribute to the documentation website. Use
your preferred package manager to install them (for Windows users, we recommend
using [Chocolatey](https://chocolatey.org/)).

- [Git](https://git-scm.com/)
- [Hugo (Extended version)](https://gohugo.io/)
- [Node.js LTS](https://nodejs.org/en/)

Other tools that are not required, but are recommended:

- [GNU make](https://www.gnu.org/software/make/) to easily run scripts
- [GNU awk](https://www.gnu.org/software/gawk/) is used by some `make` scripts

## Fork the documentation repository

If you are not a member of the United Manufacturing Hub organization, you will
need to fork the repository to your own GitHub account. This is done by clicking
the **Fork** button in the top-right corner of the
[`united-manufacturing-hub/umh.docs.umh.app`](https://github.com/united-manufacturing-hub/umh.docs.umh.app)
repository page.

## Clone the repository

Clone the repository to your local machine:

```sh
git clone https://github.com/<user>/umh.docs.umh.app.git
# or: git clone git@github.com:<user>/umh.docs.umh.app.git
```

Where `<user>` is your GitHub username, or `united-manufacturing-hub` if
you are a member of the United Manufacturing Hub organization.

If you are not a member of the United Manufacturing Hub organization, you will
need to add the upstream repository as a remote:

```sh
git remote add origin https://github.com/united-manufacturing-hub/umh.docs.umh.app.git
# or: git remote add upstream git@github.com:united-manufacturing-hub/umh.docs.umh.app.git

# Never push to upstream master
git remote set-url --push origin no_push
```

## Install dependencies

Install the required dependencies:

```sh
make module-init
```

## Run the development server

To build and serve the website locally, run the following command:

```sh
make serve
```

This will start the local Hugo server on port 1313. Open up your browser to
`http://localhost:1313` to view the website. As you make changes to the source
files, Hugo updates the website and forces a browser refresh.

You can stop the server by pressing `Ctrl+C` in the terminal.

## Other useful commands

Most of the commands are available as `make` targets. To see the list of all
available commands, run:

```sh
make help
```

## {{% heading "whatsnext" %}}

- Learn how to [write a new topic](/docs/development/contribute/documentation/write-new-topic/).
- Get an overview of the [documentation style](/docs/development/contribute/documentation/style/).
