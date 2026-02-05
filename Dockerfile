FROM devkitpro/devkita64:20260202

RUN apt update && \
    apt install gcc python3-lz4 python3-pip automake liblz4-dev sudo -y && \
    ln -fs /usr/bin/python3 /usr/bin/python && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/* /usr/share/doc /usr/share/man

    
# # Install hactool from Git (optional)
# ENV HACTOOL_REV=1d64a83450e025622f3468c28fc4164dad2c5ef6
# RUN cd /tmp && \
#     mkdir -p /tmp/hactool && \
#     cd /tmp/hactool && \
#     git init && \
#     git remote add origin https://github.com/SciresM/hactool.git && \
#     git fetch --depth 1 origin $HACTOOL_REV && \
#     git reset --hard FETCH_HEAD && \
#     cp config.mk.template config.mk && \
#     make -j$(nproc) && \
#     cp hactool /opt/devkitpro/tools/bin/hactool && \
#     cd /tmp && \
#     rm -rf /tmp/hactool

# # Install switch-tools from Git (optional)
# ENV SWITCH_TOOLS_REV=22756068dd0ed6ff9734c59cb4f99ebd3f62555b
# RUN cd /tmp && \
#     mkdir -p /tmp/switch-tools && \
#     cd /tmp/switch-tools && \
#     git init && \
#     git remote add origin https://github.com/switchbrew/switch-tools.git && \
#     git fetch --depth 1 origin $SWITCH_TOOLS_REV && \
#     git reset --hard FETCH_HEAD && \
#     ./autogen.sh && ./configure && make -j$(nproc) && \
#     make install prefix=/opt/devkitpro/tools && \
#     cd /tmp && \
#     rm -rf /tmp/switch-tools
RUN dkp-pacman -S switch-tools hactool --noconfirm && dkp-pacman -Syu --noconfirm

# Install libnx from Git (optional)
# ENV LIBNX_REV=7644c9b26099aa2d2145bc72a21ee24190e92085
# RUN cd /tmp && \
#     mkdir -p /tmp/libnx && \
#     cd /tmp/libnx && \
#     git init && \
#     git remote add origin https://github.com/switchbrew/libnx.git && \
#     git fetch --depth 1 origin $LIBNX_REV && \
#     git reset --hard FETCH_HEAD && \
#     make -j$(nproc) && \
#     mkdir -p /opt/devkitpro/libnx && \
#     cd nx && \
#     make DESTDIR=/opt/devkitpro/libnx install && \
#     cd /tmp && \
#     rm -rf /tmp/libnx

RUN useradd -m atmosphere && \
    echo "atmosphere ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/atmosphere && \
    chmod 0440 /etc/sudoers.d/atmosphere && \
    echo "atmosphere:atmosphere" | chpasswd && \
    usermod -aG sudo atmosphere

USER atmosphere
CMD ["/bin/bash"]
