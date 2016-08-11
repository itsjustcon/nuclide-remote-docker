# nuclide-remote-docker

A containerized version of the [Nuclide Remote Development](https://nuclide.io/docs/features/remote/) package.

### Quick Start (run locally)

```
docker run --rm -p 2222:22 -p 9090:9090 itsjustcon/nuclide-remote-docker
```
...then test your SSH connection:
```
ssh root@127.0.0.1 -p 2222
```
the default password is `admin`
