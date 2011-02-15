tmcbase = types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
tmcbase = nav.tmc

cmdbase = sws_init.cmd
cmdbase = /usr/local/share/huarp/root.cmd
cmdbase = /usr/local/share/huarp/getcon.cmd
cmdbase = scdc.cmd daspt.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = idxdrv.cmd
cmdbase = Hal.cmd

SRC = idx.idx NOTitr_4.cyc *.edf tlookup*.dat
# TOOL = README
SCRIPT = dccc.dccc idx.idx64 interact Experiment.config
# SCRIPT = Hlab_interact runfile.1111 RoverT.txt
# SCRIPT = runfile.1101 runfile.Ncal
# OBJ = NOTitr_4.tmc
TGTDIR = $(TGTNODE)/home/Hal

Halsrvr : -lsubbus
Halcol : Halcol.tmc idxcol.tmc navcol.tmc -lsubbus
muxctrl : muxctrl.c muxctrl.oui

# Hal.sft : Hal.sol

hddisp : idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc haldiag.tbl
# thdisp : dstat.tmc VT.tmc VI.tmc therm.tbl dhtr.tbl
# gddisp : dstat.tmc gasdiag.tbl
# rvdisp : Rover.tbl
# Hlabdoit : Hlab.doit
# Hdoit : H.doit
# rvdoit : rv.doit
# Halfalgo : dstat.tmc idxflag.tmc VT.tmc VI.tmc Half.tma Halog.tma DHtr.tma TRU.tma
# Hlabalgo : Hlab.tma

#STAText : STAT.edf
#HAL1ext : HAL1.edf
#HAL2ext : HAL2.edf
#HAL3ext : HAL3.edf
#INST1ext : VT.tmc INST1.edf
#INST2ext : INST2.edf
#INST4ext : VI.tmc INST4.edf
#INST5ext : VI.tmc INST5.edf
#INST6ext : VI.tmc INST6.edf
#NOTitr_4ext : VT.tmc VI.tmc NOTitr_4.tmc NOTitr_4.edf
#HEng1ext : VI.tmc VT.tmc HEng1.edf
#HEng1txtext : VI.tmc VT.tmc HEng1txt.tmc
%%
# NOTitr_4.tmc : NOTitr_4.cyc
#   cycle NOTitr_4.cyc >NOTitr_4.tmc
