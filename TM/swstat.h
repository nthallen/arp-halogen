/* swstat.h */
#ifndef SWSTAT_H_INCLUDED
#define SWSTAT_H_INCLUDED

typedef struct {
  unsigned char SW1_S;
  unsigned char SW2_S;
} __attribute__((packed)) swstat_t;
extern swstat_t SWData;

#define SWS_OK 0
#define SWS_TAKEOFF 1
#define SWS_CLIMB 2
#define SWS_DESCEND 3
#define SWS_LAND 4

#define SWS_FLOW1HI  20
#define SWS_FLOW1MED 30
#define SWS_FLOW1LOW 40
#define SWS_FLOW2HI  50
#define SWS_FLOW2MED 60
#define SWS_FLOW2LOW 70


#define SWS_LAMP_A_OFF 211
#define SWS_LAMP_B_OFF 212
#define SWS_LAMP_C_OFF 213
#define SWS_LAMP_D_OFF 214
#define SWS_LAMP_A_ON 221
#define SWS_LAMP_B_ON 222
#define SWS_LAMP_C_ON 223
#define SWS_LAMP_D_ON 224

#define SWS_TIME_WARP 253
#define SWS_READFILE 254
#define SWS_SHUTDOWN 255

#endif
