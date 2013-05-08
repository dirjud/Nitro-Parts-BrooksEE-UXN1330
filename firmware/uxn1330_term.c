
#include "uxn1330_term.h"
#include <cyu3types.h>
#include <cyu3error.h>
#include <cyu3gpio.h>

#include <rdwr.h>
#include <log.h>

#include "fx3_terminals.h"


extern rdwr_cmd_t gRdwrCmd;

#define VERSION_MAJOR 1
#define VERSION_MINOR 0
#define VERSION (VERSION_MAJOR<<16)|VERSION_MINOR


uint16_t uxn1330_read(CyU3PDmaBuffer_t* pBuf) {
 switch ( gRdwrCmd.header.reg_addr ) {
    case UXN1330_VERSION:
        if (gRdwrCmd.header.transfer_length == sizeof(uint32_t)) {
            uint32_t version=VERSION;
            CyU3PMemCopy( pBuf->buffer, (uint8_t*)&version, sizeof(version) );
            return 0;
        } else {
            log_error ( "Invalid transfer length: %d\n", gRdwrCmd.header.transfer_length );
        }
        break;
    case UXN1330_LP_B:
    case UXN1330_V18_EN:
        if (gRdwrCmd.header.transfer_length==2) {
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
        } else {
            log_error ( "Invalid transfer length: %d\n", gRdwrCmd.header.transfer_length );
        }
        break;
    default:
        log_info("Unhandled UXN1330 read reg addr: %d\n", gRdwrCmd.header.reg_addr );
 }
 return 1;
}

uint16_t uxn1330_write(CyU3PDmaBuffer_t* pBuf) {

 switch (gRdwrCmd.header.reg_addr ) {
    case UXN1330_LP_B:
    case UXN1330_V18_EN:
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
    default:
        log_info("Unhandled uxn1330 write addr: %d\n", gRdwrCmd.header.reg_addr);
 }

 return 1;
}

