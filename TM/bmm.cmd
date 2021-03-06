%{
  #include "bmm.h"

  #ifdef SERVER
    subbuspp *CAN;
    
    void CAN_init() {
      CAN = new subbuspp("CAN");
      CAN->load();
    }
  #endif
%}

&command
 : BMM &BMM_ID &BMM_Switch &BMM_On_Off * {
     CAN->write_ack(($2<<8)+0x30, $3+$4);
   }
 : TRU &BMM_On_Off * {
     /* Hard coded to ID==1, commands 5,4 */
     CAN->write_ack((1<<8)+0x30, 5-$2);
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
  
