# Contributing

## Contents

## Introduction

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

In this document you will get an overview of the contribution workflow from opening an issue, creating a PR, reviewing and merging the PR. We are trying to create an atmosphere were we all can collaborate while enjoying programming.

See also our [Code of Conduct](CODE_OF_CONDUCT.md) to keep our community approachable and respectable.

## New contributor guide

To get an overview of the project, see the [README](../README.md) and the [documentation][documentation].

## Getting started

### Issues

#### Create a new issue

No one is perfect, so if you spot a problem with the project, search if an [issue already exists][issues]. If not, create a new issue with a descriptive title and a clear description of the problem. Please also add a meaningful label to the issue.

#### Suggest new features

We are happy about every new idea or change request. You can see if we are already working on something similar by searching for [issues][issues] with the label `enhancement`. If you have a new idea, create a new issue with a descriptive title and a clear description of the feature. Please also add the label `enhancement`.

You can also open a [discussion][discussions] to discuss your idea with the community, or reach out to us on [Discord][discord].

#### Solve an issue

If you want to work on an issue, please assign yourself to the issue. This way we can see who is working on what. If you have any questions, please ask them in the issue.

### Make changes

1. First of all you should [fork][fork] the repository.
2. Create a branch based on the issue that you want to work on, following this naming convention:
   `<type-of-change>/<issue-number>/<short-description>`. For example: `issue/42/fix-bug`.
   - `type-of-change` can be one of the following:
     - `fix` for bug fixes
     - `feat` for new features
     - `refactor` for refactoring code
     - `docs` for changes to the documentation
     - `test` for changes to the tests
     - `chore` for changes to the build process or auxiliary tools and libraries such as documentation generation
   - `short-description` should be a short description of the change, or the issue title if it is short enough.
3. Make your changes and commit them to your branch. Try to keep your commits small and focused on one thing. If you have "junk" commits, like "fix typo", "fix bug", "fix bug again", you can squash them together.
    We also follow the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification for commit messages.
4. Test your changes. If you have added new features, please also add tests for them.
5. Push your changes to your fork.

### Pull requests

#### Create a new pull request

When you are ready to submit your changes, create a new pull request.

- Please make sure that you have filled out the pull request template.
- If you are working on an issue, please add the issue number to the pull request description. For example: `Fix #42`.
- Enable the checkbox "Allow edits and access to secrets by maintainers" to allow us to make changes to your pull request.

#### Review a pull request

If you are a maintainer, please review the pull request. If you are not a maintainer, please wait for a maintainer to review the pull request.

- We may ask you to make some changes to your pull request. If you are not sure how to do that, please ask us.
- As you update your pull request, please make sure that the tests are still passing, and to mark each conversation as resolved if you have fixed the issue.
- If you run into merge conflicts, please rebase your branch on the latest `main` branch.

#### Merge a pull request

If you are a maintainer, please merge the pull request. If you are not a maintainer, please wait for a maintainer to merge the pull request.

If you are merging a pull request, please use the "Create a merge commit" option. This will create a merge commit with the pull request number in the commit message. This will make it easier to find the pull request that introduced a change.

Congratulations! The United Manufacturing Hub team thanks you for your contribution! You are now part of our community and will be added to the [contributors list][contributors].

## Tools and conventions

- We use [GitHub Flow](https://guides.github.com/introduction/flow/), so all changes are made in feature branches and merged into the `main` branch.
- We use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.
- We use [Semantic Versioning](https://semver.org/) for versioning.
- We use [GitHub Actions](https://github.com/united-manufacturing-hub/<repository-name>/actions) for CI/CD.

## Documents

- All contributors must accept the [Contributor License Agreement](CONTRIBUTOR_LICENSE_AGREEMENT_INDIVIDUAL.md) before their pull request can be merged.
- By contributing to this repository, you agree that your contributions will be licensed under its [LICENSE](LICENSE).
- The [CODE_OF_CONDUCT](CODE_OF_CONDUCT.md) file defines the code of conduct for the project. Please follow it to keep our community approachable and respectable.
- The [CODEOWNERS](CODEOWNERS) file defines the maintainers of the project.


<!-- definitions -->

[discussions]: https://github.com/united-manufacturing-hub/umh.docs.umh.app/discussions

[issues]: https://github.com/united-manufacturing-hub/umh.docs.umh.app/issues

[fork]: https://github.com/united-manufacturing-hub/umh.docs.umh.app/fork

[contributors]: https://github.com/united-manufacturing-hub/umh.docs.umh.app/graphs/contributors

[discord]: https://discord.com/invite/F9mqkZnm9d

[documentation]: https://umh.docs.umh.app/docs/
