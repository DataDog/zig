FROM ubuntu:18.04

RUN apt update && apt install -y \
    lsb-release wget software-properties-common gnupg \
    cmake build-essential wget

RUN wget -O llvm.tar.xz https://github.com/llvm/llvm-project/releases/download/llvmorg-16.0.0/clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04.tar.xz
RUN tar xvf llvm.tar.xz

RUN wget -O zig.tar.xz https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.4406+d370005d3.tar.xz
RUN tar xvf zig.tar.xz
RUN chmod +x /zig-linux-x86_64-0.11.0-dev.4406+d370005d3/zig
RUN ln -s /zig-linux-x86_64-0.11.0-dev.4406+d370005d3/zig /usr/local/bin/zig
COPY . src
WORKDIR src

RUN zig build -p stage3 -Dstatic-llvm --zig-lib-dir lib --search-prefix clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/llvm-mc
