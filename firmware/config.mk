

MODULE = uxn1330
VID = 0x1fe1
PID = 0x1330

# the required assembly files
SOURCE_ASM = $(CYFX3SDK)/firmware/common/cyfx_gcc_startup.S
SOURCE  = $(FX3DIR)cyfxtx.c
SOURCE += $(FX3DIR)dscr.c 
SOURCE += $(FX3DIR)error_handler.c
SOURCE += $(FX3DIR)cpu_handler.c
SOURCE += $(FX3DIR)slfifo_handler.c
SOURCE += $(FX3DIR)rdwr.c
SOURCE += handlers.c
SOURCE += ../../../Microchip/M24XX/fx3/m24xx.c
SOURCE += ../../../Numonyx/M25P/fx3/m25p.c
SOURCE += ../../../Xilinx/Spartan/fx3/spartan.c
SOURCE += $(FX3DIR)main.c 

# add any custom debugging or cflags
CCFLAGS := -DDEBUG_M25P

# any custom includes
Include = -I../../../Numonyx/M25P/fx3
