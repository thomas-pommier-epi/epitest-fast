#!/bin/bash

if [ "$EUID" -ne 0 ] && ! id -nG "$USER" | grep -qw "docker"; then
    echo "[ERROR] : You ($USER) must be in the docker group."
    echo "          Here's the command :"
    echo "          sudo usermod -a -G docker $USER"
    echo "          After this, log out or reboot."
    exit 1
fi

confirm() {
    if [[ $SKIP_CONFIRM -eq 1 ]]; then
        return 0
    fi

    read -r -p "$1 [Y/n] " response
    case "$response" in
        [yY][eE][sS]|[yY]|"")
            true
            ;;
        *)
            false
            ;;
    esac
}

FEDORA_VERSION=38
SKIP_PULL=0
SKIP_CONFIRM=0

if [[ $SKIP_PULL -ne 1 ]]; then
    echo Pulling Fedora v$FEDORA_VERSION...
    docker pull fedora:$FEDORA_VERSION
fi

# latest is "c without graphic libs"
confirm "Do you want to build 'C without graphic libs' ? :" && \
docker build -t thomas-pommier-epi/epitest-fast:latest .

confirm "Do you want to build 'C WITH graphic libs' ? :" && \
docker build --build-arg cgraphic=y -t thomas-pommier-epi/epitest-fast:cgraphic .

# Prompt and execute the second docker build command
confirm "Do you want to build 'CPP without graphic libs' ? :" && \
docker build --build-arg cpp=y -t thomas-pommier-epi/epitest-fast:cpp .

# Prompt and execute the third docker build command
confirm "Do you want to build 'CPP WITH graphic libs' ? :" && \
docker build --build-arg cpp=y --build-arg cppgraphic=y -t thomas-pommier-epi/epitest-fast:cppgraphic .

confirm "Do you want to build 'ASM' ? :" && \
docker build --build-arg asm=y -t thomas-pommier-epi/epitest-fast:asm .

confirm "Do you want to build 'Haskell (without C libs)' ? :" && \
docker build --build-arg haskell=y --build-arg c='' -t thomas-pommier-epi/epitest-fast:haskell .

echo "Done building."
