#ifndef __LOW_POWER_H__
#define __LOW_POWER_H__

#define FX3_LP_B 26

// set this to CyFalse to enable low voltage mode. Setting to CyTrue
// effectively disables low voltage mode at startup
#define LP_B_INITIAL CyTrue

#define ENTER_LOW_VOLTAGE_MODE  do { CyU3PGpioSetValue ( FX3_LP_B, LP_B_INITIAL ); } while (0)
#define ENTER_HIGH_VOLTAGE_MODE do { CyU3PGpioSetValue ( FX3_LP_B, CyTrue); } while (0)

#endif
