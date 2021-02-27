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
verilator -Wall --cc -Irtl top.v --exe --build sim/top.cpp
./obj_dir/Vtop
```
