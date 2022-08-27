# Protocols

> NOTE: some of the protocols below use non-inclusive terminology. This guide
> reflects those terms, but the `moss` project does not condone the usage of
> non-inclusive terminology in any original work.

## Resources

- [Circuit Basics
  Tutorials](https://www.circuitbasics.com/basics-of-the-spi-communication-protocol)

## Simple Protocols

Protocols communicate using bits. In a 5V system, 0V would be a 0, and 5V would
be a 1. Bits can be sent in _parallel_, which means multiple wires each
communicating a signal at a given point in time, or _serial_, which means a
single wire communicating a signal over time.

### Controller Area Network (CAN)

### Inter-Integrated Circuit (I2C)

- Used by OLED displays, accelerometers, pressure sensors
- One-to-many and many-to-many instructor to listener relationships
  (referred to as masters and slaves)
  - Useful for connecting multiple modules to a single output, such as a
    display
- Only uses two wires
- Signals
  - **Serial Data (SDA)**: line for master and slave to send data
    (bidirectional)
  - **Serial Clock (SCL)**: clock signal (controlled by master)
- Packet Format
  - Start Condition: SDA switches from high to low before SCL switches
    high to low
  - Address Frame (7 to 10 bits): identifies the slave that the master
    wants to talk to
  - Read/Write Bit (1 bit): indicates whether the master is sending data
    (0) or receiving (1)
  - ACK/NACK Bit (1 bit): receiver indicates whether the address frame or
    data frame was received (0 - low voltage) or not (1 - stays high
    voltage)
  - Data Frame (8 bits): after addressing, an arbitrary number of data
    frames can be sent (each separated by ACK/NACK)
  - Stop Condition: SDA switched low to high before SCL switches low to
    high
- In a many-to-many setup, master needs to detect if SDA line is already in
  use by another master and wait for it to finish if so
- Pros
  - Only 2 wires
  - Supports many-to-many
  - ACK/NACK of packets
  - Less complicated hardware than UART
  - Well documented and widely used
- Cons
  - Slower than SPI
  - Data frame size limited to 8 bits
  - More complicated hardware than SPI

### Serial Peripheral Interface (SPI)

- Used by SD card readers, RFID card readers, 2.4 GHz wireless transmitters
  / receivers
- Unlike UART and I2C, which send bits in packets of a limited size, SPI can
  send bits _continuously_
- One-to-many instructor to listener relationship (referred to as master and
  slave)
- Signals
  - **Master Output Slave Input (MOSI)**: line for master to send data to
    slave, most significant bit (MSB) first
  - **Master Input Slave Output (MISO)**: line for slave to send data to
    master, least significant bit (LSB) first
  - **SCLK**: clock line
  - **Slave Select / Chip Select (SS/CS)**: line for master to select
    slave to send data to, low voltage (0) indicates that slave is
    selected
- Pros
  - Continuous data stream, no stop and start bits
  - Less complicated SS/CS compared to I2C
  - Higher data transfer rate than I2C
  - Simultaneous send (MOSI) and receive (MISO)
- Cons
  - Use four wires, compared to only two in I2C and UART
  - Data received is not acknowledged (a feature of I2C)
  - No error checking (a feature of parity bit in UART)
  - Only single master allowed

### Serial Wire Debug (SWD)

### Universal Asynchronous Receiver/Transmitter (UART)

- UART is not a protocol, but rather a _physical circuit_
- Only uses two wires
- There is no instructor / listener in UART, UARTs communicate back and
  forth with each other (bidirectional)
- A UART translates parallel data from a CPU to a serial transmission form
- _Asynchronous_ because there is no clock signal, _start_ and _stop_ bits
  are used instead
- Two communicating UARTs must operate at the same _baud rate_ (bits per
  second)
  - A slight mismatch (up to ~10% is acceptable)
  - Max baud rate: 115200
  - Typical baud rate: 9600
- Signals
  - **Tx**: sends data (output)
  - **Rx**: receives data (input)
- Packet Format
  - 1 _start bit_
    - Non-transmitting mode is to have **Tx** high, so start bit pulls
      **Tx** low for a clock cycle
  - 5 to 9 _data bits_ (only up to 8 bits if parity bit is used)
    - Data is sent with least significant bit first (LSB)
  - 0 to 1 _parity bits_
    - Describes the evenness or oddness of a number
    - Indicates whether packet has been unintentionally changed by noise
    - Sum of 1's in data packet should be even if parity bit is 0, and
      odd if parity bit is 1
  - 1 to 2 _stop bits_
    - Signal is held high for at least 2 bit periods
- Pros
  - Only uses 2 wires
  - No clock signal
  - Provides error checking (parity bit)
  - Structure of data packet can be changed with appropriate communication
  - Well documented and widely used
- Cons
  - Max data packet size is 9 bits
  - No 1-to-many relationships
  - Baud rates of sender and receiver must be aligned

## Complex Protocols

### USB

### Ethernet

### Bluetooth

### WiFi
