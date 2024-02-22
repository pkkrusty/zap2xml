# zap2xml CI
This GitHub Actions workflow builds and publishes the `zap2xml` project.

### Index
1. [Triggers](#triggers)
1. [Inputs](#inputs)
1. [Steps](#steps)
1. [Outputs](#outputs)
1. [See Also](#see-also)

## Triggers
This GitHub action will run under the following circumstances:
1. When code is pushed.
1. When a pull request is opened.
1. On a workflow dispatch event, a manual CI run which can be triggered by the "Workflow Dispatch" button on the "Actions" tab of the GitHub repository, among other means.

## Inputs
This pipeline takes credentials for Docker Hub as GitHub Actions secrets.
Variable | Type | Description
--- | --- | ---
`DOCKERHUB_PASSWORD` | Secret String | Docker Hub access token with `Write` permission to the corresponding image.
`DOCKERHUB_USERNAME` | Secret String | Docker Hub username or email.

## Steps
This workflow performs the following steps on GitHub runners:
1. Attach Documentation
    1. Checkout this repo with no submodules.
    1. Attach an annotation to the GitHub Actions build summary page containing CI documentation.
1. Lint and Test jellyfin-tv-guide
    1. Checkout this repo.
    1. Install system dependencies using `.github/workflows/deps.sh`.
    1. Lint the CI code with `shellcheck` and `bashate` using `.github/workflows/lint.sh`, and check the whitespace in `zap2xml.pl`.
    1. Build docker container.
    1. Tag and push the container to Docker Hub and the GitHub Container Registry using `.github/workflows/docker.sh`.

## Outputs
There are currently no outputs of this GitHub Actions workflow, besides the exit status.

## See Also
- [Project Documentation](../../README.md)

For assistance with the CI system, please open an issue in this repo.

***
> **_Legal Notice_**  
> This document was created in collaboration with a large language model, machine learning algorithm, or weak artificial intelligence (AI). This notice is required in some countries.
