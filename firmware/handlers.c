#include <cyu3system.h>
#include "handlers.h"
#include <m24xx.h>
#include <m25p.h>
#include "fx3_terminals.h"
#include <spartan.h>
#include "uxn1330_term.h"
#include <fx3_term.h>

m24xx_config_t m24_config = { .dev_addr = TERM_FX3_PROM,
			      .bit_rate = 400000,
			      .size = 17, // 128KB prom
};


io_handler_t io_handlers[] = {
  DECLARE_DUMMY_HANDLER(TERM_DUMMY_FX3),
  DECLARE_UXN1330_HANDLER(TERM_UXN1330),
  DECLARE_FX3_HANDLER(TERM_FX3),
  DECLARE_M24XX_HANDLER(TERM_FX3_PROM, &m24_config),
  DECLARE_M25P_DATA_HANDLER(TERM_FPGA_PROM_DATA),
  DECLARE_M25P_CTRL_HANDLER(TERM_FPGA_PROM_CTRL),
  DECLARE_SPARTAN_CTRL_HANDLER(TERM_FPGA_CTRL),
  DECLARE_SPARTAN_HANDLER(0),
  DECLARE_TERMINATOR
};
