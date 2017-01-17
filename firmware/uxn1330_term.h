
#ifndef UXN1330_TERM_H
#define UXN1330_TERM_H

#include <handlers.h>

uint16_t uxn1330_read(CyU3PDmaBuffer_t*);
uint16_t uxn1330_write(CyU3PDmaBuffer_t*);
void uxn1330_boot(uint16_t);

#define DECLARE_UXN1330_HANDLER(term) \
    DECLARE_HANDLER(&glCpuHandler,term,uxn1330_boot,0,uxn1330_read,uxn1330_write,0,0,0,0)

#endif
