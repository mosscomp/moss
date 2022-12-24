# Terms

The following terms are used throughout the `moss` documentation and are helpful
to understand when working on the project. This is a non-comprehensive living
document that will evolve over time.

**Table of Contents**
- [Computer Architecture](#computer-architecture)
    - [Processor Design](#processor-design)
- [Hardware Description Languages](#hardware-description-languages)
- [Logic Design](#logic-design)

## Computer Architecture

- **Read-Only Memory (ROM)**: general term for non-volatile memory that is
typically only read, or written infrequently. Includes PROM, EPROM, and EEPROM.
- **Programmable Read-Only Memory (PROM)**: non-volatile memory that can be
programmed once, then only read.
- **Erasable Programmable Read-Only Memory (EPROM)**: non-volatile memory that
can be reprogrammed using ultraviolet light.
- **Electronically Erasable Programmable Read-Only Memory (EEPROM)**:
non-volatile memory that can be reprogrammed using digital signals.
- **Bus**: a collection of wires treated as a single signal.

### Processor Design

- **Arithmetic Logic Unit (ALU)**: the unit in a processor that carries out
  arithmetic operation on integer operands.
- **Clock Cycles per Instructions (CPI)**: number of clock cycles it takes to
move an instruction through the pipeline. Inverse of IPC.
- **Instructions per Clock Cycle (IPC)**: number of instructions processed in a
single clock cycle.
- **Datapath**: all elements in a processor that data actually passes through.
Examples include memory, register file, and ALU.
- **Instruction Level Parallelism (ILP)**: processing instructions that are not
dependent on each other in parallel. It can be exploited via:
    - Adding more stages to the pipeline.
    - Replicating components in the pipeline (_Multiple Issue_).
- **Multiple Issue**: replicate components in processor in order to process
multiple instructions at the same time. This allows the CPI < 1 or the IPC > 1. 
- **Static Multiple Issue**: also referred to as _Very Long Instruction Word
(VLIW)_ because instructions that can be issued together are put into an
_Instruction Packet_ by the compiler.
- **Dynamic Multiple Issue**: the processor decides which instructions can be
issued in parallel. The compiler can help out to make this easier, but the
processor _guarantees_ that the instructions will be executed correctly. This is
not necessarily true for static multiple issue processors when moving code
between processors (i.e. would require recompilation).

## Hardware Description Languages

- **Structural Modelling**: describes a system in terms of the literal components.
Typically used for datapath and ALU.
- **Behavioral Modelling**: describes a system in terms of how it behaves.
Typically used for control elements.

## Logic Design

- **Asserted**: a digital signal equal to 1.
- **Deasserted**: a digital signal equal to 0.
- **Combinational Logic**: a circuit in which outputs are only determined by the
inputs.
- **Sequential Logic**: a circuit in which outputs are determined by inputs _and_
previous state.
- **Gate**: the lowest-level logic element. Common gates include `AND` (`*`), `OR`
(`+`), `NAND`, `NOR`.
- **Universal Gate**: a gate that can, on its own, be used to construct any logic.
Includes `NAND` and `NOR`.
