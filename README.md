## Epitest fast Docker

#### Purpose
____

In short, unnecessary libraries have been removed from the OG epitest container for faster pull speed.

The original epitest-docker image is very slow during the workflow setup due to its large number of unnecessary dependencies. This version is optimized for C/C++ development only (without graphic libraries).
