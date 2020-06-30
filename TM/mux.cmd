%INTERFACE <Mux>

&command
  : muxctrl Mode &muxmode * { if_Mux.Turf("M%d\n", $3); }
  : muxctrl Fix Address %d * { if_Mux.Turf("A%d\n", $4); }
  : muxctrl Quit * { if_Mux.Turf("Q\n"); }
  ;
&muxmode <int>
  : All { $0 = 0; }
  : NO { $0 = 1; }
  : N2 { $0 = 2; }
  : Air { $0 = 3; }
  ;
