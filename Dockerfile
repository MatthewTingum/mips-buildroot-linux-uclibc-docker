FROM matthewtingum/dockerbuild:0.2

RUN wget -P /tmp/ https://buildroot.org/downloads/buildroot-2023.02.1.tar.gz \
 && tar -xvf /tmp/buildroot-2023.02.1.tar.gz -C /tmp/

COPY .config /tmp/buildroot-2023.02.1/

RUN cd /tmp/buildroot-2023.02.1/ \
 && make sdk -j `nproc` \
 && mkdir /opt/cross \
 && tar -xvf output/images/mips-buildroot-linux-uclibc_sdk-buildroot.tar.gz -C /opt/cross \
 && cd /tmp \
 && rm buildroot-2023.02.1.tar.gz \
 && rm -r buildroot-2023.02.1

ENV PATH="/opt/cross/mips-buildroot-linux-uclibc_sdk-buildroot/bin/:$PATH"
