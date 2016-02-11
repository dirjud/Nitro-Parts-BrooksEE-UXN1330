NITRO_PARTS_DIR = ../..

# INC_PATHS specifies a space separated list of paths to the files
# that are `included in any of the verilog source files.  See also
# the SIM_LIBS variable.
INC_PATHS = $(UXN1330_INC_PATHS) \
	    rtl_auto \


# INC_FILES specifies a list of files that are included in the verilog
# and are thus dependancies of the simulation.  It is not strictly
# necessary to list all of them here, but you can list any here
# that you want to use trigger a verilator rebuild or that need
# auto generated themselves.
INC_FILES = rtl_auto/FPGATerminalInst.v     \
	    rtl_auto/DRAM_CTRLTerminalInst.v     \
	    rtl_auto/terminals_defs.v     \
	    sim/tb.cpp \
		sim/vpycallbacks.cpp \
	    sim/isim_tests.v \
	    config.mk \

# SIM_FILES is a list of simulation files that are common to all
# simulations.  Use the VERILATOR_FILES, IVERILOG_FILES, etc.
# variables to specify simulator specific files
SIM_FILES = \
	$(UXN1330_SIM_FILES) \
	$(UXN1330_DIR)/sim/UXN1330DaughterBoard.v \


# VERILATOR specific options
#VERILATOR_ARGS=-Wno-UNOPTFLAT
VERILATOR_ARGS=
VERILATOR_FILES=

# ISE_SIM specific options
ISE_SIM_ARGS = isim_tests -L unisims_ver -L secureip
ISE_SIM_FILES = sim/isim_tests.v

VSIM_TOP_MODULE = isim_tests
VSIM_SIM_FILES = sim/isim_tests.v

# SIM_DEFS specifies and `defines you want to set from the command
# line
SIM_DEFS += 

# SIM_LIBS specifies the directories for any verilog libraries whose
# files you want to auto include.  This should not be confused with
# the INC_PATHS variable.  SIM_LIBS paths are searched for modules
# that are not excility listed in the SIM_FILES or SYN_FILES list
# whereas INC_PATHS are searched for files that are `included in the
# verilog itself.
SIM_LIBS=unisims_ver secureip 

# SYN_FILES lists the files that will be synthesized
SYN_FILES = \
	$(UXN1330_SYN_FILES) \
	rtl_auto/FPGATerminal.v \
	rtl/ProjectTop.v \

# these params allow you to customize the clock speed of the dram
# The dram can operate from 125mhz to 300mhz.
# The PLL_ADV that generates the dram clock generates a 2x clock
# that is then divided by 2 to get the dram clock output.
# The multiplier you specify here is multipled 2x internally to
# calculate the 2x clock so these multipliers must generate the actual
# clock speed you wish.
#
# Constraints (ug382)
#  VCO of the PLL must be in the 400-1000mhz range.  You need to 
#  remember the internal clock 2x multiplier when considering this.
#  Result is your VCO output has to be in the 200-500mhz range. 

#  You can get results below 200mhz for the dram by using UXN1330_MEMCLK_DIV2
#  which further devides VCO after the first constraint is met.
#
#  always specify UXN1330_IFCLK_FREQ in terms of mhz in order to 
#  allow the PLL to synthesize
#
# 150mhz dram clock based on 50.4 mhz ifclk
#  UXN1330_MEMCLK_MULT=6 # 600 mhz vco / 2 (internally) = 300mhz vco 
#  UXN1330_MEMCLK_DIV=1 # leave 1 to meet vco constraint.
#  UXN1330_MEMCLK_DIV2=2 # 300 / 2 = 150mhz dram clock

# see py/dram_clock.py for easy finding values to run the dram at

# example for 221 mhz dram clock from 80.64 ifclk.
DEFS = UXN1330_MEMCLK_MULT=11 UXN1330_MEMCLK_DIV=2 UXN1330_MEMCLK_DIV2=2 UXN1330_IFCLK_FREQ=80.64

# this param can be used to to override the default drive strength. Might be necessary if low power
# mode and faster ifclock are being used.

FPGA_TO_FX3_DRIVE = 1

# CUSTOM targets should go here

# DI_FILE is used by the di.mk file
DI_FILE = terminals.py
# include di.mk to auto build the di files
include ../../../lib/Makefiles/di.mk
include ../UXN1330.mk

