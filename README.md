# zap2xml
The `zap2xml` Perl script is a command-line utility that extracts electronic program guide (EPG) data for over-the-air (OTA) or cable television from any one of several service providers, parses it, collates it, and saves it in a format compatible with various media center applications. For example, you can use `zap2xml` to download guide data from [zap2it.com](https://tvlistings.zap2it.com) in [XMLTV format](https://wiki.xmltv.org/index.php/XMLTVFormat) for free for [Jellyfin](https://jellyfin.org), instead of paying $35/yr. for [Schedules Direct](https://www.schedulesdirect.org).

> [!NOTE]
> > This repo is a fork of [shuaiscott/zap2xml](https://github.com/shuaiscott/zap2xml). Their last commit was pushed April 2021 and the maintainer will not be able to access their GitHub account [until 2025](https://github.com/shuaiscott/zap2xml/issues/8#issuecomment-1805215717). The purpose of this fork is to:
> > 1. Rebuild the container to pull in security updates since April 2021.
> > 1. Add CICD with scheduled builds to continue to pull in security updates as they come.
> > 1. Publish the container somewhere [more reliable that Docker Hub](https://blog.alexellis.io/docker-is-deleting-open-source-images).
> > 1. Consolidate community bug fixes and improvements.
> > 1. Reduce complexity.
> >
> > If you are browsing forks of [shuaiscott/zap2xml](https://github.com/shuaiscott/zap2xml) wondering which fork you should use and contribute to, if any, please consider this one.

### Index
1. [Usage](#usage)
1. [Development](#development)
    1. [Lint](#lint)
    1. [CI](#ci)
1. [See Also](#see-also)

## Usage
You will need the [docker engine](https://docs.docker.com/engine/install) installed to use this project.

Pull (download) this container from the [GitHub container registry](https://github.com/kj4ezj/zap2xml/pkgs/container/zap2xml).
```bash
docker pull ghcr.io/kj4ezj/zap2xml
```
This container is also available on [Docker Hub](https://hub.docker.com/r/kj4ezj/zap2xml).
```bash
docker pull docker.io/kj4ezj/zap2xml
```
Download guide data to a file called `tv-guide.xml` in the current folder.
```bash
docker run -v "$(pwd):/data" kj4ezj/zap2xml /bin/sh -c "/zap2xml.pl -u '$ZAP2IT_USERNAME' -p '$ZAP2IT_PASSWORD' -U -o /data/tv-guide.xml"
```
The upstream repo provided a script that wraps `zap2xml` and runs it every 12 hours. You can run it in the foreground...
```bash
docker run -v "$(pwd):/data" -e "USERNAME=$ZAP2IT_USERNAME" -e "PASSWORD=$ZAP2IT_PASSWORD" -e XMLTV_FILENAME=tv-guide.xml kj4ezj/zap2xml
```
...or the background.
```bash
docker run -d -v "$(pwd):/data" -e "USERNAME=$ZAP2IT_USERNAME" -e "PASSWORD=$ZAP2IT_PASSWORD" -e XMLTV_FILENAME=tv-guide.xml kj4ezj/zap2xml
```
The wrapper loops forever, so you will need to manually kill the container. This command kills the last container you started.
```bash
docker kill "$(docker ps | tail -1 | awk '{print $1}')"
```
For this reason and others, the wrapper will be removed in a subsequent version. If you plan to rely upon it, please pull your container by `git` tag.

## Development
Contributors need these tools installed.
- [act](https://github.com/nektos/act)
- [docker](https://docs.docker.com/engine/install)
- [git](https://git-scm.com)

Please [sign your commits](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits).

### Lint
This project uses [bashate](https://github.com/openstack/bashate) _and_ [shellcheck](https://github.com/koalaman/shellcheck) to lint BASH scripts.
```bash
.github/workflows/lint.sh
```
This script contains the specific configuration for each permutation of linter and target file.

The `dockerfile` is not yet linted.

### CI
This repo uses GitHub Actions for CI.
1. **zap2xml CI** - build and push the `zap2xml` project.
    - [Pipeline](https://github.com/kj4ezj/zap2xml/actions/workflows/ci.yml)
    - [Documentation](./.github/workflows/README.md)

The CI must pass before a pull request will be peer-reviewed.

You can run the GitHub Actions workflow(s) locally using [act](https://github.com/nektos/act).
```bash
act --artifact-server-path .github/artifacts
```
This skips the `docker tag` and `docker push` steps because those should never be run locally.

> [!IMPORTANT]
> Please make sure any pipeline changes do not break `act` compatibility.

## See Also
This list is not exhaustive, there may be other compatible consumers and providers.
- Consumers
    - [Channels](https://getchannels.com)
    - [Jellyfin](https://jellyfin.org)
        - [Adding Guide Data](https://jellyfin.org/docs/general/server/live-tv/setup-guide#adding-guide-data)
    - [NextPVR](https://www.nextpvr.com)
    - [Plex](https://www.plex.tv)
- Providers
    - [tvguide.com](https://www.tvguide.com/listings)
    - [zap2it.com](https://tvlistings.zap2it.com)
- XMLTV Project
    - [GitHub](https://github.com/XMLTV/xmltv)
    - [Homepage](https://wiki.xmltv.org/index.php/Main_Page)
    - [XMLTV Format](https://wiki.xmltv.org/index.php/XMLTVFormat) - documentation on the XMLTV file format.
- zap2xml
    - [Docker Hub](https://hub.docker.com/r/kj4ezj/zap2xml)
    - [GitHub Container Registry](https://github.com/kj4ezj/zap2xml/pkgs/container/zap2xml)
    - [shuaiscott/zap2xml](https://github.com/shuaiscott/zap2xml) - upstream repo.

***
> **_Legal Notice_**  
> This repo contains assets created in collaboration with a large language model, machine learning algorithm, or weak artificial intelligence (AI). This notice is required in some countries.
