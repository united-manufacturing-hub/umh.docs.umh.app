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

<!-- companion -->

Here's a refined version of your documentation text, aimed at enhancing clarity, conciseness, and readability for technical audiences:


# Companion

## Preparing the Documentation

Begin by drafting new documentation within the `/docs/whatsnew` directory of the [United Manufacturing Hub documentation repository](https://github.com/united-manufacturing-hub/umh.docs.umh.app). Your draft should comprehensively include:
- The UMH version rolled out with this release.
- The new Companion version.
- Versions of any installed plugins, such as `Benthos-UMH`.

Initiate your document with an executive summary that encapsulates updates and changes across all platforms, including UMH and Companion.

## Version Update Procedure

Navigate to the [ManagementConsole repository](https://github.com/united-manufacturing-hub/ManagementConsole) and contribute a new `.go` file within the `/updater/cmd/upgrades` path. This file's name must adhere to the semantic versioning convention of the update (e.g., `0.1.0.go`).

This file should:
- Implement the `Version` interface defined in `upgrade_interface.go`.
- Include `PreMigration` and `PostMigration` functions that may return `nil` if no specific migration tasks are necessary.
- Define `GetImageVersion` to return the Docker tag associated with the new version.
- Specify any Kubernetes controllers (e.g., Statefulsets, Deployments) needing restart post-update in the `GetPodControllers` function.

{{% notice note %}}
Ensure to review the restart policies for the Kubernetes objects designated for restart, paying special attention to jobs.
{{% /notice %}}

Update the `version.json` in the `frontend/static/version` directory with the new image tag and incorporate the changelog derived from your initial documentation draft.

## Finalizing the Release

To finalize:
1. Submit a PR to the [documentation repository](https://github.com/united-manufacturing-hub/umh.docs.umh.app) to transition the release notes from draft to final.
2. Initiate a PR from the staging to the main branch within the [ManagementConsole repository](https://github.com/united-manufacturing-hub/ManagementConsole), ensuring to reference the documentation PR.
3. Confirm the success of all test suites.
4. Merge the code changes and formalize the release on GitHub, labeling it with the semantic version (e.g., `0.1.0`, excluding any preceding `v`).
5. Merge the documentation PR to publicize the new version within the official documentation.





<!--
   In the future we might need to add some additional steps, if the companion also updates the UMH
-->

<!-- helm -->

# Helm Chart

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
