# Vivado

Vivado is an interactive development environment (IDE) released by Xilinx (now
AMD) that supports a wide variety of tools used to implement logic design.

## Installation

Instructions for installing Vivado and related tools can be found
[here](https://docs.xilinx.com/r/en-US/ug973-vivado-release-notes-install-license/Download-and-Installation).

## File Types

- `.edn`, `.edf`, `.edif`: Electronic Design Interchange Format (EDIF) files
  (netlist)
- `.dcp`: design checkpoint file
- `.jou`: journal file
- `.xdc`: design constraints file
- `.xpr`: project file

## Design Elements

The full list of design elements that can be found on 7 series FPGA's can be
found
[here](https://docs.xilinx.com/r/en-US/ug953-vivado-7series-libraries/Design-Elements).

## Workflow

Translating a Hardware Description Language (HDL) into a bitstream that can be
programmed on an FPGA requires a number of steps. The sequence of these steps is
referred to as the _design workflow_. A generic high-level view of FPGA design
workflows can be found
[here](https://f4pga.readthedocs.io/en/latest/flows/index.html).

### RTL Analysis

RTL analysis can take multiple forms, but typically involves some form of static
evaluation of design source files written in an HDL, such as Verilog or VHDL.
Running RTL analysis is a relatively inexpensive step that can catch syntax
errors and other programmer mistakes that may cause later, more expensive stages
to fail.

### Synthesis

This stage encompasses the process of translating RTL into a _netlist_. The
netlist describes the design elements that are used to implement the logic
described in the HDL. At this stage the netlist does not describe which specific
physical elements are used on the FPGA and how they are connected to one
another.

### Implementation

In this stage, the synthesized netlist is mapped onto the physical elements. The
definition of the available elements is provided by the description of the FPGA
that is being targeted. Implemetnation is also known as _Place and Route (PnR)_.

### Bitstream Generation

Bitstream generation consists of converting the routed netlist into a
_bitstream_ that can be used to program the device. Bitstreams can be generated
as `.bin` or `.bit` files, with the latter including an ASCII header with
information about the bitstream. These files are written to
`toolchain/vivado/boards/xc7a35ticsg324-1l/xc7a35ticsg324-1l.runs/impl_1/`.

### Programming

Once the bitstream is generated, it can be written either to flash memory or
directly to the FPGA. This is typically accomplished using a JTAG interface.

## Simulation

Simulation can be run at multiple stages in the design workflow. However, some
types of simulation are dependent on a given stage being executed. For a full
description of the various types of simulation offered in Vivado, see the
documentation
[here](https://docs.xilinx.com/r/en-US/ug900-vivado-logic-simulation/Behavioral-Simulation-at-the-Register-Transfer-Level).

- Behavioral Simulation (RTL Simulation)
    - Earliest simulation that can be performed.
    - Useful for identifying syntax issues as well as any mistakes in logic.
    - Allows for simulating individual components of the design.
- Post-Synthesis Functional Simulation
    - Validates that the design elements used to implement the logic specified
      in the HDL do so correctly.
- Post-Synthesis Timing Simulation
    - Opportunity to run timing simulation prior to routing with estimated
      timing numbers.
    - Results should be treated as basic estimates and timing simulation should
      also be performed following implementation.
- Post-Implementation Functional Simulation
    - Validates that the placement and routing of physical elements on the
      device results in accurate implementation of the specified logic.
- Post-Implementation Timing Simulation
    - The routed netlist provides the most accurate timing simulation as the
      location and routing of physical elements is known.
