%INTERFACE <dccc:dccc>

&command
    : &scdc_cmd
      { if_dccc.Turf("D%d\n", $1); }
    : Pump On * { if_dccc.Turf("S70=0\n"); }
    : Pump Off * { if_dccc.Turf("S70=1\n"); }
    : Mux address set %d *
      { if_dccc.Turf( "S%d=%d\n", 98, $4<<2 ); }
    ;
&scdc_cmd <int>
    : GasDeck Air Flow to Duct 2 On * { $0 = 0; }
    : GasDeck Air Flow to Duct 2 Off * { $0 = 1; }
    : GasDeck NO2 Flow to Purge On * { $0 = 4; }
    : GasDeck NO2 Flow to Purge Off * { $0 = 5; }
    : GasDeck Air Flow to NO2 On * { $0 = 6; }
    : GasDeck Air Flow to NO2 Off * { $0 = 7; }
    : GasDeck NO Flow to Duct 1 On * { $0 = 8; }
    : GasDeck NO Flow to Duct 1 Off * { $0 = 9; }
    : GasDeck ClONO2 Flow to Duct 1 On * { $0 = 10; }
    : GasDeck ClONO2 Flow to Duct 1 Off * { $0 = 11; }
    : GasDeck ClONO2 Flow to Duct 2 On * { $0 = 12; }
    : GasDeck ClONO2 Flow to Duct 2 Off * { $0 = 13; }
    : GasDeck NO2 Flow to Axis 1 On * { $0 = 14; }
    : GasDeck NO2 Flow to Axis 1 Off * { $0 = 15; }
    : GasDeck NO2 Flow to Axis 2 On * { $0 = 16; }
    : GasDeck NO2 Flow to Axis 2 Off * { $0 = 17; }
    : GasDeck Main Flow to Duct 2 On * { $0 = 20; }
    : GasDeck Main Flow to Duct 2 Off * { $0 = 21; }
    : GasDeck Air Flow to Duct 1 On * { $0 = 22; }
    : GasDeck Air Flow to Duct 1 Off * { $0 = 23; }
    : GasDeck N2 to Bromine On * { $0 = 24; }
    : GasDeck N2 to Bromine Off * { $0 = 25; }
    : GasDeck NO Flow to Duct 2 On * { $0 = 26; }
    : GasDeck NO Flow to Duct 2 Off * { $0 = 27; }
    : GasDeck Main Flow to Duct 1 On * { $0 = 28; }
    : GasDeck Main Flow to Duct 1 Off * { $0 = 29; }
    : OZONIZER ON * { $0 = 30; }
    : OZONIZER OFF * { $0 = 31; }
    : GasDeck NO Flow to Duct 1 Open On * { $0 = 32; }
    : GasDeck NO Flow to Duct 1 Open Off * { $0 = 33; }
    : GasDeck NO Flow to Duct 1 Closed On * { $0 = 34; }
    : GasDeck NO Flow to Duct 1 Closed Off * { $0 = 35; }
    : GasDeck ClONO2 Flow Open On * { $0 = 36; }
    : GasDeck ClONO2 Flow Open Off * { $0 = 37; }
    : GasDeck ClONO2 Flow Closed On * { $0 = 38; }
    : GasDeck ClONO2 Flow Closed Off * { $0 = 39; }
    : GasDeck NO Flow to Duct 2 Open On * { $0 = 40; }
    : GasDeck NO Flow to Duct 2 Open Off * { $0 = 41; }
    : GasDeck NO Flow to Duct 2 Closed On * { $0 = 42; }
    : GasDeck NO Flow to Duct 2 Closed Off * { $0 = 43; }
    : GasDeck NO2 Flow Open On * { $0 = 44; }
    : GasDeck NO2 Flow Open Off * { $0 = 45; }
    : GasDeck NO2 Flow Closed On * { $0 = 46; }
    : GasDeck NO2 Flow Closed Off * { $0 = 47; }
#   : LN2 Solenoid On * { $0 = 48; }
#   : LN2 Solenoid Off * { $0 = 49; }
#   : 28V Heaters On * { $0 = 50; }
#   : 28V Heaters Off * { $0 = 51; }
#   : Laser Diode Enable On * { $0 = 52; }
#   : Laser Diode Enable Off * { $0 = 53; }
#   : Laser Power On * { $0 = 54; }
#   : Laser Power Off * { $0 = 55; }
#   : Dye Pump On * { $0 = 64; }
#   : Dye Pump Off * { $0 = 65; }
#   : GasDeck Air Flow to Laser On * { $0 = 66; }
#   : GasDeck Air Flow to Laser Off * { $0 = 67; }
#   : APD 1 HV On * { $0 = 68; }
#   : APD 1 HV Off * { $0 = 69; }
#   : APD 2 HV On * { $0 = 70; }
#   : APD 2 HV Off * { $0 = 71; }
    : Lamp A On * { $0 = 72; }
    : Lamp A Off * { $0 = 73; }
    : Lamp B On * { $0 = 74; }
    : Lamp B Off * { $0 = 75; }
    : Lamp C On * { $0 = 76; }
    : Lamp C Off * { $0 = 77; }
    : Lamp D On * { $0 = 78; }
    : Lamp D Off * { $0 = 79; }
#   : AUX Heater On * { $0 = 80; }
#   : AUX Heater Off * { $0 = 81; }
#   : DHeater &dhtr On * { $0 = $2->on; }
#   : DHeater &dhtr Off * { $0 = $2->off; }
#   : DHeater &dhtr Interlock Reset *
#     { $0 = $2->reset;
#       if ( $0 == 0xFFFF ) {
#         nl_error( 2,
#           "DHeater %d does not support Interlock Reset",
#           $2->htr_num );
#         CANCEL_LINE;
#       }
#     }
#   : 3WAY Valve On * { $0 = 90; }
#   : 3WAY Valve Off * { $0 = 91; }
    : Lab Connector cmd On * { $0 = 96; }
    : Lab Connector cmd Off * { $0 = 97; }
#   : Air Heater On * { $0 = 102; }
#   : Air Heater Off * { $0 = 103; }
    ;
