# This makefile just includes the common project file.  All configuration
# data is put in the config.mk file in this same directory.  The
# other makefiles include that to get their configuration information.

XML_DEPS= Cypress/fx3/fx3.xml \
		  Xilinx/Spartan/Spartan.xml \
		  Numonyx/M25P/M25P.xml

include ../../lib/Makefiles/project.mk

