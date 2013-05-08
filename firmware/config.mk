

MODULE = uxn1330
VID = 0x1fe1
PID = 0x1330

# the required assembly files
SOURCE_ASM = $(CYFX3SDK)/firmware/common/cyfx_gcc_startup.S
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

# add any custom debugging or cflags
CCFLAGS := -DENABLE_LOGGING
CCFLAGS += -DDEBUG_SPARTAN
CCFLAGS += -DDEBUG_CPU_HANDLER

# any custom includes
Include = -I../../../Numonyx/M25P/fx3
