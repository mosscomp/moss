# Contributing to Moss

If you are interested in contributing to the Moss Computer Project, you are
welcome here regardless of background or experience. Please feel free to
contribute to this documentation if your own contributing experience yields tips
that would be useful for others. 

## Testing and Simulation

The following sections describe testing that is performed on every commit to
`moss`.

### RTL (Register-Transfer Level)

All RTL is simulated using [Verilator](https://github.com/verilator/verilator).
Simulation can be run with the following commands:

```
verilator -Wall --cc -Irtl --trace top.v --exe --build sim/top.cpp
./obj_dir/Vtop
```

## Emulation

The following steps can be used to setup and use [QEMU](https://www.qemu.org/)
for emulation.

> Tested on Ubuntu 20.04

```
sudo apt install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev \
                 gawk build-essential bison flex texinfo gperf libtool patchutils bc \
                 zlib1g-dev libexpat-dev git ninja-build libglib2.0-dev libpixman-1-dev
```

```
git clone --depth 1 --branch v5.2.0 https://github.com/qemu/qemu
```

```
cd qemu
./configure --target-list=riscv64-softmmu
make -j $(nproc)
sudo make install
```

After completing the installation steps, you should see output that matches the
following:

```
$ qemu-system-riscv64 --version
QEMU emulator version 5.2.0 (v5.2.0)
Copyright (c) 2003-2020 Fabrice Bellard and the QEMU Project developers
```
