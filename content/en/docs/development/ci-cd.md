---
title: CI/CD
description: This section contains the description of the Continuous Integration and Continuous Deployment pipelines of the United Manufacturing Hub.
weight: 10
---

Continuous Integration (CI) pipelines are an essential part of the United Manufacturing Hub project. They automate the building and testing of the project's code, ensuring that it remains of high quality and stays reliable. Here's a brief overview of each pipeline:

## Build Docker Images

This pipeline builds and pushes all the Docker images for the project, tagging them using the branch name or the git tag. This way there is always a tagged version for the latest release of the UMH, as well as specific version for each branch to use for testing.

It runs on push events only when relevant files have been changed, such as the Dockerfiles or the source code.

### Maintenance

- Ensure that the Dockerfiles are updated with the latest dependencies and configurations.
- Check that the base images used in the Dockerfiles are up-to-date.

### Troubleshooting

- Check the logs to see if there are any error messages or warnings that may indicate the issue.
- The most common issue would be a building problem, in which case you need to review the code changes to investigate why the command `go build` fails.

## Codecov

This pipeline executes `go test` and uploads the results to `codecov`, to make sure that unit tests are passing and they cover most of the code.

It runs on both push and pull request events.

### Maintenance

- Ensure that new code changes are accompanied by new or updated unit tests.
- Ensure that the unit tests cover most of the code.
- Ensure that the `codecov.yml` configuration file is updated to reflect any changes in the project structure.

### Troubleshooting

- Check the logs to see if there are any error messages or warnings that may indicate the issue.

## GitGuardian Scan

This pipeline scans the code for security vulnerabilities, such as exposed secrets.

It runs on both push and pull request events.

### Maintenance

- Ensure that the `.gitguardian.yml` configuration file is updated to include new secrets and exclude false positives.

### Troubleshooting

- Check the logs to see if there are any error messages or warnings that may indicate the issue.

## Helm Checks

This pipeline runs checks on Helm configuration. It executes `helm lint` for the default `values.yaml` and for any custom values used for testing. Additionally, runs `checkov` to prevent misconfigurations and vulnerabilities, along with best practices checks.

It runs on push events only when Helm template files have been changed.

### Maintenance

- Ensure that new values files are included in the workflow as needed.
- Ensure that the `checkov` version is up-to-date.
- Ensure that the Helm charts and values files are updated with the latest dependencies and configurations.

### Troubleshooting

- Check the logs to see if there are any error messages or warnings that may indicate the issue.

## Test Deployment

This pipeline group verifies that the current changes can be successfully installed and that data flows correctly. There are two pipelines: a "tiny" version with the minimum amount of services needed to run the stack, and a "full" version with as many services as possible.

Each pipeline has two jobs. The first job installs the stacks with the current changes, and the second job tries to upgrade from the latest stable version applying the current changes.

A test is run in each workflow to verify the simulated data flow through MQTT, NodeRed, Kafka, and TimescaleDB. In the full version, an additional test for sensorconnect is run, using a mocked sensor to verify the data flow.

It runs on pull request events when the Helm configuration or the source code changes.

### Maintenance

- Ensure that the NodeRed flows are updated to reflect any changes in the data structure.
- Ensure that the queries to factoryinsight are updated to reflect any changes in the data structure.
- Ensure that the `values.yaml` files (both the default and the test version) are updated to reflect any changes in the configuration structure.
- Ensure that new tests are added for the services that do not have one.
- Ensure that new pipelines are added to test different use cases.

### Troubleshooting

- Check the logs to see if there are any error messages or warnings that may indicate the issue.
- In the workflow summary there are artifacts containing all the logs from `kubectl`.