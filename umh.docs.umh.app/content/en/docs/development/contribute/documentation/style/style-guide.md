---
title: Documentation Style Guide
linktitle: Style guide
description: |
    This page gives writing style guidelines for the United Manufacturing Hub documentation.
content_type: concept
weight: 20
---

<!-- overview -->
This page gives writing style guidelines for the United Manufacturing Hub documentation.
These are guidelines, not rules. Use your best judgment, and feel free to
propose changes to this document in a pull request.

For additional information on creating new content for the United Manufacturing Hub
documentation, read the [Documentation Content Guide](/docs/development/contribute/documentation/style/content-guide/).

<!-- body -->

## Language

The United Manufacturing Hub documentation has not been translated yet. But if
you want to help with that, you can check out the [localization page](/docs/development/contribute/documentation/localization/).

## Documentation formatting standards

### Use upper camel case for Kubernetes objects

When you refer specifically to interacting with a Kubernetes object, use
[UpperCamelCase](https://en.wikipedia.org/wiki/Camel_case), also known as Pascal
case.

When you are generally discussing a Kubernetes object, use
[sentence-style capitalization](https://docs.microsoft.com/en-us/style-guide/text-formatting/using-type/use-sentence-style-capitalization).

The following examples focus on capitalization. For more information about
formatting Kubernetes object names, review the related guidance on
[Code Style](#code-style-inline-code).

{{< table caption = "Do and Don't - Use Pascal case for Kubernetes objects" >}}
| Do                                                       | Don't                                                        |
| :------------------------------------------------------- | :----------------------------------------------------------- |
| The ConfigMap of ...                                     | The Config map of ...                                        |
| The Volume object contains a `hostPath` field.           | The volume object contains a hostPath field.                 |
| Every ConfigMap object is part of a namespace.           | Every configMap object is part of a namespace.               |
| For managing confidential data, consider using a Secret. | For managing confidential data, consider using the a secret. |
{{< /table >}}

### Use angle brackets for placeholders

Use angle brackets for placeholders. Tell the reader what a placeholder
represents, for example:

Display information about a pod:

```shell
kubectl describe pod <pod-name> -n <namespace>
```

### Use bold for user interface elements

{{< table caption = "Do and Don't - Bold interface elements" >}}
| Do                | Don't           |
| :---------------- | :-------------- |
| Click **Fork**.   | Click "Fork".   |
| Select **Other**. | Select "Other". |
{{< /table >}}

### Use italics to define or introduce new terms

{{< table caption = "Do and Don't - Use italics for new terms" >}}
| Do                                         | Don't                                        |
| :----------------------------------------- | :------------------------------------------- |
| A _cluster_ is a set of nodes ...          | A "cluster" is a set of nodes ...            |
| These components form the _control plane_. | These components form the **control plane**. |
{{< /table >}}

### Use code style for filenames, directories, and paths

{{< table caption = "Do and Don't - Use code style for filenames, directories, and paths" >}}
| Do                                     | Don't                                |
| :------------------------------------- | :----------------------------------- |
| Open the `envars.yaml` file.           | Open the envars.yaml file.           |
| Go to the `/docs/tutorials` directory. | Go to the /docs/tutorials directory. |
| Open the `/_data/concepts.yaml` file.  | Open the /\_data/concepts.yaml file. |
{{< /table >}}

### Use the international standard for punctuation inside quotes

{{< table caption = "Do and Don't - Use the international standard for punctuation inside quotes" >}}
| Do                                              | Don't                                           |
| :---------------------------------------------- | :---------------------------------------------- |
| events are recorded with an associated "stage". | events are recorded with an associated "stage." |
| The copy is called a "fork".                    | The copy is called a "fork."                    |
{{< /table >}}

## Inline code formatting

### Use code style for inline code, commands, and API objects {#code-style-inline-code}

For inline code in an HTML document, use the `<code>` tag. In a Markdown
document, use the backtick (`` ` ``).

{{< table caption = "Do and Don't - Use code style for inline code, commands, and API objects" >}}
| Do                                                                                       | Don't                                                                                                                   |
| :--------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------- |
| The `kubectl run` command creates a `Pod`.                                               | The "kubectl run" command creates a pod.                                                                                |
| The kubelet on each node acquires a `Lease`…                                             | The kubelet on each node acquires a lease…                                                                              |
| A `PersistentVolume` represents durable storage…                                         | A Persistent Volume represents durable storage…                                                                         |
| For declarative management, use `kubectl apply`.                                         | For declarative management, use "kubectl apply".                                                                        |
| Enclose code samples with triple backticks. (\`\`\`)                                     | Enclose code samples with any other syntax.                                                                             |
| Use single backticks to enclose inline code. For example, `var example = true`.          | Use two asterisks (`**`) or an underscore (`_`) to enclose inline code. For example, **var example = true**.            |
| Use triple backticks before and after a multi-line block of code for fenced code blocks. | Use multi-line blocks of code to create diagrams, flowcharts, or other illustrations.                                   |
| Use meaningful variable names that have a context.                                       | Use variable names such as 'foo','bar', and 'baz' that are not meaningful and lack context.                             |
| Remove trailing spaces in the code.                                                      | Add trailing spaces in the code, where these are important, because the screen reader will read out the spaces as well. |
{{< /table >}}

{{% notice note %}}
The website supports syntax highlighting for code samples, but specifying a language is optional. Syntax highlighting in the code block should conform to the [contrast guidelines.](https://www.w3.org/WAI/WCAG21/quickref/?versions=2.0&showtechniques=141%2C143#contrast-minimum)
{{% /notice %}}

### Use code style for object field names and namespaces

{{< table caption = "Do and Don't - Use code style for object field names" >}}
| Do                                                               | Don't                                                            |
| :--------------------------------------------------------------- | :--------------------------------------------------------------- |
| Set the value of the `replicas` field in the configuration file. | Set the value of the "replicas" field in the configuration file. |
| The value of the `exec` field is an ExecAction object.           | The value of the "exec" field is an ExecAction object.           |
| Run the process as a DaemonSet in the `kube-system` namespace.   | Run the process as a DaemonSet in the kube-system namespace.     |
{{< /table >}}

### Use code style for command tools and component names

{{< table caption = "Do and Don't - Use code style for command tools and component names" >}}
| Do                                                                                | Don't                                                                           |
| :-------------------------------------------------------------------------------- | :------------------------------------------------------------------------------ |
| The kubelet preserves node stability.                                             | The `kubelet` preserves node stability.                                         |
| The `kubectl` handles locating and authenticating to the API server.              | The kubectl handles locating and authenticating to the apiserver.               |
| Run the process with the certificate, `kube-apiserver --client-ca-file=FILENAME`. | Run the process with the certificate, kube-apiserver --client-ca-file=FILENAME. |
{{< /table >}}

### Starting a sentence with a component tool or component name

{{< table caption = "Do and Don't - Starting a sentence with a component tool or component name" >}}
| Do                                                                        | Don't                                                                 |
| :------------------------------------------------------------------------ | :-------------------------------------------------------------------- |
| The `kubeadm` tool bootstraps and provisions machines in a cluster.       | `kubeadm` tool bootstraps and provisions machines in a cluster.       |
| The kube-scheduler is the default scheduler for United Manufacturing Hub. | kube-scheduler is the default scheduler for United Manufacturing Hub. |
{{< /table >}}

### Use a general descriptor over a component name

{{< table caption = "Do and Don't - Use a general descriptor over a component name" >}}
| Do                                                  | Don't                               |
| :-------------------------------------------------- | :---------------------------------- |
| The United Manufacturing Hub MQTT broker handles... | The HiveMQ handles...               |
| To visualize data in the database...                | To visualize data in TimescaleDB... |
{{< /table >}}

### Use normal style for string and integer field values

For field values of type string or integer, use normal style without quotation marks.

{{< table caption = "Do and Don't - Use normal style for string and integer field values" >}}
| Do                                            | Don't                                           |
| :-------------------------------------------- | :---------------------------------------------- |
| Set the value of `imagePullPolicy` to Always. | Set the value of `imagePullPolicy` to "Always". |
| Set the value of `image` to nginx:1.16.       | Set the value of `image` to `nginx:1.16`.       |
| Set the value of the `replicas` field to 2.   | Set the value of the `replicas` field to `2`.   |
{{< /table >}}

## Code snippet formatting

### Don't include the command prompt

{{< table caption = "Do and Don't - Don't include the command prompt" >}}
| Do               | Don't              |
| :--------------- | :----------------- |
| kubectl get pods | $ kubectl get pods |
{{< /table >}}

### Separate commands from output

Verify that the pod is running on your chosen node:

```shell
kubectl get pods --output=wide
```

The output is similar to this:

```console
NAME     READY     STATUS    RESTARTS   AGE    IP           NODE
nginx    1/1       Running   0          13s    10.200.0.4   worker0
```

### Versioning United Manufacturing Hub examples

Code examples and configuration examples that include version information should be consistent with the accompanying text.

If the information is version specific, the United Manufacturing Hub version needs to be defined in the `prerequisites` section of the [Task template](/docs/development/contribute/documentation/style/page-content-types/#task) or the [Tutorial template](/docs/development/contribute/documentation/style/page-content-types/#tutorial). Once the page is saved, the `prerequisites` section is shown as **Before you begin**.

To specify the United Manufacturing Hub version for a task or tutorial page, include `minimum-version` in the front matter of the page.

If the example YAML is in a standalone file, find and review the topics that include it as a reference.
Verify that any topics using the standalone YAML have the appropriate version information defined.
If a stand-alone YAML file is not referenced from any topics, consider deleting it instead of updating it.

For example, if you are writing a tutorial that is relevant to United Manufacturing Hub version 0.9.11, the front-matter of your markdown file should look something like:

```yaml
---
title: <your tutorial title here>
minimum-version: 0.9.11
---
```

In code and configuration examples, do not include comments about alternative versions.
Be careful to not include incorrect statements in your examples as comments, such as:

```yaml
apiVersion: v1 # earlier versions use...
kind: Pod
...
```

## United Manufacturing Hub word list

A list of UMH-specific terms and words to be used consistently across the site.

{{< table caption = "United Manufacturing Hub.io word list" >}}
| Term                     | Usage                                                  |
| :----------------------- | :----------------------------------------------------- |
| United Manufacturing Hub | United Manufacturing Hub should always be capitalized. |
| Management Console       | Management Console should always be capitalized.       |
{{< /table >}}

## Shortcodes

Hugo [Shortcodes](https://gohugo.io/content-management/shortcodes) help create different rhetorical appeal levels.

There are multiple custom shortcodes that can be used in the United Manufacturing Hub documentation.
Refer to the [shortcode guide](/docs/development/contribute/documentation/style/hugo-shortcodes/) for more information.

## Markdown elements

### Line breaks

Use a single newline to separate block-level content like headings, lists, images, code blocks, and others. The exception is second-level headings, where it should be two newlines. Second-level headings follow the first-level (or the title) without any preceding paragraphs or texts. A two line spacing helps visualize the overall structure of content in a code editor better.

### Headings and titles {#headings}

People accessing this documentation may use a screen reader or other assistive technology (AT). [Screen readers](https://en.wikipedia.org/wiki/Screen_reader) are linear output devices, they output items on a page one at a time. If there is a lot of content on a page, you can use headings to give the page an internal structure. A good page structure helps all readers to easily navigate the page or filter topics of interest.

{{< table caption = "Do and Don't - Headings" >}}
| Do                                                                                                       | Don't                                                                                                                                                 |
| :------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------- |
| Update the title in the front matter of the page or blog post.                                           | Use first level heading, as Hugo automatically converts the title in the front matter of the page into a first-level heading.                         |
| Use ordered headings to provide a meaningful high-level outline of your content.                         | Use headings level 4 through 6, unless it is absolutely necessary. If your content is that detailed, it may need to be broken into separate articles. |
| Use pound or hash signs (`#`) for non-blog post content.                                                 | Use underlines (`---` or `===`) to designate first-level headings.                                                                                    |
| Use sentence case for headings in the page body. For example, **Change the security context**            | Use title case for headings in the page body. For example, **Change The Security Context**                                                            |
| Use title case for the page title in the front matter. For example, `title: Execute Kafka Shell Scripts` | Use sentence case for page titles in the front matter. For example, don't use `title: Execute Kafka shell scripts`                                    |
{{< /table >}}

### Paragraphs

{{< table caption = "Do and Don't - Paragraphs" >}}
| Do                                                                                                                                                                                            | Don't                                                                                                             |
| :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------------------------------------------------------------------------------------------- |
| Try to keep paragraphs under 6 sentences.                                                                                                                                                     | Indent the first paragraph with space characters. For example, ⋅⋅⋅Three spaces before a paragraph will indent it. |
| Use three hyphens (`---`) to create a horizontal rule. Use horizontal rules for breaks in paragraph content. For example, a change of scene in a story, or a shift of topic within a section. | Use horizontal rules for decoration.                                                                              |
{{< /table >}}

### Links

{{< table caption = "Do and Don't - Links" >}}
| Do                                                                                                                                                                                                                                                                                        | Don't                                                                                                                                                                                                                                          |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Write hyperlinks that give you context for the content they link to. For example: Certain ports are open on your machines. See <a href="#check-required-ports">Check required ports</a> for more details.                                                                                 | Use ambiguous terms such as "click here". For example: Certain ports are open on your machines. See <a href="#check-required-ports">here</a> for more details.                                                                                 |
| Write Markdown-style links: `[link text](URL)`. For example: `[Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/#table-captions)` and the output is [Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/#table-captions). | Write HTML-style links: `<a href="/media/examples/link-element-example.css" target="_blank">Visit our tutorial!</a>`, or create links that open in new tabs or windows. For example: `[example website](https://example.com){target="_blank"}` |
{{< /table >}}

### Lists

Group items in a list that are related to each other and need to appear in a specific order or to indicate a correlation between multiple items. When a screen reader comes across a list—whether it is an ordered or unordered list—it will be announced to the user that there is a group of list items. The user can then use the arrow keys to move up and down between the various items in the list.
Website navigation links can also be marked up as list items; after all they are nothing but a group of related links.

- End each item in a list with a period if one or more items in the list are complete sentences. For the sake of consistency, normally either all items or none should be complete sentences.

  {{< notice note >}} Ordered lists that are part of an incomplete introductory sentence can be in lowercase and punctuated as if each item was a part of the introductory sentence.{{< /notice >}}

- Use the number one (`1.`) for ordered lists.

- Use (`+`), (`*`), or (`-`) for unordered lists.

- Leave a blank line after each list.

- Indent nested lists with four spaces (for example, ⋅⋅⋅⋅).

- List items may consist of multiple paragraphs. Each subsequent paragraph in a list item must be indented by either four spaces or one tab.

### Tables

The semantic purpose of a data table is to present tabular data. Sighted users can quickly scan the table but a screen reader goes through line by line. A table caption is used to create a descriptive title for a data table. Assistive technologies (AT) use the HTML table caption element to identify the table contents to the user within the page structure.

- Add table captions using [Hugo shortcodes](/docs/development/contribute/documentation/style/hugo-shortcodes/#table-captions) for tables.

## Content best practices

This section contains suggested best practices for clear, concise, and consistent content.

### Use present tense

{{< table caption = "Do and Don't - Use present tense" >}}
| Do                           | Don't                            |
| :--------------------------- | :------------------------------- |
| This command starts a proxy. | This command will start a proxy. |
 {{< /table >}}

Exception: Use future or past tense if it is required to convey the correct
meaning.

### Use active voice

{{< table caption = "Do and Don't - Use active voice" >}}
| Do                                         | Don't                                            |
| :----------------------------------------- | :----------------------------------------------- |
| You can explore the API using a browser.   | The API can be explored using a browser.         |
| The YAML file specifies the replica count. | The replica count is specified in the YAML file. |
{{< /table >}}

Exception: Use passive voice if active voice leads to an awkward construction.

### Use simple and direct language

Use simple and direct language. Avoid using unnecessary phrases, such as saying "please."

{{< table caption = "Do and Don't - Use simple and direct language" >}}
| Do                          | Don't                                        |
| :-------------------------- | :------------------------------------------- |
| To create a ReplicaSet, ... | In order to create a ReplicaSet, ...         |
| See the configuration file. | Please see the configuration file.           |
| View the pods.              | With this next command, we'll view the pods. |
{{< /table >}}

### Address the reader as "you"

{{< table caption = "Do and Don't - Addressing the reader" >}}
| Do                                      | Don't                                   |
| :-------------------------------------- | :-------------------------------------- |
| You can create a Deployment by ...      | We'll create a Deployment by ...        |
| In the preceding output, you can see... | In the preceding output, we can see ... |
{{< /table >}}

### Avoid Latin phrases

Prefer English terms over Latin abbreviations.

{{< table caption = "Do and Don't - Avoid Latin phrases" >}}
| Do               | Don't     |
| :--------------- | :-------- |
| For example, ... | e.g., ... |
| That is, ...     | i.e., ... |
{{< /table >}}

Exception: Use "etc." for et cetera.

## Patterns to avoid

### Avoid using "we"

Using "we" in a sentence can be confusing, because the reader might not know
whether they're part of the "we" you're describing.

{{< table caption = "Do and Don't - Patterns to avoid" >}}
| Do                                                      | Don't                                           |
| :------------------------------------------------------ | :---------------------------------------------- |
| Version 1.4 includes ...                                | In version 1.4, we have added ...               |
| United Manufacturing Hub provides a new feature for ... | We provide a new feature ...                    |
| This page teaches you how to use pods.                  | In this page, we are going to learn about pods. |
{{< /table >}}

### Avoid jargon and idioms

Some readers speak English as a second language. Avoid jargon and idioms to help them understand better.

{{< table caption = "Do and Don't - Avoid jargon and idioms" >}}
| Do                    | Don't                  |
| :-------------------- | :--------------------- |
| Internally, ...       | Under the hood, ...    |
| Create a new cluster. | Turn up a new cluster. |
{{< /table >}}

### Avoid statements about the future

Avoid making promises or giving hints about the future. If you need to talk about
an alpha feature, put the text under a heading that identifies it as alpha
information.

An exception to this rule is documentation about announced deprecations
targeting removal in future versions.

### Avoid statements that will soon be out of date

Avoid words like "currently" and "new." A feature that is new today might not be
considered new in a few months.

{{< table caption = "Do and Don't - Avoid statements that will soon be out of date" >}}
| Do                                  | Don't                                   |
| :---------------------------------- | :-------------------------------------- |
| In version 1.4, ...                 | In the current version, ...             |
| The Federation feature provides ... | The new Federation feature provides ... |
{{< /table >}}

### Avoid words that assume a specific level of understanding

Avoid words such as "just", "simply", "easy", "easily", or "simple". These words do not add value.

{{< table caption = "Do and Don't - Avoid insensitive words" >}}
| Do                         | Don't                           |
| :------------------------- | :------------------------------ |
| Include one command in ... | Include just one command in ... |
| Run the container ...      | Simply run the container ...    |
| You can remove ...         | You can easily remove ...       |
| These steps ...            | These simple steps ...          |
{{< /table >}}

## {{% heading "whatsnext" %}}

- Learn about [writing a new topic](/docs/development/contribute/documentation/style/write-new-topic/).
- Learn about [using page templates](/docs/development/contribute/documentation/style/page-content-types/).
- Learn about [creating a pull request](/docs/development/contribute/new-content/add-documentation/#open-a-pr).
