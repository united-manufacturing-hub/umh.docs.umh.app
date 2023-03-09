---
title: Writing a new topic
content_type: task
description: |
  This page shows how to create a new topic for the United Manufacturing Hub docs.
weight: 40
---

<!-- overview -->
This page shows how to create a new topic for the United Manufacturing Hub docs.

## {{% heading "prerequisites" %}}

Create a fork of the United Manufacturing Hub documentation repository as described in
[Adding documentation](/docs/development/contribute/new-content/add-documentation/).

<!-- steps -->

## Choosing a page type

As you prepare to write a new topic, think about the page type that would fit your content the best:

{{< table caption = "Guidelines for choosing a page type" >}}
| Type     | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| :------- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Concept  | A concept page explains some aspect of United Manufacturing Hub. For example, a concept page might describe a specific component of the United Manufacturing Hub and explain the role it plays as an application while it is deployed, scaled, and updated. Typically, concept pages don't include sequences of steps, but instead provide links to tasks or tutorials.                                                                                                                                                                                                                                                                       |
| Task     | A task page shows how to do a single thing. The idea is to give readers a sequence of steps that they can actually do as they read the page. A task page can be short or long, provided it stays focused on one area. In a task page, it is OK to blend brief explanations with the steps to be performed, but if you need to provide a lengthy explanation, you should do that in a concept topic. Related task and concept topics should link to each other. For an example of a short task page, see [Expose Grafana to the internet](/docs/production-guide/administration/expose-grafana-to-internet/). For an example of a longer task page, see [Access the database](/docs/production-guide/administration/access-database/) |
| Tutorial | A tutorial page shows how to accomplish a goal that ties together several United Manufacturing Hub features. A tutorial might provide several sequences of steps that readers can actually do as they read the page. Or it might provide explanations of related pieces of code. For example, a tutorial could provide a walkthrough of a code sample. A tutorial can include brief explanations of the United Manufacturing Hub features that are being tied together, but should link to related concept topics for deep explanations of individual features.                                                                                                                                    |
{{< /table >}}

### Creating a new page

Use a [content type](/docs/development/contribute/documentation/style/page-content-types/) for each new page
that you write. The docs site provides templates or
[Hugo archetypes](https://gohugo.io/content-management/archetypes/) to create
new content pages. To create a new type of page, run `hugo new` with the path to the file
you want to create. For example:

```bash
hugo new docs/administration/my-first-task.md -k tasks
```

## Choosing a title and filename

Choose a title that has the keywords you want search engines to find.
Create a filename that uses the words in your title separated by hyphens.
For example, the topic with title
[Access Factoryinsight Outside the Cluster](/docs/production-guide/administration/access-factoryinsight-outside-cluster/)
has filename `access-factoryinsight-outside-cluster.md`. You don't need to put
"united manufacturing hub" in the filename, because "umh" is already in the
URL for the topic, for example:

```none
/docs/production-guide/administration/access-factoryinsight-outside-cluster/
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

## Choosing a directory

Depending on the content of your page, put your new file in a subdirectory of one of these:

- /content/en/docs/production-guide/administration/
- /content/en/docs/architecture/
- /content/en/docs/development/
- /content/en/docs/getstarted/
- /content/en/docs/production-guide/

You can put your file in an existing subdirectory, or you can create a new
subdirectory.

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

{{< notice note >}}
To show raw Hugo shortcodes as in the above example and prevent Hugo
from interpreting them, use C-style comments directly after the `<` and before
the `>` characters. View the code for this page for an example.
{{< /notice >}}

## Adding images to a topic

Put image files in the `/images` directory. The preferred
image format is SVG.

## {{% heading "whatsnext" %}}

- Learn about [using page content types](/docs/development/contribute/documentation/style/page-content-types/).
- Learn about [creating a pull request](/docs/development/contribute/new-content/add-documentation/#open-a-pr).
