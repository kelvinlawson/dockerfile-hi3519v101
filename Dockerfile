FROM ubuntu:12.04

# Install pre-requisites
RUN apt-get update && apt-get install -y bzip2 build-essential libc6-dev-i386 ia32-libs lib32z1-dev libncurses5 libncurses5-dev u-boot-tools vim squashfs-tools gettext git zip subversion

# Add local files to the container
COPY toolchains /tmp/toolchains

# Run the install scripts for each version of the toolchain
WORKDIR "/tmp/toolchains/arm-hisiv500-linux"
RUN chmod +x arm-hisiv500-linux.install
RUN ./arm-hisiv500-linux.install
WORKDIR "/tmp/toolchains/arm-hisiv600-linux"
RUN chmod +x arm-hisiv600-linux.install
RUN ./arm-hisiv600-linux.install
RUN rm -rf /tmp/toolchains

# Add toolchains to the PATH
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin
ENV PATH $PATH:/opt/hisi-linux/x86-arm/arm-hisiv600-linux/target/bin

# Clean up
RUN apt-get -y clean
