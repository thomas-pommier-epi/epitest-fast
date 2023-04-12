FROM fedora:36

# Notice : This is mainly for C program (non graphic).

RUN     dnf -y --refresh install            \
        --setopt=tsflags=nodocs             \
        --setopt=deltarpm=false             \
        autoconf                            \
        automake                            \
        curl.x86_64                         \
        elfutils-libelf-devel.x86_64        \
        gcc.x86_64                          \
        glibc-devel.x86_64                  \
        glibc-locale-source.x86_64          \
        glibc.x86_64                        \
        langpacks-en                        \
        make.x86_64                         \
        ncurses-devel.x86_64                \
        ncurses-libs                        \
        ncurses.x86_64                      \
        python3.x86_64                      \
        python3-devel.x86_64                \
        sudo.x86_64                         \
        systemd-devel                       \
        tcsh.x86_64                         \
        wget.x86_64                         \
    && dnf clean all -y


RUN python3 -m pip install --upgrade pip \
    && python3 -m pip install -Iv gcovr==5.2 \
    && localedef -i en_US -f UTF-8 en_US.UTF-8

RUN cd /tmp \
    && curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.1/criterion-2.4.1-linux-x86_64.tar.xz" -o /tmp/criterion-2.4.1.tar.xz \
    && tar xf criterion-2.4.1.tar.xz \
    && cp -r /tmp/criterion-2.4.1/* /usr/local/ \
    && echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf \
    && ldconfig

ENV LANG=en_US.utf8 LANGUAGE=en_US:en LC_ALL=en_US.utf8 PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

RUN cd /tmp \
    && rm -rf /tmp/* \
    && chmod 1777 /tmp

WORKDIR /usr/app
