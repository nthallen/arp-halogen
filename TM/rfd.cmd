%INTERFACE <RF>

&command
    : RF &RFid Set &RFlvl * { if_RF.Turf("S%d=%d\n", $2, $4); }
    ;
&RFid <int>
    : A { $0 = 1; }
    : B { $0 = 2; }
    : C { $0 = 3; }
    : D { $0 = 4; }
    ;
&RFlvl <int>
    : 1 { $0 = 1; }
    : 2 { $0 = 2; }
    : 3 { $0 = 3; }
    : 4 { $0 = 4; }
    ;
