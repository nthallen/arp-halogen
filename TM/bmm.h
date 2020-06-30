#ifndef BMM_H_INCLUDED
#define BMM_H_INCLUDED
#ifdef __cplusplus
#include "subbuspp.h"

extern subbuspp *CAN;

extern "C" {
#endif

void CAN_init();

#ifdef __cplusplus
}
#endif

#endif
