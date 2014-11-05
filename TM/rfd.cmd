%INTERFACE <RF>

&command
    : External &RFid Setpoint &RFlvl * { if_RF.Turf("S%d=%d\n", $2, $4); }
    ;
&RFid <int>
    : Lamp A RF { $0 = 1; }
    : Lamp B RF { $0 = 2; }
    : Lamp C RF { $0 = 3; }
    : Lamp D RF { $0 = 4; }
    ;
&RFlvl <int>
    : 1 { $0 = 1; }
    : 2 { $0 = 2; }
    : 3 { $0 = 3; }
    : 4 { $0 = 4; }
    ;
