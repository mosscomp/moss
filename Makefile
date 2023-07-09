# Disable builtin rules.
.SUFFIXES:

# Software
# ==========================

## Config
## =============

TOOLCHAIN=riscv64-unknown-elf-

OSDIR=os
AS=$(TOOLCHAIN)as
LD=$(TOOLCHAIN)ld
LINKER_SCRIPT=$(OSDIR)/virt.ld
SOURCES=$(wildcard $(OSDIR)/*.S)
OUTDIR=build
OBJ=$(OUTDIR)/mossos.o
BIN=$(OUTDIR)/mossos

QEMU=qemu-system-riscv64
HARTS=1

GDB=$(TOOLCHAIN)gdb
OBJDUMP=$(TOOLCHAIN)objdump

## Build
## =============

$(OUTDIR)/%.o: $(SOURCES)
	@mkdir -p $(@D)
	@$(AS) $^ -o $@

$(BIN): $(OBJ)
	@mkdir -p $(@D)
	@$(LD) -T$(LINKER_SCRIPT) $^ -o $@

build: $(BIN)

## Debug
## =============

qemu:
	@$(QEMU) -machine virt -cpu rv64 -smp $(HARTS) -s -S  -nographic -bios none -kernel $(BIN)

gdb:
	@$(GDB) $(BIN) -ex "target remote :1234"

dump:
	@$(OBJDUMP) -Dtr $(BIN)

# Hardware
# ==========================

## Simulate
## =============

RTLDIR=rtl
SIMDIR=sim
SIMOUTDIR=obj_dir
VERILATOR=verilator
GTKWAVE=gtkwave

$(SIMOUTDIR)/%.o: $(SIMDIR)/%.cpp $(RTLDIR)/%.v
	$(VERILATOR) -Wall --cc -I$(RTLDIR) --trace $*.v --exe --build $(SIMDIR)/$*.cpp

verilate: $(SIMOUTDIR)/top.o $(SIMOUTDIR)/alu.o $(SIMOUTDIR)/regfile.o

simulate.%: verilate
	@$(SIMOUTDIR)/V$*

wave.%: simulate.%
	$(GTKWAVE) obj_dir/$*.vcd
