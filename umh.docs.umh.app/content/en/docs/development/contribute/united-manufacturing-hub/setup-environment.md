---
title: Setup Local Environment
description: |
    This document describes how to set up your local environment for contributing
    to the United Manufacturing Hub.
weight: 5
---

The following instructions describe how to set up your local environment for
contributing to the United Manufacturing Hub.

You can use any text editor or IDE. However, we recommend using
[JetBrains GoLand](https://www.jetbrains.com/go/).

## Requirements

The following tools are required to contribute to the United Manufacturing Hub.
Use the links to install the correct version for your operating system. We
recommend using a package manager where possible (for Windows, we recommend
using [Chocolatey](https://chocolatey.org/)).

- [Git](https://git-scm.com/downloads)
- [Go](https://golang.org/doc/install) version 1.19 or later
- [Docker](https://docs.docker.com/get-docker/) version 20.10 or later
- [kubectl](https://kubernetes.io/docs/tasks/tools/) version 1.26 or later
- [Helm](https://helm.sh/docs/intro/install/) version 3.11 or later
- [k3d](https://k3d.io/#installation) version 5.0 or later
- [GNU C Compiler](https://gcc.gnu.org/install/) version 12 or later. The `gcc`
  binaries must be in your `PATH` environment variable, and the go variable
  `CGO_ENABLED` must be set to `1`. You can check this by running
  `go env CGO_ENABLED` in your terminal.

Other tools that are not required, but are recommended:

- [GNU make](https://www.gnu.org/software/make/) to easily run scripts
- [GNU awk](https://www.gnu.org/software/gawk/) is used by some `make` scripts
- [Python 3](https://www.python.org/downloads/) is used by some `make` scripts

## Fork the documentation repository

If you are not a member of the United Manufacturing Hub organization, you will
need to fork the repository to your own GitHub account. This is done by clicking
the **Fork** button in the top-right corner of the
[`united-manufacturing-hub/united-manufacturing-hub`](https://github.com/united-manufacturing-hub/united-manufacturing-hub)
repository page.

## Clone the repository

Clone the repository to your local machine:

```sh
git clone https://github.com/<user>/united-manufacturing-hub.git
# or: git clone git@github.com:<user>/united-manufacturing-hub.git
```

Where `<user>` is your GitHub username, or `united-manufacturing-hub` if
you are a member of the United Manufacturing Hub organization.

If you are not a member of the United Manufacturing Hub organization, you will
need to add the upstream repository as a remote:

```sh
git remote add origin https://github.com/united-manufacturing-hub/united-manufacturing-hub.git
# or: git remote add upstream git@github.com:united-manufacturing-hub/united-manufacturing-hub.git

# Never push to upstream master
git remote set-url --push origin no_push
```

## Install dependencies

Download the go dependencies:

```sh
make go-deps
```

## Build the container images

These are the `make` targets to manage containers:

```sh
# Build the container images
make docker-build

# Push the container images
make docker-push

# Build and push the container images
make docker
```

You can pass the following variables to change the behavior of the `make`
targets:

- `CTR_REPO`: The container repository to push the images to. Defaults to
  `ghcr.io/united-manufacturing-hub`.
- `CTR_TAG`: The tag to use for the container images. Defaults to `latest`.
- `CTR_IMG`: Space-separated list of container images. Defaults to all the images
  in the `deployment` directory.

## Run a cluster locally

To run a local cluster, run:

```sh
# Create a cluster that runs the latest version of the United Manufacturing Hub
make cluster-install

# Create a cluster that runs the local version of the United Manufacturing Hub
make cluster-install CHART=./deployment/helm/united-manufacturing-hub
```

You can pass the following variables to change the behavior of the `make`
targets:

- `CLUSTER_NAME`: The name of the cluster. Defaults to `umh`.
- `CHART`: The Helm chart to use. Defaults to `united-manufacturing-hub/united-manufacturing-hub`.
- `VERSION`: The version of the Helm chart to use. Default is empty, which
  means the latest version.
- `VALUES_FILE`: The Helm values file to use. Default is empty, which means
  the default values.

## Test

To run the unit tests, run:

```sh
make go-test-unit
```

To run e2e tests, run:

```sh
make helm-test-upgrade

# To run the upgrade test with data
make helm-test-upgrade-with-data
```

## Other useful commands

```sh
# Display the help for the Makefile
make help

# Pass the PRINT_HELP=y flag to make to print the help for each target
make cluster-install PRINT_HELP=y
```

## {{% heading "whatsnext" %}}

- Read about our [coding conventions](/docs/development/contribute/united-manufacturing-hub/coding-conventions/).
