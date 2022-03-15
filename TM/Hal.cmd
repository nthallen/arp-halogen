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
%INTERFACE <SoldrvA>
%INTERFACE <subbus>

&command
    : CMDENBL &on_off * { set_cmdenbl( $2 ); }
    : Fail Lamp %d(Enter Bit Number 0-7) &on_off * { setfail( $3, $4 ); }
#   : TRU &on_off * { setfail( 1, $2 ); }
    : &CmdData * { if_SWData.Turf(); }
    : &SoldrvA * { if_SoldrvA.Turf( "S%d\n", $1); }
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
    : SW Status Set &swstat to %d ( Enter value from 0-255 ) {
        *$4 = $6;
      }
    : SW Status &swcommand { SWData.SW1_S = $3; }
    : SWS Clear { SWData.SW2_S = 0; }
    : Duct &duct_sp Temperature &SetAdd &duct_sp_val {
        int setpt, convsetpt;
        if ( $4 ) { /* increment */
          setpt = cache_read($2) * 2 - 74;
          setpt += $5;
        } else setpt = $5;
        convsetpt = (setpt + 74)/2;
        if ( convsetpt < 0 || convsetpt > 255 ) {
          nl_error( 1, "Duct Set Point %d is out of range", setpt );
          if ( convsetpt < 0 ) convsetpt = 0;
          else if ( convsetpt > 255 ) convsetpt = 255;
        }
        cache_write($2, convsetpt);
      }
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
    : Flow 1 High { $0 = SWS_FLOW1HI; }
    : Flow 1 Medium { $0 = SWS_FLOW1MED; }
    : Flow 1 Low { $0 = SWS_FLOW1LOW; }
    : Flow 2 High { $0 = SWS_FLOW2HI; }
    : Flow 2 Medium { $0 = SWS_FLOW2MED; }
    : Flow 2 Low { $0 = SWS_FLOW2LOW; }
    : Lamp A On { $0 = SWS_LAMP_A_ON; }
    : Lamp B On { $0 = SWS_LAMP_B_ON; }
    : Lamp C On { $0 = SWS_LAMP_C_ON; }
    : Lamp D On { $0 = SWS_LAMP_D_ON; }
    : Lamp A Off { $0 = SWS_LAMP_A_OFF; }
    : Lamp B Off { $0 = SWS_LAMP_B_OFF; }
    : Lamp C Off { $0 = SWS_LAMP_C_OFF; }
    : Lamp D Off { $0 = SWS_LAMP_D_OFF; }
    : Lamp A Watch { $0 = SWS_LAMP_A_WATCH; }
    : Lamp B Watch { $0 = SWS_LAMP_B_WATCH; }
    : Lamp C Watch { $0 = SWS_LAMP_C_WATCH; }
    : Lamp D Watch { $0 = SWS_LAMP_D_WATCH; }
    : Lamp A Ignore { $0 = SWS_LAMP_A_IGNORE; }
    : Lamp B Ignore { $0 = SWS_LAMP_B_IGNORE; }
    : Lamp C Ignore { $0 = SWS_LAMP_C_IGNORE; }
    : Lamp D Ignore { $0 = SWS_LAMP_D_IGNORE; }
    : TimeWarp { $0 = SWS_TIME_WARP; }
    : Shutdown { $0 = SWS_SHUTDOWN; }
    ;
&SetAdd <int>
	: Set { $0 = 0; }
	: Add { $0 = 1; }
	;
&duct_sp <unsigned short>
	: 1 { $0 = 0x1002; }
	: 2 { $0 = 0x1003; }
	;
&duct_sp_val <int>
	: %d ( Enter Temperature in C ) C { $0 = $1; }
	;
