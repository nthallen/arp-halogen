%{
  #include "uDACS16.h"

  #ifdef SERVER
    subbuspp *uDACS16;
    bool uDACS16_is_present = false;
    
    void uDACS16_init() {
      uDACS16 = new subbuspp("uDACS16");
      uDACS16->load();
      int subfunc = uDACS16->load();
      if (subfunc == 0) {
        msg(2, "subbusd_serusb Not Found, no TRU functions");
      } else {
        uDACS16_is_present = true;
      }
    }
  #endif
%}

&command
  : uDACS16 &uDACS16_Switch &uDACS16_On_Off * {
      if (uDACS16_is_present)
        uDACS16->write_ack(0x30, $2+$3);
      else
        msg(2, "TRU/uDACS16 functions disabled");
    }
  : TRU &uDACS16_On_Off * {
      /* Hard coded to commands 5,4 */
      if (uDACS16_is_present)
        uDACS16->write_ack(0x30, 7-$2);
      else
        msg(2, "TRU/uDACS16 functions disabled");
   }
  ;
&uDACS16_Switch <int>
  : LED Status { $0 = 0; }
  : LED Fault { $0 = 2; }
# : Power { $0 = 4; }
  ;
&uDACS16_On_Off <int>
  : Off { $0 = 0; }
  : On { $0 = 1; }
  ;
  
