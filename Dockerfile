FROM ubuntu:22.04

RUN apt update && apt install -y \
    lsb-release wget software-properties-common gnupg \
    cmake build-essential wget

RUN wget -O llvm.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-17.0.6/clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04.tar.xz
RUN tar xvf llvm.tar.xz
WORKDIR clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04
RUN cp -r bin/* /usr/bin
RUN cp -r include/* /usr/include
RUN cp -r share/* /usr/share
RUN mkdir /usr/libexec && cp -r libexec/* /usr/libexec

WORKDIR /
COPY . src
<<<<<<< Updated upstream
WORKDIR src

RUN zig build -p stage3 -Dstatic-llvm --zig-lib-dir lib --search-prefix clang+llvm-17.0.6-x86_64-linux-gnu-ubuntu-22.04/bin/llvm-mc
=======
ENTRYPOINT ["bash", "-c", "cd /build && cmake /src"]
>>>>>>> Stashed changes
