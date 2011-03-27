&command
	: &daspt_cmd &setpt *
	  { cache_write( $1, $2 ); }
	: &flowspt_cmd &setpt5 *
	  { cache_write( $1, $2 ); }
	;
&daspt_cmd <int>
	: Lamp A IR Setpoint { $0 = 0xDE6; }
	: Aux Heaters Setpoint { $0 = 0xDEA; }
	: Lamp B IR Setpoint { $0 = 0xDE2; }
	: Lamp C IR Setpoint { $0 = 0xCE6; }
	: Dewar P Setpoint { $0 = 0xDE8; }
	: Lamp D IR Setpoint { $0 = 0xCE2; }
	: Laser Diode 1 Setpoint { $0 = 0xDEE; }
	: Laser Diode 2 Setpoint { $0 = 0xDEC; }
	: Lab 1 Setpoint { $0 = 0xE64; }
#       : Lamp A RF Setpoint { $0 = 0xDE4; }
#       : Lamp B RF Setpoint { $0 = 0xDE0; }
#       : Lamp C RF Setpoint { $0 = 0xCE4; }
#       : Lamp D RF Setpoint { $0 = 0xCE0; }
	: Spare AO 35 { $0 = 0xE66; }
	: Spare AO 36 { $0 = 0xE68; }
	: Spare AO 37 { $0 = 0xE6A; }
	: Spare AO 38 { $0 = 0xE6C; }
	: Spare AO 39 { $0 = 0xE6E; }
	: Spare AO APD 1 HV Setpoint { $0 = 0xE60; }
	: Spare AO APD 2 HV Setpoint { $0 = 0xE62; }
	;
&flowspt_cmd <int>
	: GasDeck ClONO2 Flow SetPoint { $0 = 0xCEC; }
	: GasDeck NO2 Flow SetPoint { $0 = 0xC60; }
	: GasDeck NO Flow to Duct 1 SetPoint { $0 = 0xCEE; }
	: GasDeck NO Flow to Duct 2 SetPoint { $0 = 0xD60; }
	;
&setpt <unsigned short>
	: %d (Enter Setpoint Value 0-4095)
	  { $0 = $1;
	    if ( $0 > 4095 ) {
	      nl_error( 2, "Setpoint outside range 0-4095" );
	      CANCEL_LINE;
	    }
	  }
	;
&setpt5 <unsigned short>
	: %d (Enter Setpoint Value 0-2048)
	  { $0 = $1;
	    if ( $0 > 2048 ) {
	      nl_error( 2, "Setpoint outside range 0-2048" );
	      CANCEL_LINE;
	    }
	  }
	;
