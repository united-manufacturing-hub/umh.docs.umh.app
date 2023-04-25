---
title: Write a new topic
description: |
  This page shows how to create a new topic for the United Manufacturing Hub docs.
weight: 40
---

## Choosing a page type

As you prepare to write a new topic, think about the page type that would fit
your content the best. We have many archetypes to choose from, and you can
create a new one if none of the existing ones fit your needs.

Generally, each archetype is specific to a particular type of content. For
example, the `upgrading` archetype is used for pages that describe how to
upgrade to a new version of United Manufacturing Hub, and most of the content
in the Production Guide section of the docs uses the `tasks` archetype.

In the [content guide](/docs/development/contribute/documentation/style/content-guide/#content-types)
you can find a description of the most used archetypes. If you need to create
a new archetype, you can find more information in the
[Hugo documentation](https://gohugo.io/content-management/archetypes/).

## Choosing a directory

The directory in which you put your file is mostly determined by the page type
you choose.

If you think that your topic doesn't belong to any of the existing sections,
you should first discuss with the United Manufacturing Hub team where your
topic should go. They will coordinate the creation of a new section if needed.

## Choosing a title and filename

Choose a title that has the keywords you want search engines to find.
Create a filename that uses the words in your title separated by hyphens.
For example, the topic with title
[Access Factoryinsight Outside the Cluster](/docs/production-guide/administration/access-factoryinsight-outside-cluster/)
has filename `access-factoryinsight-outside-cluster.md`. You don't need to put
"united manufacturing hub" in the filename, because "umh" is already in the
URL for the topic, for example:

```none
https://umh.docs.umh.app/docs/production-guide/administration/access-factoryinsight-outside-cluster/
```

## Adding the topic title to the front matter

In your topic, put a `title` field in the
[front matter](https://gohugo.io/content-management/front-matter/).
The front matter is the YAML block that is between the
triple-dashed lines at the top of the page. Here's an example:

```yaml
---
title: Access Factoryinsight Outside the Cluster
---
```

Most of the archetypes automatically create the page title using the filename,
but always check that the title makes sense.

## Creating a new page

Once you have chosen the archetype, the location, and the file name, you can
create a new page using the `hugo new` command. For example, to create a new page
using the `tasks` archetype, run the following command:

```bash
hugo new docs/production-guide/my-first-task.md -k tasks
```

## Placing your topic in the table of contents

The table of contents is built dynamically using the directory structure of the
documentation source. The top-level directories under `/content/en/docs/` create
top-level navigation, and subdirectories each have entries in the table of
contents.

Each subdirectory has a file `_index.md`, which represents the "home" page for
a given subdirectory's content. The `_index.md` does not need a template. It
can contain overview content about the topics in the subdirectory.

Other files in a directory are sorted alphabetically by default. This is almost
never the best order. To control the relative sorting of topics in a
subdirectory, set the `weight:` front-matter key to an integer. Typically, we
use multiples of 10, to account for adding topics later. For instance, a topic
with weight `10` will come before one with weight `20`.

You can hide a topic from the table of contents by setting `toc_hide: true`, and
you can hide the list of child pages at the botton of an `_index.md` file by
setting `no_list: true`.

## Embedding code in your topic

If you want to include some code in your topic, you can embed the code in your
file directly using the markdown code block syntax. This is recommended for the
following cases (not an exhaustive list):

- The code shows the output from a command such as
  `kubectl get deploy mydeployment -o json | jq '.status'`.
- The code is not generic enough for users to try out.
- The code is an incomplete example because its purpose is to highlight a
  portion of a larger file.
- The code is not meant for users to try out due to other reasons.

## Including code from another file

Another way to include code in your topic is to create a new, complete sample
file (or group of sample files) and then reference the sample from your topic.
Use this method to include sample YAML files when the sample is generic and
reusable, and you want the reader to try it out themselves.

When adding a new standalone sample file, such as a YAML file, place the code in
one of the `<LANG>/examples/` subdirectories where `<LANG>` is the language for
the topic. In your topic file, use the `codenew` shortcode:

```none
{{</* codenew file="<RELPATH>/my-example-yaml>" */>}}
```

where `<RELPATH>` is the path to the file to include, relative to the
`examples` directory. The following Hugo shortcode references a YAML
file located at `/content/en/examples/pods/storage/gce-volume.yaml`.

```none
{{</* codenew file="pods/storage/gce-volume.yaml" */>}}
```

## Adding images to a topic

Put image files in the `/static/images` directory. The preferred image format is
SVG. Organize images in subdirectories under `/static/images` as needed.

Add images to the page using markdown image syntax:

```md
![Alt text](/images/my-image.svg)
```

## {{% heading "whatsnext" %}}

- Read the [content guidelines](/docs/development/contribute/documentation/style/content-guide/).
- Learn about [content styling](/docs/development/contribute/documentation/style/style-guide/).
