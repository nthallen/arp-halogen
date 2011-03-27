%{
  #include "subbus.h"
  #include "swstat.h"
  #define IOMODE_INIT (IO_SPACE|IO_BACKSPACE|IO_WORD|IO_WORDSKIP)

  #ifdef SERVER
    swstat_t SWData;

    static void setfail( unsigned int bit, int on ) {
      static int fail_code;
      int mask;
    
      if ( bit > 7 ) return;
      mask = 1 << bit;
      if ( on ) fail_code |= mask;
      else fail_code &= ~mask;
      set_failure( fail_code );
    }
  #endif

%}

%INTERFACE <SWData:DG/data>
%INTERFACE <soldrv>
%INTERFACE <subbus>

&command
    : CMDENBL &on_off * { set_cmdenbl( $2 ); }
    : Fail Lamp %d(Enter Bit Number 0-7) &on_off * { setfail( $3, $4 ); }
#   : TRU &on_off * { setfail( 1, $2 ); }
    : &CmdData * { if_SWData.Turf(); }
    : &SoldrvA * { if_soldrv.Turf( "M%d\n", $1); }
    ;

&SoldrvA <int>
    : Soldrv Select Halogen Mode %d (Enter Mode Number) { $0 = $5; }
    : Soldrv NO Addition { $0 = 2; }
    : Soldrv NO Off { $0 = 1; }
    ;

&on_off <int>
    : On { $0 = 1; }
    : Off { $0 = 0; }
    ;
&CmdData
    : Set SW Status &swstat to %d ( Enter value from 0-255 ) {
        *$4 = $6;
      }
    : Set SW Command &swcommand { SWData.SW1_S = $4; }
    ;
&swstat <unsigned char *>
    : 1 { $0 = &SWData.SW1_S; }
    : 2 { $0 = &SWData.SW2_S; }
    ;
&swcommand <unsigned char>
    : Clear { $0 = SWS_OK; }
    : Altitude Takeoff { $0 = SWS_TAKEOFF; }
    : Altitude Cruise { $0 = SWS_CLIMB; }
    : Altitude Descend { $0 = SWS_DESCEND; }
    : Altitude Land { $0 = SWS_LAND; }
    : TimeWarp { $0 = SWS_TIME_WARP; }
    : Shutdown { $0 = SWS_SHUTDOWN; }
    ;
