---
title: Getting Started With Contributing
weight: 1
description: |
    A small list of things that you should read and be familiar with before you
    get started with contributing.
---

## Welcome

This document is the single source of truth for how to contribute to the code
base. Feel free to browse the open issues and file new ones, all feedback
is welcome!

## Prerequisites

Before you begin contributing, you should first complete the following prerequisites:

### Create a GitHub account

Before you get started, you will need to [sign up](http://github.com/signup) for
a GitHub user account.

### Sign the Contributor License Agreement

Before you can contribute to United Manufacturing Hub, you will need to sign the
[Contributor License Agreement](https://github.com/united-manufacturing-hub/united-manufacturing-hub/blob/main/CONTRIBUTOR_LICENSE_AGREEMENT_ENTITY.md).

### Code of Conduct

Please make sure to read and observe the [Code of Conduct](https://github.com/united-manufacturing-hub/united-manufacturing-hub/blob/main/CODE_OF_CONDUCT.md).

### Setting up your development environment

It is not required to set up a developer environment in order to contribute to
Kubernetes.

If you plan to contribute code changes, review the
[developer resources](/docs/development/contribute/united-manufacturing-hub/)
page for how to set up your environment.

## Find something to work on

The first step to getting starting contributing to United Manufacturing Hub is
to find something to work on. Help is always welcome, and no contribution is too
small!

Here are some things you can do today to get started contributing:

- Help improve the United Manufacturing Hub documentation
- Clarify code, variables, or functions that can be renamed or commented on
- Write test coverage
- If the above suggestions don’t appeal to you, you can browse the issues labeled
as a good first issue to see who is looking for help.

Look at the issue section of any of our repositories to find issues that are
currently open. Don't be afraid to ask questions if you are interested in
contributing to a specific issue.
When you find something you want to work on, you can assign the issue to yourself.

## Make your changes

Once you have found something to work on, you can start making your changes.
Follow the [contributing guidelines](https://github.com/united-manufacturing-hub/united-manufacturing-hub/blob/main/CONTRIBUTING.md)

## Open a pull request

Once you have made your changes, you can submit them for review. You can do this
by creating a pull request (PR) against the main branch of the repository.

## Code review

Once you have submitted your changes, a maintainer will review your changes and
provide feedback.

As a community we believe in the value of code review for all contributions.
Code review increases both the quality and readability of our codebase, which in
turn produces high quality software.

See the [pull request documentation](/docs/development/contribute/new-content/pull-request/)
for more information on code review.

Expect reviewers to request that you avoid [common go style mistakes](https://github.com/golang/go/wiki/CodeReviewComments)
in your PRs.

## Best practices

- Write clear and meaningful git commit messages.
- If the PR will completely fix a specific issue, include fixes #123 in the PR
  body (where 123 is the specific issue number the PR will fix. This will
  automatically close the issue when the PR is merged.
- Make sure you don’t include @mentions or fixes keywords in your git commit
  messages. These should be included in the PR body instead.
- When you make a PR for small change (such as fixing a typo, style change, or
  grammar fix), please squash your commits so that we can maintain a cleaner git
  history.
- Make sure you include a clear and detailed PR description explaining the reasons
  for the changes, and ensuring there is sufficient information for the reviewer
  to understand your PR.
- Additional Readings:
  - [chris.beams.io/posts/git-commit/](https://cbea.ms/git-commit/)
  - [github.com/blog/1506-closing-issues-via-pull-requests](https://cbea.ms/git-commit/)
  - [davidwalsh.name/squash-commits-git](https://davidwalsh.name/squash-commits-git)
  - [https://mtlynch.io/code-review-love/](https://mtlynch.io/code-review-love/)

## Testing

Testing is the responsibility of all contributors. It is important to ensure that
all code is tested and that all tests pass. This ensures that the code base is
stable and reliable.

There are multiple type of tests. The location of the test code vaires with type,
as do the specifics of the environment needed to succesfully run the test:

- Unit: These confirm that a particular function behaves as intended. Golang
  includes a native ability for unit testing via te [testing](https://golang.org/pkg/testing/)
  package. Unit test source code can be found adjacent tot the corresponding
  source code within a given package. These are easily run by any developer on
  ant OS.
- Integration: These tests cover interactions of package components or interactions
  between UMh components and some external system. An example would be testing
  whether a piece of code can correctly store data in tha database.
  Running these tests can require the developer to set up additional functionality
  on their development system.
- End-to-end ("e2e"): These are broad test of overall system behavior and
  coherence. These are more complicated as they require a functional Kubernetes
  cluster. There are some e2e tests running in pipelines, and if your changes
  require e2e tests, you will need to add them to the pipeline. You can find
  more information about the CI pipelines in the [CI documentation](/docs/development/ci-cd/).

## Documentation

Documentation is an important part of any project. It is important to ensure that
all code is documented and that all documentation is up to date.

Learn more about how to contribute to the documentation on the
[documentation contributor guide](/docs/development/contribute/documentation/).
