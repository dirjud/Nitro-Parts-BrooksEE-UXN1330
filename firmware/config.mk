# Build Notes 
# Build deps: 
#  fx3 version 44c358
#  cyfx3sdk version 1.2.3
#    custom mods to 1.2.3:
#      used firmware/common directory from 1.3.1 sdk to get updated build system
#      modified fx3_build_common.mk to not link to the 1.3.1 cyu3sport.a which 
#      didn't exist in 1.2.3
#    Reasons
#      * Updating to 1.3.1 causes some devices to have lots of transfer errors
#      (phy/link) and/or not be able to enumerate at all.  No solution for this
#      yet. Not yet sure why the sdk version matters.
#      * 1.2.3 build system doesn't have support for 256k part. Device wasn't 
#      always working correctly (example make fx3) when built without altering 
#      using the updated common dir.

MODULE = uxn1330
VID = 0x1fe1
PID = 0x1330
USB2_POWER = 0xFA # 500 mA
USB3_POWER = 0x58 # 704 mA
FIRMWARE_VERSION = 0x106

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
#CCFLAGS := -DENABLE_LOGGING
#CCFLAGS += -DDEBUG_SPARTAN
#CCFLAGS += -DDEBUG_CPU_HANDLER
#CCFLAGS += -DDEBUG_MAIN

# any custom includes
Include += -I../../../Numonyx/M25P/fx3
