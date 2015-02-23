PID=0x1330
SPI_FILE=../xilinx/UXN1330.spi
PY_CLASS=nitro_parts.BrooksEE.UXN1330
FX3_FIRMWARE=../firmware/uxn1330.img

include ../../../lib/Makefiles/fx3_boards.mk

.PHONY: tests

tests:
	python -m unittest -v nitro_parts.BrooksEE.UXN1330.tests
