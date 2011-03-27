# Makefile Generated Sun Mar 27 11:59:46 EDT 2011
MNC=Hal
HOMEDIR=/home/Hal/src/TM
SPECFILE=Hal.spec
SRC=idx.idx NOTitr_4.cyc HAL1.edf HAL2.edf HAL3.edf INST1.edf
SRC+=INST2.edf INST6.edf NOTitr_4.edf STAT.edf tlookup*.dat scdc.cmd
SRC+=daspt.cmd idxdrv.cmd Hal.cmd rfd.cmd types.tmc base.tmc mux.tmc
SRC+=status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc
SRC+=Halcol.tmc idxcol.tmc navcol.tmc muxctrl.c muxctrl.oui rfd.cc
SRC+=rfd.oui Hal.sol idxflag.tmc VT.tmc dstat.tmc SlowCnts.tmc
SRC+=rfdbits.tmc haldiag.tbl therm.tbl gasdiag.tbl Rover.tbl H.doit
SRC+=Hal.tma NOTitr_4.tmc
TOOL=Hal.spec Makefile
SCRIPT=dccc.dccc idx.idx64 interact Experiment.config
OBJ=NOTitr_4.tmc Halcmd.cc Halcmd.dat Halsrvr.o Halsrvroui.c
OBJ+=Halsrvroui.o Halcol.cc Hal.pcm tm.dac Halcoloui.c Halcoloui.o
OBJ+=Halcol.o muxctrloui.c muxctrl.o muxctrloui.o rfdoui.c rfdoui.o
OBJ+=rfd.o haldiagtbl.tmc hddisp.cc hddispoui.c hddispoui.o hddisp.o
OBJ+=haldiagtblnc.tmc hddispnc.cc hddispncoui.c hddispncoui.o
OBJ+=hddispnc.o thermtbl.tmc thdisp.cc thdispoui.c thdispoui.o
OBJ+=thdisp.o thermtblnc.tmc thdispnc.cc thdispncoui.c thdispncoui.o
OBJ+=thdispnc.o gasdiagtbl.tmc gddisp.cc gddispoui.c gddispoui.o
OBJ+=gddisp.o gasdiagtblnc.tmc gddispnc.cc gddispncoui.c
OBJ+=gddispncoui.o gddispnc.o Rovertbl.tmc rvdisp.cc rvdispoui.c
OBJ+=rvdispoui.o rvdisp.o Rovertblnc.tmc rvdispnc.cc rvdispncoui.c
OBJ+=rvdispncoui.o rvdispnc.o Hdoit.dep Halalgoa.tmc Halalgo.cc
OBJ+=Halalgooui.c Halalgooui.o Halalgo.o STATextedf.oui STAText.tmc
OBJ+=STAText.cc STATextoui.c STATextoui.o STAText.o HAL1extedf.oui
OBJ+=HAL1ext.tmc HAL1ext.cc HAL1extoui.c HAL1extoui.o HAL1ext.o
OBJ+=HAL2extedf.oui HAL2ext.tmc HAL2ext.cc HAL2extoui.c HAL2extoui.o
OBJ+=HAL2ext.o HAL3extedf.oui HAL3ext.tmc HAL3ext.cc HAL3extoui.c
OBJ+=HAL3extoui.o HAL3ext.o INST1extedf.oui INST1ext.tmc INST1ext.cc
OBJ+=INST1extoui.c INST1extoui.o INST1ext.o INST2extedf.oui
OBJ+=INST2ext.tmc INST2ext.cc INST2extoui.c INST2extoui.o INST2ext.o
OBJ+=INST6extedf.oui INST6ext.tmc INST6ext.cc INST6extoui.c
OBJ+=INST6extoui.o INST6ext.o NOTitr_4extedf.oui NOTitr_4ext.tmc
OBJ+=NOTitr_4ext.cc NOTitr_4extoui.c NOTitr_4extoui.o NOTitr_4ext.o
OBJ+=Halclt.o Halcltoui.c Halcltoui.o Halcltnc.o Halcltncoui.c
OBJ+=Halcltncoui.o
TGT=Halsrvr Halcol muxctrl rfd Hal.sft hddisp hddispnc thdisp
TGT+=thdispnc gddisp gddispnc rvdisp rvdispnc Hdoit Halalgo STAText
TGT+=HAL1ext HAL2ext HAL3ext INST1ext INST2ext INST6ext NOTitr_4ext
TGT+=Halclt Halcltnc
DISTRIB=Hal.pcm tm.dac
IDISTRIB=Experiment.config VERSION Hdoit
SRCDIST=Hal.sol haldiag.tbl therm.tbl gasdiag.tbl Rover.tbl Hal.tma
SRCDIST+=types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
SRCDIST+=rfd.tmc nav.tmc T30K1MU.tmc
NONRCS=
TMCBASE=types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
TMCBASE+=rfd.tmc nav.tmc T30K1MU.tmc
CMDBASE=/usr/local/share/huarp/root.cmd
CMDBASE+=/usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd
CMDBASE+=/usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd rfd.cmd
RCS=$(SRC) $(TOOL) $(SCRIPT)
SOURCE=$(RCS) $(NONRCS)
OBJECT=$(OBJ) *.err
TARGET=$(TGT)
DSTRB=$(TGT) $(DISTRIB) $(SCRIPT)
TGTDIR= $(TGTNODE)/home/Hal
include /usr/local/share/huarp/appgen.mk

all : Makefile $(TGT)
Makefile : Hal.spec
	appgen Hal.spec
VERSION=`cat VERSION`
extdistribution : $(DSTRB) $(SRCDIST)
	@[ -d $(TGTDIR)/bin ] || mkdir $(TGTDIR)/bin
	@[ -d $(TGTDIR)/bin/$(VERSION) ] || mkdir $(TGTDIR)/bin/$(VERSION)
	@[ -d  $(TGTDIR)/bin/$(VERSION)/Base ] || mkdir $(TGTDIR)/bin/$(VERSION)/Base
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION) $(DSTRB)
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION)/Base $(SRCDIST)
distribution : extdistribution
	@distribute $(FORCE) $(TGTDIR) $(IDISTRIB)
Halsrvr : Halsrvr.o Halsrvroui.o
	$(LINK.privCXX) Halsrvr.o Halsrvroui.o -lsubbus -ltmpp -ltm -lnort
	$(OUIUSE) Halsrvroui.c
	$(PROMOTE) Halsrvr
Halcol : Halcol.o Halcoloui.o
	$(LINK.privCXX) Halcol.o Halcoloui.o -lsubbus -ltmpp -ltm -lnort
	$(OUIUSE) Halcoloui.c
	$(PROMOTE) Halcol
muxctrl : muxctrl.o muxctrloui.o
	$(LINK.norm) muxctrl.o muxctrloui.o -ltm -lnort
	$(OUIUSE) muxctrloui.c
rfd : rfd.o rfdoui.o
	$(LINK.normCXX) rfd.o rfdoui.o -ltm -lnort
	$(OUIUSE) rfdoui.c
Hal.sft : Hal.sol
	solfmt -oHal.sft  Hal.sol
hddisp : hddisp.o hddispoui.o
	$(LINK.normCXX) hddisp.o hddispoui.o -ldisp -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) hddispoui.c
hddispnc : hddispnc.o hddispncoui.o
	$(LINK.normCXX) hddispnc.o hddispncoui.o -ldispnc -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) hddispncoui.c
thdisp : thdisp.o thdispoui.o
	$(LINK.normCXX) thdisp.o thdispoui.o -ldisp -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) thdispoui.c
thdispnc : thdispnc.o thdispncoui.o
	$(LINK.normCXX) thdispnc.o thdispncoui.o -ldispnc -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) thdispncoui.c
gddisp : gddisp.o gddispoui.o
	$(LINK.normCXX) gddisp.o gddispoui.o -ldisp -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) gddispoui.c
gddispnc : gddispnc.o gddispncoui.o
	$(LINK.normCXX) gddispnc.o gddispncoui.o -ldispnc -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) gddispncoui.c
rvdisp : rvdisp.o rvdispoui.o
	$(LINK.normCXX) rvdisp.o rvdispoui.o -ldisp -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) rvdispoui.c
rvdispnc : rvdispnc.o rvdispncoui.o
	$(LINK.normCXX) rvdispnc.o rvdispncoui.o -ldispnc -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) rvdispncoui.c
Hdoit : H.doit
	mkdoit3 -o Hdoit  H.doit
Halalgo : Halalgo.o Halalgooui.o
	$(LINK.normCXX) Halalgo.o Halalgooui.o -ltmpp -ltm -lnort
	$(OUIUSE) Halalgooui.c
STAText : STAText.o STATextoui.o
	$(LINK.normCXX) STAText.o STATextoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) STATextoui.c
HAL1ext : HAL1ext.o HAL1extoui.o
	$(LINK.normCXX) HAL1ext.o HAL1extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) HAL1extoui.c
HAL2ext : HAL2ext.o HAL2extoui.o
	$(LINK.normCXX) HAL2ext.o HAL2extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) HAL2extoui.c
HAL3ext : HAL3ext.o HAL3extoui.o
	$(LINK.normCXX) HAL3ext.o HAL3extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) HAL3extoui.c
INST1ext : INST1ext.o INST1extoui.o
	$(LINK.normCXX) INST1ext.o INST1extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) INST1extoui.c
INST2ext : INST2ext.o INST2extoui.o
	$(LINK.normCXX) INST2ext.o INST2extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) INST2extoui.c
INST6ext : INST6ext.o INST6extoui.o
	$(LINK.normCXX) INST6ext.o INST6extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) INST6extoui.c
NOTitr_4ext : NOTitr_4ext.o NOTitr_4extoui.o
	$(LINK.normCXX) NOTitr_4ext.o NOTitr_4extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) NOTitr_4extoui.c
Halclt : Halclt.o Halcltoui.o
	$(LINK.normCXX) Halclt.o Halcltoui.o -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) Halcltoui.c
Halcltnc : Halcltnc.o Halcltncoui.o
	$(LINK.normCXX) Halcltnc.o Halcltncoui.o -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) Halcltncoui.c
Halcmd.cc : /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd rfd.cmd
	$(CMDGEN) -d Halcmd.dat /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd rfd.cmd
Halsrvr.o : Halcmd.cc
	$(COMPILE.srvr) Halcmd.cc
Halsrvroui.c : $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
Halsrvroui.o : Halsrvroui.c
Halcol.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halcol.tmc idxcol.tmc navcol.tmc
	$(TMC.col) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halcol.tmc idxcol.tmc navcol.tmc
Halcoloui.c : $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
Halcoloui.o : Halcoloui.c
Halcol.o : Halcol.cc
muxctrloui.c : muxctrl.oui $(OUIDIR)/msg.oui
	$(OUI) muxctrl.oui $(OUIDIR)/msg.oui
muxctrl.o : muxctrl.c
muxctrloui.o : muxctrloui.c
rfdoui.c : rfd.oui $(OUIDIR)/msg.oui
	$(OUI) rfd.oui $(OUIDIR)/msg.oui
rfdoui.o : rfdoui.c
rfd.o : rfd.cc
haldiagtbl.tmc : haldiag.tbl
	$(TABLE) haldiag.tbl
hddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtbl.tmc
hddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispoui.o : hddispoui.c
hddisp.o : hddisp.cc
haldiagtblnc.tmc : haldiag.tbl
	$(NCTABLE) haldiag.tbl
hddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtblnc.tmc
hddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispncoui.o : hddispncoui.c
hddispnc.o : hddispnc.cc
thermtbl.tmc : therm.tbl
	$(TABLE) therm.tbl
thdisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc thermtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc thermtbl.tmc
thdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispoui.o : thdispoui.c
thdisp.o : thdisp.cc
thermtblnc.tmc : therm.tbl
	$(NCTABLE) therm.tbl
thdispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc thermtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc thermtblnc.tmc
thdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispncoui.o : thdispncoui.c
thdispnc.o : thdispnc.cc
gasdiagtbl.tmc : gasdiag.tbl
	$(TABLE) gasdiag.tbl
gddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtbl.tmc
gddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispoui.o : gddispoui.c
gddisp.o : gddisp.cc
gasdiagtblnc.tmc : gasdiag.tbl
	$(NCTABLE) gasdiag.tbl
gddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtblnc.tmc
gddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispncoui.o : gddispncoui.c
gddispnc.o : gddispnc.cc
Rovertbl.tmc : Rover.tbl
	$(TABLE) Rover.tbl
rvdisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertbl.tmc
rvdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
rvdispoui.o : rvdispoui.c
rvdisp.o : rvdisp.cc
Rovertblnc.tmc : Rover.tbl
	$(NCTABLE) Rover.tbl
rvdispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertblnc.tmc
rvdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
rvdispncoui.o : rvdispncoui.c
rvdispnc.o : rvdispnc.cc
Hdoit.dep : H.doit
	mkdoit3 -M -o Hdoit  H.doit
-include Hdoit.dep
Halalgoa.tmc : Hal.tma Halsrvr
	$(SERVER) ./Halsrvr
	$(TMCALGO) -V "`./Halsrvr -R`" Hal.tma
Halalgo.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halalgoa.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halalgoa.tmc
Halalgooui.c : $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
Halalgooui.o : Halalgooui.c
Halalgo.o : Halalgo.cc
STATextedf.oui : STAT.edf
	$(EDF2OUI) STAT.edf
STAText.tmc : STAT.edf
	$(EDF2EXT) STAT.edf
STAText.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc STAText.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc STAText.tmc
STATextoui.c : STATextedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) STATextedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
STATextoui.o : STATextoui.c
STAText.o : STAText.cc
HAL1extedf.oui : HAL1.edf
	$(EDF2OUI) HAL1.edf
HAL1ext.tmc : HAL1.edf
	$(EDF2EXT) HAL1.edf
HAL1ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL1ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL1ext.tmc
HAL1extoui.c : HAL1extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) HAL1extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HAL1extoui.o : HAL1extoui.c
HAL1ext.o : HAL1ext.cc
HAL2extedf.oui : HAL2.edf
	$(EDF2OUI) HAL2.edf
HAL2ext.tmc : HAL2.edf
	$(EDF2EXT) HAL2.edf
HAL2ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL2ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL2ext.tmc
HAL2extoui.c : HAL2extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) HAL2extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HAL2extoui.o : HAL2extoui.c
HAL2ext.o : HAL2ext.cc
HAL3extedf.oui : HAL3.edf
	$(EDF2OUI) HAL3.edf
HAL3ext.tmc : HAL3.edf
	$(EDF2EXT) HAL3.edf
HAL3ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL3ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc HAL3ext.tmc
HAL3extoui.c : HAL3extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) HAL3extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
HAL3extoui.o : HAL3extoui.c
HAL3ext.o : HAL3ext.cc
INST1extedf.oui : INST1.edf
	$(EDF2OUI) INST1.edf
INST1ext.tmc : INST1.edf
	$(EDF2EXT) INST1.edf
INST1ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc INST1ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc INST1ext.tmc
INST1extoui.c : INST1extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) INST1extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
INST1extoui.o : INST1extoui.c
INST1ext.o : INST1ext.cc
INST2extedf.oui : INST2.edf
	$(EDF2OUI) INST2.edf
INST2ext.tmc : INST2.edf
	$(EDF2EXT) INST2.edf
INST2ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc INST2ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc INST2ext.tmc
INST2extoui.c : INST2extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) INST2extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
INST2extoui.o : INST2extoui.c
INST2ext.o : INST2ext.cc
INST6extedf.oui : INST6.edf
	$(EDF2OUI) INST6.edf
INST6ext.tmc : INST6.edf
	$(EDF2EXT) INST6.edf
INST6ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc INST6ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc INST6ext.tmc
INST6extoui.c : INST6extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) INST6extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
INST6extoui.o : INST6extoui.c
INST6ext.o : INST6ext.cc
NOTitr_4extedf.oui : NOTitr_4.edf
	$(EDF2OUI) NOTitr_4.edf
NOTitr_4ext.tmc : NOTitr_4.edf
	$(EDF2EXT) NOTitr_4.edf
NOTitr_4ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc NOTitr_4.tmc NOTitr_4ext.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc NOTitr_4.tmc NOTitr_4ext.tmc
NOTitr_4extoui.c : NOTitr_4extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) NOTitr_4extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
NOTitr_4extoui.o : NOTitr_4extoui.c
NOTitr_4ext.o : NOTitr_4ext.cc
Halclt.o : Halcmd.cc
	$(COMPILE.clt) Halcmd.cc
Halcltoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
Halcltoui.o : Halcltoui.c
Halcltnc.o : Halcmd.cc
	$(COMPILE.cltnc) Halcmd.cc
Halcltncoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
Halcltncoui.o : Halcltncoui.c

tidy :
	rm -f $(OBJECT)
clean : tidy
	rm -f $(TARGET)
.cvsignore :
	@for i in Makefile '.B4*' $(OBJECT) $(TARGET); do echo "$$i"; done >.cvsignore
NOTitr_4.tmc : NOTitr_4.cyc
	cycle NOTitr_4.cyc >NOTitr_4.tmc
