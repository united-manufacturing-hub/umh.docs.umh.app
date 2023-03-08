# docs.docs.umh.app

![Website][badge-website]
![GitHub commit activity][badge-commit-activity]

This repository contains the technical documentation for the United Manufacturing Hub.

## Table of contents

The documentation of the UMH stack.

## Requirements

- Recent version of [Hugo](https://gohugo.io/getting-started/installing/)

## Get started

Initialize the themes submodule

```bash
git submodule update -f --init --recursive
cd umh.docs.umh.app/themes/docsy
npm install
```

### Git LFS

```bash
git lfs install
```


### Serving locally

```bash
hugo server -D
```

## Contributing

If you want to contribute, take a look at our contribution guidelines in `umh.docs.umh.app/content/en/docs/development/contribute/getting-started.md`

<!-- definitions -->
[badge-website]: https://img.shields.io/website?up_message=online&url=https%3A%2F%2Fwww.umh.app
[badge-commit-activity]: https://img.shields.io/github/commit-activity/m/united-manufacturing-hub/umh.docs.umh.app