---
title: "Release Process"
content_type: task
description: |
    This page describes how to release a new version of the United Manufacturing
    Hub.
weight: 50
---

<!-- overview -->

Releases are coordinated by the United Manufacturing Hub team. All the features
and bug fixes due for a release are tracked in the internal project board.

Once all the features and bug fixes for a release are ready and merged into the
`staging` branch, the release process can start.

<!-- steps -->

## Prerelease

The prerelease process is used to test the release before it is published.
If bugs are found during the prerelease, they can be fixed and the release
process can be restarted. Once the prerelease is finished, the release can be
published.

1. Create a prerelease branch from `staging`:

    ```bash
    git checkout staging
    git pull
    git checkout -b <next-version>-prerelease1
    ```

2. Update the `version` and `appVersion` fields in the `Chart.yaml` file to the
   next version:

    ```yaml
    version: <next-version>-prerelease1
    appVersion: <next-version>-prerelease1
    ```

3. Navigate to the `deployment/helm-repo` directory and run the following
   commands:

    ```bash
    helm package ../united-manufacturing-hub
    helm repo index --url https://staging.united-manufacturing-hub.pages.dev --merge index.yaml .
    ```

   Pay attantion to use `-` instead of `.` as a separator in `<next-version>`.

4. Commit and push the changes:

    ```bash
    git add .
    git commit -m "build: <next-version>-prerelease1"
    git push origin <next-version>-prerelease1
    ```

5. Merge prerelease branch into `staging`

## Test

All the new releases must be thoroughly tested before they can be published.
This includes specific tests for the new features and bug fixes, as well as
general tests for the whole stack.

General tests include, but are not limited to:

- Deploy the stack with flatcar
- Upgrade the stack from the previous version
- Deploy the stack on Karbon 300 and test with real sensors

If any bugs are found during the testing phase, they must be fixed and pushed
to the prerelease branch. Multiple prerelease versions can be created if
necessary.

## Release

Once all the tests have passed, the release can be published. Merge the
prerelease branch into `staging` and create a new release branch.

1. Create a release branch from `staging`:

   ```bash
   git checkout main
   git pull
   git checkout -b <next-version>
   ```

2. Update the `version` and `appVersion` fields in the `Chart.yaml` file to the
   next version:

   ```yaml
   version: <next-version>
   appVersion: <next-version>
   ```

3. Navigate to the `deployment/helm-repo` directory and run the following
   commands:

   ```bash
   helm package ../united-manufacturing-hub
   helm repo index --url https://repo.umh.app --merge index.yaml .
   ```

4. Commit and push the changes, tagging the release:

     ```bash
     git add .
     git commit -m "build: <next-version>"
     git tag <next-version>
     git push origin <next-version> --tags
     ```

5. Merge the release branch into `staging`

6. Merge `staging` into `main` and create a new release from the tag on
   GitHub.
