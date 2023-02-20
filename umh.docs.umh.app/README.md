# Requirements

 - Recent version of [Hugo](https://gohugo.io/getting-started/installing/)
 - [Git](https://git-scm.com/)

# Preparation

Initialize the themes submodule
```bash
git submodule update -f --init --recursive
cd umh.docs.umh.app/themes/docsy
npm install
```

# Serving locally

```bash
hugo server -D
```