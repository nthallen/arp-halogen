tmcbase = types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
tmcbase = rfd.tmc
tmcbase = nav.tmc
tmcbase = T30K1MU.tmc
tmcbase = /usr/local/share/huarp/flttime.tmc 

cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = scdc.cmd daspt.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = idxdrv.cmd
cmdbase = Hal.cmd
cmdbase = rfd.cmd

SRC = idx.idx NOTitr_4.cyc *.edf tlookup*.dat
# TOOL = README
IGNORE = Makefile

SCRIPT = dccc.dccc idx.idx64 interact Experiment.config
SCRIPT = runfile.FF

# SCRIPT = RoverT.txt

OBJ = NOTitr_4.tmc
TGTDIR = $(TGTNODE)/home/Hal

Halsrvr : -lsubbus
Halcol : Halcol.tmc idxcol.tmc navcol.tmc -lsubbus
muxctrl : muxctrl.cc muxctrl.oui -ltmpp
rfd : rfd.cc rfd.oui
Hal.sft : Hal.sol

hddisp : idxflag.tmc VT.tmc dstat.tmc SlowCnts.tmc rfdbits.tmc haldiag.tbl
thdisp : dstat.tmc VT.tmc VI.tmc therm.tbl dhtr.tbl
gddisp : dstat.tmc gasdiag.tbl
rvdisp : Rover.tbl

Hdoit : H.doit
# Hlabdoit : Hlab.doit
# rvdoit : rv.doit
Halfalgo : dstat.tmc idxflag.tmc VT.tmc Half.tma Halog.tma
Halalgo : Hal.tma
# Hlabalgo : Hlab.tma

#STAText : STAT.edf
#HAL1ext : HAL1.edf
#HAL2ext : HAL2.edf
#HAL3ext : HAL3.edf
#INST1ext : VT.tmc INST1.edf
Calcext : VT.tmc Calc.edf
#INST2ext : INST2.edf
#INST4ext : VI.tmc INST4.edf
#INST5ext : VI.tmc INST5.edf
#INST6ext : INST6.edf
NOTitr_4ext : VT.tmc NOTitr_4.tmc NOTitr_4.edf
#HEng1ext : VI.tmc VT.tmc HEng1.edf
#HEng1txtext : VI.tmc VT.tmc HEng1txt.tmc
halengext : check.tmc haleng.cdf
checkext : check.tmc
%%
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
NOTitr_4.tmc : NOTitr_4.cyc
	cycle NOTitr_4.cyc >NOTitr_4.tmc
haleng.cdf : genui.txt
	genui -d ../eng -c genui.txt
