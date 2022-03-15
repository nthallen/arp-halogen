tmcbase = types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
tmcbase = nav.tmc
tmcbase = T30K1MU.tmc
tmcbase = /usr/local/share/huarp/flttime.tmc 
tmcbase = bmm.tmc
tmcbase = BMM_T30K75KU.tmc

colbase = Halcol.tmc
colbase = idxcol.tmc
colbase = navcol.tmc
colbase = bmm_col.tmc

genuibase = Hal.genui
genuibase = dhtr.genui

extbase = check.tmc VT.tmc VI.tmc

cmdbase = scdc.cmd daspt.cmd
cmdbase = /usr/local/share/huarp/idx64.cmd
cmdbase = idxdrv.cmd
cmdbase = Hal.cmd
cmdbase = bmm.cmd
cmdbase = mux.cmd

genuibase = bmm.genui
extbase = check.tmc bmm_conv.tmc

Module TMbase
Module IWG1

# Module RFD:
#   Also need to:
#     Un/comment lines in haldiag.tbl
#       5 lines in Axes, 1 line in Status
#     Add/remove rfdbits.tmc from hddisp dependencies below
#     Edit interact to enable/disable driver
# tmcbase = rfd.tmc
# genuibase = rfd.genui
# cmdbase = rfd.cmd

SRC = idx.idx NOTitr_4.cyc *.edf tlookup*.dat
IGNORE = Makefile

SCRIPT = dccc.dccc idx.idx64 interact Experiment.config
SCRIPT = runfile.FF runfileFF

OBJ = NOTitr_4.tmc
TGTDIR = $(TGTNODE)/home/Hal

Halsrvr : -lsubbus -lsubbuspp CAN.oui
Halcol : -lsubbus -lsubbuspp
muxctrl : muxctrl.cc muxctrl.oui -ltmpp
rfd : rfd.cc rfd.oui
Hal.sft : Hal.sol

# Add rfdbits.tmc to hddisp dependents if using the RFD definitions
hddisp : idxflag.tmc VT.tmc dstat.tmc SlowCnts.tmc haldiag.tbl
dhdisp : dstat.tmc VT.tmc VI.tmc bmm_conv.tmc dhtr.tbl
gddisp : dstat.tmc gasdiag.tbl
hkdisp : VT.tmc bmm_conv.tmc Housekeeping.tbl
IWG1disp : IWG1.tbl

Hdoit : H.doit
Hlabdoit : Hlab.doit
Halfalgo : dstat.tmc idxflag.tmc VT.tmc VI.tmc bmm_conv.tmc \
           Half.tma Halog.tma DHtr.tma TRU.tma
Halalgo : Hal.tma HalogLab.tma

Calcext : VT.tmc Calc.cdf
NOTitr_4ext : VT.tmc NOTitr_4.tmc NOTitr_4.cdf
checkext : check.tmc
udpext : VT.tmc NOTitr_4.tmc mixrat.tmc UDP.tmc Status/UDP.cc \
         udpext.oui -lsocket
mixratext : VT.tmc NOTitr_4.tmc mixrat.tmc mixrat.cdf

%%
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
NOTitr_4.tmc : NOTitr_4.cyc
	cycle NOTitr_4.cyc >NOTitr_4.tmc
