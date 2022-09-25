# Verilator

## Resources

- [Verilator Website](https://www.veripool.org/verilator/)
- [It's Embedded: Introduction to
  Verilator](https://www.itsembedded.com/dhd/verilator_1/)

## Overview

Verilator is a tool that translates Verilog into a C++ model that can be invoked
to simulate the RTL design.

## Configuration

Verilator supports a large number of flags and configuration values. Those used
in `moss` are detailed below.

- `-Wall`: turns on all Verilator linter warnings
- `--cc`: specifies that we want C++ output
- `--exe`: specifies that we want a executable rather than just a library
- `--build`: instructs Verilator to build library or executable (calls `make` on
  the Makefiles it generates)
- `--trace`: enables waveform creation
- `-I<dir>`: add directory to the list that Verilator searches for RTL

## Data Types

Verilator defines packed data types to represent signals in a module.

`verilated.h`
```c++
// Basic types

//                   P          // Packed data of bit type (C/S/I/Q/W)
typedef vluint8_t    CData;     ///< Verilated pack data, 1-8 bits
typedef vluint16_t   SData;     ///< Verilated pack data, 9-16 bits
typedef vluint32_t   IData;     ///< Verilated pack data, 17-32 bits
typedef vluint64_t   QData;     ///< Verilated pack data, 33-64 bits
typedef vluint32_t   EData;     ///< Verilated pack element of WData array
typedef EData        WData;     ///< Verilated pack data, >64 bits, as an array
//      float        F          // No typedef needed; Verilator uses float
//      double       D          // No typedef needed; Verilator uses double
//      string       N          // No typedef needed; Verilator uses string

typedef const WData* WDataInP;  ///< Array input to a function
typedef WData* WDataOutP;  ///< Array output from a function

typedef void (*VerilatedVoidCb)(void);
```
```c++
# define VL_OUT8(name, msb,lsb)         CData name              ///< Declare output signal, 1-8 bits
# define VL_OUT16(name, msb,lsb)        SData name              ///< Declare output signal, 9-16 bits
# define VL_OUT64(name, msb,lsb)        QData name              ///< Declare output signal, 33-64bits
# define VL_OUT(name, msb,lsb)          IData name              ///< Declare output signal, 17-32 bits
# define VL_OUTW(name, msb,lsb, words)  WData name[words]       ///< Declare output signal, 65+ bits
```

For example, `moss` controls LEDs on the Arty A7 using one signal per LED. These
are defined as a `wire` with width 4 (i.e. `[3:0]led`). Verilator represents
these signals using the `CData` type, with bits in each position corresponding
to the index in the `wire`.

The variable is declared using the `VL_OUT8(name, mdb,lsb)` macro, which
instantiates a variable with name `name` and type `CData`.
