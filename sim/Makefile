# Variables
IVERILOG = iverilog
VVP = vvp
GTKWAVE = gtkwave
SIM_DIR = sim
OUTPUT = cordic
VCD_FILE = cordic_wave.vcd
TEXT_OUTPUT = cordic_tb.txt
RTL_DIR = ../rtl
DV_DIR = ../dv

# Source files
RTL_SOURCES =  $(RTL_DIR)/cordic.sv \
	       $(RTL_DIR)/comparator32b.sv \
               $(RTL_DIR)/fpu.sv \
               $(RTL_DIR)/fullAdder32b.sv \
               $(RTL_DIR)/multiply32x32.sv \

DV_SOURCES = $(DV_DIR)/cordic_tb.sv

# Default target
all: build run

# Build, run and create wave
all_wave: build run wave

# Build target
build: $(OUTPUT)

# Rule to compile the Verilog sources
$(OUTPUT): $(RTL_SOURCES) $(DV_SOURCES)
	$(IVERILOG) -o $@ $^ -s cordic_tb -g2005-sv

# Run target - Xuất kết quả ra file alu_tb.txt
run: build
	$(VVP) $(OUTPUT) | tee $(TEXT_OUTPUT)

# Wave target
wave: $(VCD_FILE)
	$(GTKWAVE) $(VCD_FILE)

# Clean up
clean:
	rm -f $(OUTPUT) $(VCD_FILE) $(TEXT_OUTPUT)

# Help
help:
	@echo " make build      : build the design"
	@echo " make run        : run simulation and save output to alu_tb.txt"
	@echo " make wave       : open waveform"
	@echo " make all        : build and run simulation"
	@echo " make all_wave   : build, run simulation and open waveform"
	@echo " make clean      : remove simulation files"

