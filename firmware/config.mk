# Build Notes 
# Build deps: 
#  fx3 version d8568 
#  cyfx3sdk version 1.3.3

MODULE = uxn1330
VID = 0x1fe1
PID = 0x1330
USB2_POWER = 0xFA # 500 mA
USB3_POWER = 0x58 # 704 mA
FIRMWARE_VERSION = 0x111

# the required assembly files
SOURCE += $(FX3DIR)dscr.c 
SOURCE += $(FX3DIR)error_handler.c
SOURCE += $(FX3DIR)cpu_handler.c
SOURCE += $(FX3DIR)slfifo_handler.c
SOURCE += $(FX3DIR)rdwr.c
SOURCE += handlers.c
SOURCE += uxn1330_term.c
SOURCE += ../../../Microchip/M24XX/fx3/m24xx.c
SOURCE += ../../../Numonyx/M25P/fx3/m25p.c
SOURCE += ../../../Xilinx/Spartan/fx3/spartan.c
SOURCE += $(FX3DIR)main.c 
SOURCE += $(FX3DIR)fx3_term.c

# add any custom debugging or cflags
#CCFLAGS += -DFIRMWARE_DI
#CCFLAGS += -DENABLE_LOGGING
#CCFLAGS += -DDEBUG_RDWR
#CCFLAGS += -DDEBUG_SLFIFO_HANDLER
#CCFLAGS += -DDEBUG_SPARTAN
#CCFLAGS += -DDEBUG_CPU_HANDLER
#CCFLAGS += -DDEBUG_MAIN

# any custom includes
Include += -I../../../Numonyx/M25P/fx3
