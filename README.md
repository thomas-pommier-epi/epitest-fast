## Epitest fast Docker

#### Purpose
____

It's for github actions, the real epitest-docker is very slow during the workflow setup due to its huge number of useless depedencies. This one is optimized for C Development only. There will be a future CPP dockerfile for CPP workflows in the same repo.
In short, the useless libs are removed and the build.sh only builds, nothing more.
