NITRO_PARTS_DIR ?= ../..

UXN1330_DIR = $(NITRO_PARTS_DIR)/BrooksEE/UXN1330

UXN1330_INC_PATHS = $(UXN1330_DIR)/sim/ddr2 \
                    $(NITRO_PARTS_DIR)/lib/xilinx \

UXN1330_SIM_FILES = \
	$(UXN1330_DIR)/sim/UXN1330_tb.v \
	$(NITRO_PARTS_DIR)/lib/HostInterface/models/fx3.v \

ifeq (,$(findstring DISABLE_SDRAM, $(DEFS)))
UXN1330_SIM_FILES += \
	$(UXN1330_DIR)/sim/ddr2/ddr2_model_c3.v
endif	

# extra ../ because sim is executed from sim dir
VERILATOR_CPPFLAGS += -I$(abspath ../$(UXN1330_DIR)/sim)
VERILATOR_CPP_FILE = ../$(UXN1330_DIR)/sim/tb.cpp ../$(UXN1330_DIR)/sim/vpycallbacks.cpp

SIM_DEFS += x512Mb sg25E x16 IMAGER_CALLBACKS SIM

UXN1330_SYN_FILES = \
	$(UXN1330_DIR)/rtl/UXN1330.v \
	$(NITRO_PARTS_DIR)/lib/HostInterface/rtl/Fx3HostInterface.v \


ifeq (,$(findstring DISABLE_SDRAM, $(DEFS)))
UXN1330_SYN_FILES += \
	$(UXN1330_DIR)/rtl/ddr2/mig_39.v \
	$(UXN1330_DIR)/rtl/ddr2/infrastructure.v \
	$(UXN1330_DIR)/rtl/ddr2/memc_wrapper.v \
	$(UXN1330_DIR)/rtl/ddr2/mcb_ui_top.v \
	$(UXN1330_DIR)/rtl/ddr2/mcb_raw_wrapper.v \
	$(UXN1330_DIR)/rtl/ddr2/mcb_soft_calibration_top.v \
	$(UXN1330_DIR)/rtl/ddr2/mcb_soft_calibration.v \
	$(UXN1330_DIR)/rtl/ddr2/iodrp_controller.v \
	$(UXN1330_DIR)/rtl/ddr2/iodrp_mcb_controller.v \
	rtl_auto/DRAM_CTRLTerminal.v \
	$(NITRO_PARTS_DIR)/Xilinx/Spartan/rtl/di2mig.v

UCF_DRAM =

else

UCF_DRAM = \#

endif

SIM_TOP_MODULE=UXN1330_tb
FPGA_TOP = UXN1330
FPGA_PART = xc6slx16-csg324-2
FPGA_ARCH = spartan6
UCF_FILES += $(UXN1330_DIR)/xilinx/UXN1330.ucf
SPI_PROM_SIZE =  524288

# target when xilinx is the builder to generate a ucf file with the right timing constraint
# for the if clock.
# if you want to use something other than the default 50.4, you should specify
# UXN1330_IFCLK_FREQ=xx.yy in your DEPS variable.
../$(UXN1330_DIR)/xilinx/UXN1330.ucf: ../$(UXN1330_DIR)/xilinx/UXN1330.ucf.in ../config.mk 
	sed -e "s/IFCLKFREQ/`python ../$(UXN1330_DIR)/xilinx/ifclock.py $(DEFS)`/" $< > $@ 
	sed -i -e "s/<DISABLE_SDRAM>/$(UCF_DRAM)/" $@


