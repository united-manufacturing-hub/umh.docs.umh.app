---
title: "Versioning Documentation"
content_type: concept
description: |
    This page describe how to version the documentation website.
weight: 60
---

<!-- overview -->
With the Beta release of the Management Console, we are introducing a new
versioning system for the documentation website. This system will ensure that
the documentation is versioned in sync with the Management Console's minor
versions. Each new minor release of the Management Console will correspond to a
new version of the documentation.

<!-- body -->

## Branches

Below is an outline of the branching strategy we will employ for versioning the
documentation website:

![Branching system](/images/development/contribute/documentation/branching-system.png)

### `main` branch

The `main` branch will serve as the living documentation for the latest released
version of the Management Console. Following a new release, only patches and
hotfixes will be committed to this branch.

### Version branches

Upon the release of a new minor version of the Management Console, a snapshot of
the `main` branch will be taken. This serves as an archive for the documentation
corresponding to the previous version. For instance, with the release of
Management Console version 1.1, we will create a branch from `main` named `v1.0`.
The `v1.0` branch will host the documentation for the Management Console version
1.0 and will no longer receive updates for subsequent versions.

### Development branches

Simultaneously with the snapshot creation, we'll establish a development branch
for the upcoming version. For example, concurrent with the launch of Management
Console version 1.1, we will initiate a `dev-v1.2` branch. This branch will
accumulate all the documentation updates for the forthcoming version of the
Management Console. Upon the release of the next version, we will merge the
`dev-v1.2` branch into `main`, updating the documentation website to reflect the
newest version.

## Hugo configuration

To maintain the versioning of our documentation website, specific adjustments
need to be made to the Hugo configuration file (`hugo.toml`). Follow the steps
below to ensure the versioning is correctly reflected.

- **Version branches**
  - Update the `latest` parameter to match the branch version. For instance, for
    the `v1.0` branch, set `latest` to `1.0`.
  - The `[[params.versions]]` array should include entries for the current
    version and the upcoming version. For the `v1.0` branch, the configuration
    would be:

    ```toml
    [[params.versions]]
    version = "1.1" # Upcoming version
    url = "https://umh.docs.umh.app"
    branch = "main"
    [[params.versions]]
    version = "1.0" # Current version
    url = "https://v1-0.umh-docs-umh-app.pages.dev/docs/"
    branch = "v1.0"
    ```

- **Development branches**
  - Set the `latest` parameter to the version that the branch is preparing. If
    the branch is `dev-v1.2`, then `latest` should be `1.2`.
  - The `[[params.versions]]` array should list the version being developed
    using the Cloudflare Pages URL. The entry for `dev-v1.2` would be:

    ```toml
    [[params.versions]]
    version = "1.2" # Version in development
    url = "https://dev-v1-2--umh-docs-umh-app.pages.dev"
    branch = "dev-v1.2"
    [[params.versions]]
    version = "1.1" # latest version
    url = "https://umh.docs.umh.app"
    branch = "main"
    ```

  - Prior to merging a development branch into `main`, update the `url` for the
    version being released to point to the main site and adjust the entry for the
    previous version to its Cloudflare Pages URL. For instance, just before
    merging `dev-v1.2`:

    ```toml
    [[params.versions]]
    version = "1.2" # New stable version
    url = "https://umh.docs.umh.app"
    branch = "main"
    [[params.versions]]
    version = "1.1" # Previous version
    url = "https://v1-1--umh-docs-umh-app.pages.dev"
    branch = "v1.1"
    ```

Always ensure that the `[[params.versions]]` array reflects the correct order of
the versions, with the newest version appearing first.
