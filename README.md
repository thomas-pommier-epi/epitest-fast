# LIGHTWEIGHT TEST CONTAINERS FOR EPITECH PROJECTS
---
 Docker containers are for your Epitech projects, allowing you to test your program via GitHub Actions. The original `epitest-docker` image is very slow during the workflow setup due to its large number of unnecessary dependencies.

The repository contains multiple package versions you can download:

- `latest`: C WITHOUT graphic libraries (ncurse / tcsh are included though)
- `cgraphic`: C with graphic libraries (CSFML)
- `cpp`: C++ WITHOUT graphic libraries
- `cppgraphic`: C++ with graphic libraries (SFML, SDL2, LIBCACA)
- `asm`: C with NASM
- `haskell`: Haskell libraries without C libraries

So the URL to pull looks like this : `ghcr.io/thomas-pommier-epi/epitest-fast:${version}`
For example, here's the URL to download the cppgraphic version package : `ghcr.io/thomas-pommier-epi/epitest-fast:cppgraphic`

All these packages contain Criterion and Gcovr for unit testing.

Here's a time comparison when pulling an image for a C project without graphic libraries:
- epitest: ~2m 30s
- epitest-fast: ~30s

For those interested in integrating a push checker via GitHub Actions in your Epitech projects, there is a file called "push_check.yml" in the root of this repository. Place it in the folder `(root of your epitech repo)/.github/workflows` and when you push, the GitHub action will trigger automatically and run your tests.
Of course, don't forget to modify the values indicated in the TODO comments.
