# Build Notes 
# Build deps: 
#  fx3 version 8bba1 
#  cyfx3sdk version 1.3.3
#  NOTE - cyfxtx in cyfx3sdk must be modified to use last 32k boot os mem for buffers.

MODULE = uxn1330
VID = 0x1fe1
PID = 0x1330
USB2_POWER = 0xFA # 500 mA
USB3_POWER = 0x58 # 704 mA
FIRMWARE_VERSION = 0x114

# the required assembly files
SOURCE += $(FX3DIR)dscr.c 
SOURCE += $(FX3DIR)error_handler.c
SOURCE += $(FX3DIR)cpu_handler.c
SOURCE += $(FX3DIR)rdwr.c
SOURCE += handlers.c
SOURCE += uxn1330_term.c
SOURCE += ../../../Microchip/M24XX/fx3/m24xx.c
SOURCE += ../../../Numonyx/M25P/fx3/m25p.c
SOURCE += ../../../Xilinx/Spartan/fx3/spartan.c
SOURCE += ../../../Xilinx/Spartan/fx3/slfifo_handler.c
SOURCE += $(FX3DIR)main.c 
SOURCE += $(FX3DIR)fx3_term.c

# add any custom debugging or cflags
#BUILD_CCFLAGS += -DFIRMWARE_DI
#BUILD_CCFLAGS += -DENABLE_LOGGING
#BUILD_CCFLAGS += -DDEBUG_RDWR
#BUILD_CCFLAGS += -DDEBUG_SLFIFO_HANDLER
#BUILD_CCFLAGS += -DDEBUG_SPARTAN
#BUILD_CCFLAGS += -DDEBUG_CPU_HANDLER
#BUILD_CCFLAGS += -DDEBUG_MAIN
#BUILD_CCFLAGS += -DDEBUG_M25P

# any custom includes
INCLUDES += -I../../../Numonyx/M25P/fx3 -I../../../Microchip/M24XX/fx3 -I../../../Xilinx/Spartan/fx3

