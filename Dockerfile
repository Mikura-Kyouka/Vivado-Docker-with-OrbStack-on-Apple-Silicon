FROM --platform=linux/amd64 ubuntu:22.04

ARG DISPLAY
ENV DISPLAY=$DISPLAY \
    XAUTHORITY=/tmp/.Xauthority \
    QT_X11_NO_MITSHM=1

RUN sed -i "s/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list && \
    sed -i "s/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g" /etc/apt/sources.list

RUN apt update && \
    apt upgrade -y && \
    apt install -y --no-install-recommends \
    gcc-10-base glib-networking libatk-bridge2.0-0 libatk1.0-0 libatspi2.0-0 libavahi-client3 libavahi-common-data libavahi-common3 libblkid1 libbrotli1 libbsd0 libc6 libcairo-gobject2 libcairo2 libcolord2 libcom-err2 libcrypt1 libcups2 libdatrie1 libdbus-1-3 libdeflate0 libepoxy0 libexpat1 libffi7 libfontconfig1 libfreetype6 libfribidi0 libgcc-s1 libgcrypt20 libgdk-pixbuf-2.0-0 libglib2.0-0 libgmp10 libgnutls30 libgpg-error0 libgraphite2-3 libgssapi-krb5-2 libgtk-3-0 libharfbuzz0b libhogweed6 libidn2-0 libjbig0 libjson-glib-1.0-0 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 liblcms2-2 liblz4-1 liblzma5 libmd0 libmount1 libnettle8 libnsl2 libnss-nis libnss-nisplus libp11-kit0 libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpcre2-8-0 libpcre3 libpixman-1-0 libpng16-16 libproxy1v5 libpsl5 librest-0.7-0 librsvg2-2 librsvg2-common libselinux1 libsoup-gnome2.4-1 libsoup2.4-1 libsqlite3-0  libstdc++6 libsystemd0 libtasn1-6 libthai0 libtiff5 libtinfo5 libtirpc3 libudev1 libunistring2 libuuid1 libwayland-client0 libwayland-cursor0 libwayland-egl1 libx11-6 libxau6 libxcb-render0 libxcb-shm0 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxdmcp6 libxext6 libxfixes3 libxi6 libxinerama1 libxkbcommon0 libxml2 libxrandr2 libxrender1 libxtst6 libzstd1 zlib1g locales

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

ENV LD_PRELOAD="/lib/x86_64-linux-gnu/libudev.so.1 /lib/x86_64-linux-gnu/libselinux.so.1 /lib/x86_64-linux-gnu/libz.so.1"

COPY --chown=vivado:vivado *.bin /vivado/
WORKDIR /vivado

RUN chmod a+x *.bin && \
    /vivado/$(ls /vivado | grep '\.bin$' | sort -V | tail -n1)

VOLUME ["/vivado"]
CMD ["/bin/bash"]

