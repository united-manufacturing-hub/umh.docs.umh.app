# The United Manufacturing Hub documentation

[![Website][badge-website]](https://umh.docs.umh.app)
![GitHub commit activity][badge-commit-activity]

This repository contains the assets required to build the [United Manufacturing Hub documentation website](https://umh.docs.umh.app). We're glad that you want to contribute!

- [Contributing to the docs](#contributing-to-the-docs)

## Prerequisites

To use this repository, you need the following installed locally:

- [npm](https://www.npmjs.com/)
- [Go](https://go.dev/)
- [Hugo (Extended version)](https://gohugo.io/)
- [make](https://www.gnu.org/software/make/)
  - `choco install make` on Windows

Before you start, install the dependencies. Clone the repository and navigate to the directory:

```bash
git clone https://github.com/united-manufacturing-hub/umh.docs.umh.app.git
cd umh.docs.umh.app
git lfs install
```

The United Manufacturing Hub documentation website uses the [Docsy Hugo theme](https://github.com/google/docsy#readme).

```bash
# fetch submodule dependencies
make module-init
```

## Running the website locally using Hugo

To build and test the site locally, run:

```bash
make serve
```

This will start the local Hugo server on port 1313. Open up your browser to <http://localhost:1313> to view the website. As you make changes to the source files, Hugo updates the website and forces a browser refresh.

## Contributing to the docs

You can click the **Fork** button in the upper-right area of the screen to create a copy of this repository in your GitHub account. This copy is called a _fork_. Make any changes you want in your fork, and when you are ready to send those changes to us, go to your fork and create a new pull request to let us know about it.

Once your pull request is created, a UMH reviewer will take responsibility for providing clear, actionable feedback. As the owner of the pull request, **it is your responsibility to modify your pull request to address the feedback that has been provided to you by the UMH reviewer.**

Also, note that you may end up having more than one UMH reviewer provide you feedback or you may end up getting feedback from a UMH reviewer that is different than the one initially assigned to provide you feedback.

Reviewers will do their best to provide feedback in a timely fashion but response time can vary based on circumstances.

For more information about contributing to the United Manufacturing Hub documentation, see:

- [Contribute to UMH docs](https://umh.docs.umh.app/docs/development/contribute/documentation/)
- [Page Content Types](https://umh.docs.umh.app/docs/development/contribute/documentation/style/page-content-types/)
- [Documentation Style Guide](https://umh.docs.umh.app/docs/development/contribute/documentation/style/style-guide/)
- [Localizing UMH Documentation](https://umh.docs.umh.app/docs/development/contribute/documentation/localization/)

## Code of conduct

Participation in the UMH community is governed by the [Code of Conduct](.github/CODE_OF_CONDUCT.md).

## Thank you

UMH thrives on community participation, and we appreciate your contributions to our documentation!

<!-- definitions -->
[badge-website]: https://img.shields.io/website?up_message=online&url=https%3A%2F%2Fumh.docs.umh.app%2Fdocs%2F
[badge-commit-activity]: https://img.shields.io/github/commit-activity/m/united-manufacturing-hub/umh.docs.umh.app
