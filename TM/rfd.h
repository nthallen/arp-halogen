/* rfd.h structure definition for collection */
#ifndef RFD_H_INCLUDED
#define RFD_H_INCLUDED

typedef struct __attribute__((__packed__)) {
  unsigned char power[4];
  unsigned char temp[4];
  unsigned char alive;
} RFD_t;

#endif
