
#ifndef UXN1330_TERM_H
#define UXN1330_TERM_H

#include <handlers.h>

uint16_t uxn1330_read(CyU3PDmaBuffer_t*);
uint16_t uxn1330_write(CyU3PDmaBuffer_t*);

#define DECLARE_UXN1330_HANDLER(term) \
    DECLARE_HANDLER(HANDLER_TYPE_CPU,term,0,0,uxn1330_read,uxn1330_write,0,0,0,0)

#endif
