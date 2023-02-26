# AOSP-Build

This repository contains a Docker image to compile AOSP (Android Open Source Project) Roms.

> All dependencies on the image will remain up to date as build workflow runs every day at 10:00 UTC.

## Pulling the Docker image

The aosp-build Docker image can be pulled from both ghcr.io and Docker Hub.

### GitHub Container Registry (`ghcr.io`):

```sh
docker pull ghcr.io/rabilrbl/aosp-build:latest
```

### Docker Hub:

```sh
docker pull rabilrbl/aosp-build:latest
```

## Building the Docker image

The aosp-build Docker image can be built from the Dockerfile in this repository.

```sh
docker build -t aosp-build .
```
All build arguments specified below are optional. 

### Build arguments
- `GIT_NAME`: Name to use for git commits. Default: `AospB`
- `GIT_EMAIL`: Email to use for git commits. Default: `20230226+aospb@users.noreply.github.com`
- `PULL_REBASE`: Perform rebase instead of merge when pulling. Default: `true`

You can pass build arguments to the build command like this:

```sh
docker build -t aosp-build --build-arg GIT_NAME="John Doe" --build-arg GIT_EMAIL="john@doe.com" .
```
## Tags

The aosp-build Docker image is tagged with all available branches in this repository. The `latest` tag is the default branch.

### Using a specific tag or branch

```sh
docker pull ghcr.io/rabilrbl/aosp-build:main
```

---

Please note that the Docker image is built on top of the [Ubuntu latest](https://hub.docker.com/_/ubuntu) image.