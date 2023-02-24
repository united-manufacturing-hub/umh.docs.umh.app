+++
title =  "Releasing a new Version"
description = "How to release a new version of UMH"
+++


## Semantic Versioning

The UMH uses the semantic versioning. This article explains how to increase the version number and what steps are needed to take.

### Steps

1. To create a release branch, use the version number as the branch name.
   For example, if the version is `0.6.0`, the branch name should be `0.6.0`.

   For pre-releases, use the version number with a `-prerelease` suffix as the branch name.
   For example, if the version is a pre-release of `0.6.0`, the branch name should be `0.6.0-prerelease`.
2. GitHub Actions automatically builds Docker, using the branch name as tag.
3. Create a pull request from the release branch to `main`.
4. Update the helm chart `united-manufacturing-hub` by opening `Charts.yaml` and changing the version to the next version (including a `prerelease` if applicable).
5. To adjust the repo link `https://repo.umh.app` in `docs/static/examples/development.yaml`, change it to the deploy-preview of helm-repo. For example, change it to `https://0.6.0.united-manufacturing-hub.pages.dev`.
   Additionally, add a `--devel` flag to the helm install commands so that helm considers the pre-release as a valid version.
6. Navigate to the folder `deployment/helm-repo` and run the following commands:
   ```bash
   helm package ../united-manufacturing-hub/
   helm repo index --url https://<version>.united-manufacturing-hub.pages.dev --merge index.yaml .
   ```
7. Make a commit and push the changes.
8. Wait for all container and deploy previews to be created.
9. Perform all tests.
10. Repeat steps 4 - 6 with the changed version number `0.6.0` (instead of `0.6.0-prerelease`) and the changed repo index URL: [https://repo.umh.app](https://repo.umh.app/).
11. Remove pre-release helm packages from the repository.
12. Make a commit and push the changes.
13. Merge the pull request from the staging branch to the main branch.
14. Create a new release that contains a changelog of all changes. Use the GitHub feature to generate the changelogs and create a new section at the top for release highlights.
