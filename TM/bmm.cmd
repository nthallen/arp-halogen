%{
  #include "bmm.h"

  #ifdef SERVER
    subbuspp *CAN;
    bool bmm_is_present = false;
    
    void CAN_init() {
      CAN = new subbuspp("CAN");
      CAN->load();
      int subfunc = CAN->load();
      if (subfunc == 0) {
        msg(2, "subbusd_slcan Not Found, no TRU functions");
      } else {
        bmm_is_present = true;
      }
    }
  #endif
%}

&command
  : BMM &BMM_ID &BMM_Switch &BMM_On_Off * {
      if (bmm_is_present)
        CAN->write_ack(($2<<8)+0x30, $3+$4);
      else
        msg(2, "TRU/BMM functions disabled");
    }
  : TRU &BMM_On_Off * {
      /* Hard coded to ID==1, commands 5,4 */
      if (bmm_is_present)
        CAN->write_ack((1<<8)+0x30, 5-$2);
      else
        msg(2, "TRU/BMM functions disabled");
   }
 ;
&BMM_ID <int>
  : 1 { $0 = 1; }
# : 2 { $0 = 2; }
# : 3 { $0 = 3; }
  ;
&BMM_Switch <int>
  : LED Status { $0 = 0; }
  : LED Fault { $0 = 2; }
# : Power { $0 = 4; }
  ;
&BMM_On_Off <int>
  : Off { $0 = 0; }
  : On { $0 = 1; }
  ;
  
