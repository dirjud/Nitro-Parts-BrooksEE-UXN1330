
#include "uxn1330_term.h"
#include <cyu3types.h>
#include <cyu3error.h>
#include <cyu3gpio.h>
#include <cyu3i2c.h>

#include <rdwr.h>
#include <log.h>

#include "fx3_terminals.h"

#include "low_power.h"


extern rdwr_cmd_t gRdwrCmd;

#define VERSION_MAJOR 1
#define VERSION_MINOR 0
#define VERSION (VERSION_MAJOR<<16)|VERSION_MINOR

#define CHECK(pin) \
   if (ret) {\
     log_error ( "Gpio config " pin " failed %d\n", ret );\
     return;\
   }

void uxn1330_boot(uint16_t term) {

    // set gpios
    uint16_t ret;

    log_info ( "uxn1330 boot\n");
    
    CyU3PGpioSimpleConfig_t gpioConfig;
    
    ret = CyU3PDeviceGpioOverride( UXN1330_VCON_EN, CyTrue );
    CHECK("vcon en");
    ret = CyU3PDeviceGpioOverride( UXN1330_LP_B, CyTrue );
    CHECK("LP_B");    
    ret = CyU3PDeviceGpioOverride( UXN1330_V18_EN, CyTrue );
    CHECK("v18_en");

    gpioConfig.outValue    = CyFalse;
    gpioConfig.driveLowEn  = CyTrue ;
    gpioConfig.driveHighEn = CyTrue;
    gpioConfig.inputEn     = CyFalse;
    gpioConfig.intrMode    = CY_U3P_GPIO_NO_INTR;

    ret = CyU3PGpioSetSimpleConfig ( UXN1330_VCON_EN, &gpioConfig );
    CHECK("vcon en set");

    gpioConfig.outValue = CyTrue; 
    ret = CyU3PGpioSetSimpleConfig ( UXN1330_V18_EN, &gpioConfig );
    CHECK("V18_en set");

    gpioConfig.outValue = LP_B_INITIAL;
    ret = CyU3PGpioSetSimpleConfig ( UXN1330_LP_B, &gpioConfig );
    CHECK("lp_b set");

}

uint16_t rdwr_vcon_pot(uint8_t *val, CyBool_t write) {
    uint16_t status;
    CyU3PI2cPreamble_t preamble;

    preamble.length    = 1;
    uint8_t addr = UXN1330_VCON_POT;
    if (!write) {
        addr |= 1; // read
    }
    preamble.buffer[0] = addr;
    preamble.ctrlMask  = 0x0000;

    if (write) {
        status = CyU3PI2cTransmitBytes(&preamble, val, 1, 1);
    } else {
        status = CyU3PI2cReceiveBytes(&preamble, val, 1, 1);
    }
    if(status) {
        log_debug ( "vcon_pot CyU3PI2c status: %d\n", status );
        return status;

        /* Wait for the write to complete. */
        preamble.length = 1;
        status = CyU3PI2cWaitForAck(&preamble, 200);
        if(status) {
          log_error( "CyU3PI2cWaitForAck fail %d\n", status );
          return status;
        }
    }

    return 0;
}


uint16_t uxn1330_read(CyU3PDmaBuffer_t* pBuf) {
 memset(pBuf->buffer,0,gRdwrCmd.header.transfer_length);
 switch ( gRdwrCmd.header.reg_addr ) {
    case UXN1330_VERSION:
        {
            uint32_t version=VERSION;
            CyU3PMemCopy( pBuf->buffer, (uint8_t*)&version, sizeof(version) );
            return 0;
        }
    case UXN1330_LP_B:
    case UXN1330_V18_EN:
    case UXN1330_VCON_EN:
        { 
            CyBool_t val;
            CyU3PReturnStatus_t ret;
            ret=CyU3PGpioGetValue( gRdwrCmd.header.reg_addr, &val );
            log_debug ( "gpio pin %d val: %d\n", gRdwrCmd.header.reg_addr, val );
            if (ret == CY_U3P_SUCCESS) {
                pBuf->buffer[0] = val; 
                pBuf->buffer[1] = 0;
                return 0;
            } else {
                log_error ( "gpio read failed: %d\n", ret );
            }
        }
        break;
    case UXN1330_VCON_POT:
        {
            uint8_t val;
            uint16_t ret=rdwr_vcon_pot(&val,CyFalse);
            if (ret == CY_U3P_SUCCESS) {
                pBuf->buffer[0] = val;
                pBuf->buffer[1] = 0;
                return 0;
            }
            return ret;
        }
        break;
    default:
        log_info("Unhandled UXN1330 read reg addr: %d\n", gRdwrCmd.header.reg_addr );
 }
 return 1;
}


uint16_t uxn1330_write(CyU3PDmaBuffer_t* pBuf) {
 log_debug ( "uxn1330 write addr %02x\n", gRdwrCmd.header.reg_addr );
 switch (gRdwrCmd.header.reg_addr ) {
    case UXN1330_LP_B:
    case UXN1330_V18_EN:
    case UXN1330_VCON_EN:
        {
            CyBool_t val = pBuf->buffer[0] ? CyTrue : CyFalse;
            CyU3PReturnStatus_t ret;
            ret=CyU3PGpioSetValue( gRdwrCmd.header.reg_addr, val );
            if (ret == CY_U3P_SUCCESS) {
                return 0;
            } else {
                log_error ( "gpio write failed: %d\n", ret );
            }
        }
        break;
    case UXN1330_VCON_POT:
        {
            uint8_t val=pBuf->buffer[0]; 
            return rdwr_vcon_pot(&val, CyTrue);
        }
        break;
    default:
        log_info("Unhandled uxn1330 write addr: %d\n", gRdwrCmd.header.reg_addr);
 }

 return 1;
}

