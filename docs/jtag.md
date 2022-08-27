# Joint Test Action Group (JTAG)

## Resources

- [XJTAG - What is JTAG and How Can I Make Use of
  It?](https://www.xjtag.com/about-jtag/what-is-jtag/)
- [XJTAG - A Technical Overview of
  JTAG](https://www.xjtag.com/about-jtag/jtag-a-technical-overview/)
- [FPGA4Fun - What is JTAG?](https://www.fpga4fun.com/JTAG1.html)
- [Introduction to JTAG and the Test Access Port
  (TAP)](https://www.allaboutcircuits.com/technical-articles/introduction-to-jtag-test-access-port-tap/)
- [The Test Access Port (TAP) State
  Machine](https://www.allaboutcircuits.com/technical-articles/jtag-test-access-port-tap-state-machine/)
- [Black Magic Probe source
  code](https://github.com/blackmagic-debug/blackmagic)
- [Wikipedia - JTAG](https://en.wikipedia.org/wiki/JTAG)
- [RISC-V Debug
  Specification](https://riscv.org/wp-content/uploads/2019/03/riscv-debug-release.pdf)

## Notes

- Used for debugging, programming, and testing
- Gives you the ability to write 1's and 0's directly to chip pins
- 4 pins, plus 1
  - 4 standard pins, 1 optional additional pin
  - These 4+ pins are referred to as a **Test Action Port (TAP)**
  - Codified in [IEEE 1491.1](https://grouper.ieee.org/groups/1149/1/)
- JTAG is _NOT_
  - The name of a specific device
  - The name of a piece of software
  - The name of a protocol
  - The name of a kind of connector
- Signals
  - **Test Clock (TCK)**: TAP controller accepts speed from external device
  - **Test Mode Select (TMS)**: control signal for JTAG
  - **Test Data-In (TDI)**: 1's and 0's to be sent to the chip, protocol is left
    to the implementation
  - **Test Data-Out (TDO)**: 1's and 0's coming back from the chip, protocol is
    left to the implementation
  - (Optional) **Test Reset (TRST)**: resets JTAG to known good state, optional
    because holding TMS at 1 (high) for five clock cycles also essentially
    performs reset (progresses all the way through state machine)
- The presence of JTAG signal lines indicates the ability to control the JTAG
  _state machine_, which is also defined in the IEEE standard
- Instruction Registers
  - **Instruction Register**: holds the current instruction, which informs how
    to pass data from the data registers.
- Data Registers
  - **Boundary Scan Register (BSR)**: main register used to move data between
    pins
  - **BYPASS**: allows incoming data to be passed without modification to output
    (used when debugger is not targeting this specific TAP)
  - **IDCODE**: contains information about the specific device 

> You can think of the IR as an index that selects which TDR to place between
> TDI and TDO. _- Verneri Hirvonen_

- The **Boundary Scan Description Language (BSDL)** is used to define JTAG
  configuration on specific devices

## Use Cases

JTAG was originally created for boundary testing, but has evolved to support
other use cases as well.

### Boundary Scan

Boundary scan a process of testing that individual IC's in a larger system are
wired together correctly. It generally consists of verifying that sending a
signal from a port on one IC results in that same signal being received on
another. It bypasses the logic implemented in the IC's under test.

### Software Debug

JTAG can be used via software debuggers (e.g. GDB) to step through instructions
and examine the contents of registers and memory.

### In-System Programming (ISP)

Because JTAG enables writing data to memory, it can be used to program devices
directly, or program flash memory through a debug-enabled device.
