tmcbase = types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
tmcbase = rfd.tmc
tmcbase = nav.tmc
tmcbase = T30K1MU.tmc
tmcbase = bmm.tmc
tmcbase = BMM_T30K75KU.tmc

colbase = Halcol.tmc
colbase = idxcol.tmc
colbase = navcol.tmc
colbase = bmm_col.tmc

cmdbase = scdc.cmd daspt.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = idxdrv.cmd
cmdbase = Hal.cmd
cmdbase = rfd.cmd
cmdbase = bmm.cmd

genuibase = Hal.genui
extbase = check.tmc bmm_conv.tmc

Module TMbase

SRC = idx.idx NOTitr_4.cyc *.edf tlookup*.dat
IGNORE = Makefile

SCRIPT = dccc.dccc idx.idx64 interact Experiment.config
SCRIPT = runfile.FF

OBJ = NOTitr_4.tmc
TGTDIR = $(TGTNODE)/home/Hal

Halsrvr : -lsubbus -lsubbuspp CAN.oui
Halcol : -lsubbus -lsubbuspp
muxctrl : muxctrl.cc muxctrl.oui -ltmpp
rfd : rfd.cc rfd.oui
Hal.sft : Hal.sol

hddisp : idxflag.tmc VT.tmc dstat.tmc SlowCnts.tmc rfdbits.tmc haldiag.tbl
dhdisp : dstat.tmc VT.tmc VI.tmc dhtr.tbl
gddisp : dstat.tmc gasdiag.tbl
# thdisp : dstat.tmc VT.tmc VI.tmc therm.tbl dhtr.tbl
hkdisp : VT.tmc bmm_conv.tmc Housekeeping.tbl

Hdoit : H.doit
Halfalgo : dstat.tmc idxflag.tmc VT.tmc Half.tma Halog.tma
Halalgo : Hal.tma

Calcext : VT.tmc Calc.edf
NOTitr_4ext : VT.tmc NOTitr_4.tmc NOTitr_4.edf
# halengext : check.tmc haleng.cdf
checkext : check.tmc

#STAText : STAT.edf
#HAL1ext : HAL1.edf
#HAL2ext : HAL2.edf
#HAL3ext : HAL3.edf
#INST1ext : VT.tmc INST1.edf
#INST2ext : INST2.edf
#INST4ext : VI.tmc INST4.edf
#INST5ext : VI.tmc INST5.edf
#INST6ext : INST6.edf
#HEng1ext : VI.tmc VT.tmc HEng1.edf
#HEng1txtext : VI.tmc VT.tmc HEng1txt.tmc
%%
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
NOTitr_4.tmc : NOTitr_4.cyc
	cycle NOTitr_4.cyc >NOTitr_4.tmc
#haleng.cdf : genui.txt
#	genui -d ../eng -c genui.txt
