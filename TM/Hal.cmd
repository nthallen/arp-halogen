%{
  #include "subbus.h"
  #include "da_cache.h"
  #include "swstat.h"
  #define IOMODE_INIT (IO_SPACE|IO_BACKSPACE|IO_WORD|IO_WORDSKIP)

  #ifdef SERVER
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
%INTERFACE <soldrv>

&command
    : CMDENBL &on_off * { set_cmdenbl( $2 ); }
    : Fail Lamp %d(Enter Bit Number 0-7) &on_off * { setfail( $3, $4 ); }
    : TRU &on_off * { setfail( 1, $2 ); }
    : &CmdData * {
        if ( SWS_id == 0 )
          SWS_id = Col_send_init( "SWData", &SWData, sizeof( SWData ), 0 );
        Col_send( SWS_id );
      }
    : &SoldrvA * { cis_turf(if_soldrv, "M%d\n", $1); }
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
    : Set SW Command &swcommand { SWData.SW_1S = $4; }
    ;
&swstat <unsigned char *>
    : 1 { $0 = &SWData.SW_1S; }
    : 2 { $0 = &SWData.SW_2S; }
    ;
&swcommand <unsigned char>
    : Clear { $0 = 0; }
    : Altitude Takeoff { $0 = 1; }
    : Altitude Cruise { $0 = 2; }
    : Altitude Descend { $0 = 3; }
    : Altitude Land { $0 = 4; }
    : Green Peakup Start { $0 = 120; }
    : Green Peakup Stop { $0 = 121; }
    : Green Peakup Scan { $0 = 122; }
    : Laser On { $0 = 140; }
    : Write New Base Scan { $0 = 203; }
    : Select Fluoresence { $0 = 204; }
    : Select Absorption { $0 = 205; }
    : TimeWarp { $0 = 244; }
    ;
