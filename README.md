# United Manufacturing Hub documentation website

[![Website][badge-website]](https://umh.docs.umh.app)
![GitHub commit activity][badge-commit-activity]

This repository contains the technical documentation for the United Manufacturing Hub.


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

If you want to contribute, take a look at our [contribution guidelines](https://umh.docs.umh.app/docs/development/contribute/getting-started/).

<!-- definitions -->
[badge-website]: https://img.shields.io/website?up_message=online&url=https%3A%2F%2Fumh.docs.umh.app%2Fdocs%2F
[badge-commit-activity]: https://img.shields.io/github/commit-activity/m/united-manufacturing-hub/umh.docs.umh.app
