FROM fedora:38

ENV install='dnf -y --refresh install --setopt=tsflags=nodocs --setopt=deltarpm=false'
RUN     $install                            \
        curl.x86_64                         \
        diffutils.x86_64                    \
        elfutils-libelf-devel.x86_64        \
        glibc-locale-source.x86_64          \
        langpacks-en                        \
        make.x86_64                         \
        python3.x86_64                      \
        python3-devel.x86_64                \
        xz.x86_64 && dnf clean all -y

# Gcovr for unit tests
RUN python3 -m pip install --upgrade pip --no-cache-dir \
    && python3 -m pip install -Iv gcovr==5.2 --no-cache-dir \
    && localedef -i en_US -f UTF-8 en_US.UTF-8

# Criterion
RUN cd /tmp \
    && curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.1/criterion-2.4.1-linux-x86_64.tar.xz" -o /tmp/criterion-2.4.1.tar.xz \
    && tar xf /tmp/criterion-2.4.1.tar.xz \
    && rm -f /tmp/criterion-2.4.1.tar.xz \
    && cp -r /tmp/criterion-2.4.1/* /usr/local/ \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
    && ldconfig

ARG c="y"
RUN if [[ -n "$c" ]]; then                  \
        $install                            \
        gcc.x86_64                          \
        glibc-devel.x86_64                  \
        glibc.x86_64                        \
        libuuid-devel.x86_64                \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        tcsh.x86_64;                        \
        dnf clean all -y; fi

ARG cgraphic
RUN if [[ -n "$cgraphic" ]]; then           \
        $install                            \
        CSFML.x86_64                        \
        CSFML-devel.x86_64;                 \
        dnf clean all -y; fi

ARG cpp
RUN if [[ -n "$cpp" ]]; then                \
        $install                            \
        gcc-c++.x86_64;                     \
        dnf clean all -y; fi

ARG cppgraphic
RUN if [[ -n "$cppgraphic" ]]; then         \
        $install                            \
        SDL2                                \
        SDL2-devel.x86_64                   \
        SDL2-static.x86_64                  \
        SDL2_image.x86_64                   \
        SDL2_image-devel.x86_64             \
        SDL2_ttf                            \
        SDL2_ttf-devel.x86_64               \
        SDL2_mixer                          \
        SDL2_mixer-devel.x86_64             \
        SDL2_gfx                            \
        SDL2_gfx-devel.x86_64               \
        libcaca.x86_64                      \
        libcaca-devel.x86_64                \
        SFML.x86_64                         \
        SFML-devel.x86_64;                  \
        dnf clean all -y; fi

ARG asm
RUN if [[ -n "$asm" ]]; then                \
        $install                            \
        nasm.x86_64;                        \
        dnf clean all -y; fi

# The installation is kinf of hacky, just want stack to download the specific ghc for that resolver version.
# stack build will fail, however the correct ghc version is installed.
ARG haskell
ENV STACK_RESOLVER="lts-20.11"
RUN if [[ -n "$haskell" ]]; then                            \
        $install stack                                      \
        && cd /tmp                                          \
        && mkdir stack                                      \
        && cd stack                                         \
        && stack init --resolver $STACK_RESOLVER            \
        && stack build                                      \
        ; cd ..                                             \
        && rm -rf stack                                     \
        && dnf clean all -y; fi

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

RUN cd /tmp \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp

WORKDIR /usr/app
