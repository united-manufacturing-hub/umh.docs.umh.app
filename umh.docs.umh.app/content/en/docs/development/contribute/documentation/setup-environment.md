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
- [Git LFS](https://git-lfs.com/)
- [Hugo (Extended version)](https://gohugo.io/) v0.111.3
- [Node.js LTS](https://nodejs.org/en/) v18.16.0

Other tools that are not required, but are recommended:

- [GNU make](https://www.gnu.org/software/make/) to easily run scripts

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
git remote add upstream https://github.com/united-manufacturing-hub/umh.docs.umh.app.git

# Never push to upstream master
git remote set-url --push upstream no_push
```

## Setup the environment

If you are running on a Windows system, manually install the above required tools.

If you are running on a Linux system, or can run a bash shell, you can use the
following commands to install the required tools:

```sh
cd <path_to_your_repo>
make install
```

## Run the development server

Now it's time to run the server locally.

Navigate to the `umh.docs.umh.app` directory inside the repository you cloned
earlier.

```sh
cd <path_to_your_repo>/umh.docs.umh.app
```

If you have not installed GNU make, run the following command:

```sh
hugo server --buildDrafts
```

Otherwise, run the following command:

```sh
make serve
```

Either method will start the local Hugo server on port 1313. Open up your browser to
`http://localhost:1313` to view the website. As you make changes to the source
files, Hugo updates the website and forces a browser refresh.

You can stop the server by pressing `Ctrl+C` in the terminal.

## {{% heading "whatsnext" %}}

- Learn how to [write a new topic](/docs/development/contribute/documentation/write-new-topic/).
- Get an overview of the [documentation style](/docs/development/contribute/documentation/style/).
