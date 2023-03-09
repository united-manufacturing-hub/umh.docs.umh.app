---
title: "Minio"
content_type: microservices
description: |
    The technical documentation of the minio microservice,
    which provides a S3 compatible object storage.
weight: 0
---

<!-- overview -->

{{< notice warning >}}
This microservice is still in development and is not considered stable for production use
{{< /notice >}}

Minio is a microservice responsible for providing a S3 compatible object storage.
It is used to store the data from the
[kafka-to-blob](/docs/architecture/microservices/community/kafka-to-blob/) microservice.

## {{% heading "howitworks" %}}

For more information, refer to the
[official documentation](https://min.io/docs/minio/kubernetes/upstream/index.html?ref=docs-redirect).

<!-- body -->

## {{% heading "configuration" %}}

You shouldn't need to configure minio manually, as it's configured
automatically when the cluster is deployed. However, if you need to change the
configuration, you can do it by editing the `minio` section of the Helm
chart values file.
