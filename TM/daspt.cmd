%{
  typedef struct {
    int htr_num, n_zones;
    unsigned short on, off, reset;
    unsigned short setpoint;
    unsigned short addr[7];
    unsigned short percent[7];
  } dhdef;
  typedef struct {
    dhdef *dhtr;
    unsigned short zone;
  } dhzone;
  dhdef dh1 = { 1, 7, 82, 83, 86, 0,
    { 0xD6E, 0xD6C, 0xD6A, 0xD68, 0xD66, 0xD64, 0xD62 },
    {   100,   100,   100,   100,   100,   100,   100 }
  };
  dhdef dh2 = { 2, 7, 84, 85, 87, 0,
    { 0xC6E, 0xC6C, 0xC6A, 0xC68, 0xC66, 0xC64, 0xC62 },
    {   100,   100,   100,   100,   100,   100,   100 }
  };
%}
&command
  : &daspt_cmd &setpt *
    { cache_write( $1, $2 ); }
  : &flowspt_cmd &setpt5 *
    { cache_write( $1, $2 ); }
  : &dhzone Scale &pct Percent *
    { dhdef *dhtr = $1.dhtr;
      unsigned short zone = $1.zone;
      unsigned short value = dhtr->setpoint;
      dhtr->percent[zone] = $3;
      value = (((long)value) * $3)/100;
      cache_write( dhtr->addr[zone], value );
    }
  : DHeater &dhset *
    { int zone;
      unsigned short value;
      for ( zone = 0; zone < $2->n_zones; zone++ ) {
        value = ( ((long)$2->setpoint) * $2->percent[zone] ) / 100;
        cache_write( $2->addr[zone], value );
      }
    }
  ;
&daspt_cmd <int>
  : Lamp A IR Setpoint { $0 = 0xDE6; }
  : Aux Heaters Setpoint { $0 = 0xDEA; }
  : Lamp B IR Setpoint { $0 = 0xDE2; }
  : Lamp C IR Setpoint { $0 = 0xCE6; }
  : Dewar P Setpoint { $0 = 0xDE8; }
  : Lamp D IR Setpoint { $0 = 0xCE2; }
# : Laser Diode 1 Setpoint { $0 = 0xDEE; }
# : Laser Diode 2 Setpoint { $0 = 0xDEC; }
  : Lab 1 Setpoint { $0 = 0xE64; }
  : Lamp A RF Setpoint { $0 = 0xDE4; }
  : Lamp B RF Setpoint { $0 = 0xDE0; }
  : Lamp C RF Setpoint { $0 = 0xCE4; }
  : Lamp D RF Setpoint { $0 = 0xCE0; }
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

&dhtr <dhdef *>
  : 1 { $0 = &dh1; }
  : 2 { $0 = &dh2; }
  ;
&dhzone <dhzone>
  : DHeater &dhtr Zone %d (Enter Zone Number 0-6)
    { $0.dhtr = $2;
      $0.zone = $4;
      if ( $0.zone >= $0.dhtr->n_zones ) {
        nl_error( 2, "DHeater %d has only %u zones", 
            $0.dhtr->htr_num, $0.dhtr->n_zones );
        CANCEL_LINE;
      }
    }
  ;
&pct <unsigned short>
  : %d (Enter Percentage 0-100)
    { $0 = $1;
      if ( $0 > 100 ) {
        nl_error( 2, "Percentages over 100 not aloud" );
        CANCEL_LINE;
      }
    }
  ;
&dhset <dhdef *>
  : &dhtr SetPoint to &setpt {
      $0 = $1;
      $0->setpoint = $4;
    }
  : &dhtr SetPoint add %d (Enter signed increment) {
      int value;
      $0 = $1;
      value = (int)$0->setpoint + $4;
      if ( value < 0 ) value = 0;
      if ( value == 4096 ) value = 4095; /* for ron */
      if ( value > 4095 ) {
        nl_error( 2, "Value out of range" );
        CANCEL_LINE;
      } else $0->setpoint = value;
    }
  ;
