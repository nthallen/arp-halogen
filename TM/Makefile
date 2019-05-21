# Makefile Generated Tue May 21 10:02:34 MDT 2019
MNC=Hal
SPECFILE=Hal.spec
PCMFILE=Hal.pcm
SRC=idx.idx NOTitr_4.cyc Calc.edf HAL1.edf HAL2.edf HAL3.edf
SRC+=INST1.edf INST2.edf INST6.edf NOTitr_4.edf STAT.edf haleng.edf
SRC+=tlookup*.dat /usr/local/share/huarp/root.cmd
SRC+=/usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd
SRC+=/usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd rfd.cmd
SRC+=-lsubbus types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
SRC+=rfd.tmc nav.tmc T30K1MU.tmc Halcol.tmc idxcol.tmc navcol.tmc
SRC+=muxctrl.c muxctrl.oui rfd.cc rfd.oui Hal.sol idxflag.tmc VT.tmc
SRC+=dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc
SRC+=rfdbits.tmc haldiag.tbl VI.tmc therm.tbl dhtr.tbl gasdiag.tbl
SRC+=Rover.tbl H.doit Half.tma Halog.tma Hal.tma NOTitr_4.tmc
SRC+=check.tmc haleng.cdf Hal.pcm
TOOL=Hal.spec Makefile
SCRIPT=dccc.dccc idx.idx64 interact Experiment.config runfile.FF
OBJ=NOTitr_4.tmc Halcmd.cc Halcmd.dat Halsrvr.o Halsrvroui.c
OBJ+=Halsrvroui.o Halcol.cc tm.dac Halcoloui.c Halcoloui.o Halcol.o
OBJ+=muxctrloui.c muxctrl.o muxctrloui.o rfdoui.c rfdoui.o rfd.o
OBJ+=haldiagtbl.tmc hddisp.cc hddispoui.c hddispoui.o hddisp.o
OBJ+=haldiagtblnc.tmc hddispnc.cc hddispncoui.c hddispncoui.o
OBJ+=hddispnc.o thermtbl.tmc dhtrtbl.tmc thdisp.cc thdispoui.c
OBJ+=thdispoui.o thdisp.o thermtblnc.tmc dhtrtblnc.tmc thdispnc.cc
OBJ+=thdispncoui.c thdispncoui.o thdispnc.o gasdiagtbl.tmc gddisp.cc
OBJ+=gddispoui.c gddispoui.o gddisp.o gasdiagtblnc.tmc gddispnc.cc
OBJ+=gddispncoui.c gddispncoui.o gddispnc.o Rovertbl.tmc rvdisp.cc
OBJ+=rvdispoui.c rvdispoui.o rvdisp.o Rovertblnc.tmc rvdispnc.cc
OBJ+=rvdispncoui.c rvdispncoui.o rvdispnc.o Hdoit.dep Halfalgoa.tmc
OBJ+=Halfalgo.cc Halfalgooui.c Halfalgooui.o Halfalgo.o Halalgoa.tmc
OBJ+=Halalgo.cc Halalgooui.c Halalgooui.o Halalgo.o Calcextedf.oui
OBJ+=Calcext.tmc Calcext.cc Calcextoui.c Calcextoui.o Calcext.o
OBJ+=NOTitr_4extedf.oui NOTitr_4ext.tmc NOTitr_4ext.cc
OBJ+=NOTitr_4extoui.c NOTitr_4extoui.o NOTitr_4ext.o halengextcdf.oui
OBJ+=halengcdf.tmc halengext.cc halengextoui.c halengextoui.o
OBJ+=halengext.o checkext.cc checkextoui.c checkextoui.o checkext.o
OBJ+=Halclt.o Halcltoui.c Halcltoui.o Halcltnc.o Halcltncoui.c
OBJ+=Halcltncoui.o haldiagtbl.tmc.dep haldiagtblnc.tmc.dep
OBJ+=thermtbl.tmc.dep dhtrtbl.tmc.dep thermtblnc.tmc.dep
OBJ+=dhtrtblnc.tmc.dep gasdiagtbl.tmc.dep gasdiagtblnc.tmc.dep
OBJ+=Rovertbl.tmc.dep Rovertblnc.tmc.dep
TGT=Halsrvr Halcol muxctrl rfd Hal.sft hddisp hddispnc thdisp
TGT+=thdispnc gddisp gddispnc rvdisp rvdispnc Hdoit Halfalgo Halalgo
TGT+=Calcext NOTitr_4ext halengext checkext Halclt Halcltnc
IGNORE=Makefile
DISTRIB=Hal.pcm tm.dac
IDISTRIB=Experiment.config VERSION Hdoit
SRCDIST=Hal.sol haldiag.tbl therm.tbl dhtr.tbl gasdiag.tbl Rover.tbl
SRCDIST+=Half.tma Halog.tma Hal.tma types.tmc base.tmc mux.tmc
SRCDIST+=status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc
TMCBASE=types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
TMCBASE+=rfd.tmc nav.tmc T30K1MU.tmc
CMDBASE=/usr/local/share/huarp/root.cmd
CMDBASE+=/usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd
CMDBASE+=/usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd rfd.cmd
COLBASE=
SWSBASE=
QCLIBASE=
GENUIBASE=
EXTBASE=
SPECDEPBASE=
SPECTGTBASE=
SPECTGTMISS:=$(foreach file,$(SPECTGTBASE),$(if $(wildcard $(file)),,$(file)))
AG_CPPFLAGS=
PHTGT=haldiagtbl.tmc thermtbl.tmc dhtrtbl.tmc gasdiagtbl.tmc
PHTGT+=Rovertbl.tmc
SOURCE=$(SRC) $(TOOL) $(SCRIPT)
OBJECT=$(OBJ) *.err
TARGET=$(TGT)
DSTRB=$(TGT) $(DISTRIB) $(SCRIPT)
TGTDIR= $(TGTNODE)/home/Hal
include /usr/local/share/huarp/appgen.mk

.PHONY : all all-dist extdistribution distribution clean clean-dist check_photon

IGNOREFILE=.gitignore
all : check_photon $(TGT) $(IGNOREFILE)
all-dist : all $(DSTRB) $(SRCDIST) VERSION
Makefile $(SPECTGTMISS) : Hal.spec $(SPECDEPBASE)
	appgen Hal.spec
VERSION=`cat VERSION`
extdistribution : all-dist
	@[ -d $(TGTDIR)/bin ] || mkdir $(TGTDIR)/bin
	@[ -d $(TGTDIR)/bin/$(VERSION) ] || mkdir $(TGTDIR)/bin/$(VERSION)
	@[ -d $(TGTDIR)/bin/$(VERSION)/Base ] || mkdir $(TGTDIR)/bin/$(VERSION)/Base
	@[ ! -f $(TGTDIR)/bin/$(VERSION)/$(PCMFILE) ] || \
	  cmp -s $(TGTDIR)/bin/$(VERSION)/$(PCMFILE) $(PCMFILE) || \
	  ( echo "$(PCMFILE) changed without VERSION update"; false )
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION) $(DSTRB)
	@distribute $(FORCE) $(TGTDIR)/bin/$(VERSION)/Base $(SRCDIST)
distribution : extdistribution
	@distribute $(FORCE) $(TGTDIR) $(IDISTRIB)
check_photon :
ifeq ($(WPHOTON),YES)
	@for tgt in $(PHTGT); do \
	  cmp -s $$tgt /usr/local/share/huarp/nulltbl.tmc && echo Remaking $$tgt && rm -f $$tgt; \
	done; true
endif
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
Halfalgo : Halfalgo.o Halfalgooui.o
	$(LINK.normCXX) Halfalgo.o Halfalgooui.o -ltmpp -ltm -lnort
	$(OUIUSE) Halfalgooui.c
Halalgo : Halalgo.o Halalgooui.o
	$(LINK.normCXX) Halalgo.o Halalgooui.o -ltmpp -ltm -lnort
	$(OUIUSE) Halalgooui.c
Calcext : Calcext.o Calcextoui.o
	$(LINK.normCXX) Calcext.o Calcextoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) Calcextoui.c
NOTitr_4ext : NOTitr_4ext.o NOTitr_4extoui.o
	$(LINK.normCXX) NOTitr_4ext.o NOTitr_4extoui.o -ltmpp -ltm -lssp -lmem -lm -lnort
	$(OUIUSE) NOTitr_4extoui.c
halengext : halengext.o halengextoui.o
	$(LINK.normCXX) halengext.o halengextoui.o -ltmpp -ltm -lnort
	$(OUIUSE) halengextoui.c
checkext : checkext.o checkextoui.o
	$(LINK.normCXX) checkext.o checkextoui.o -ltmpp -ltm -lnort
	$(OUIUSE) checkextoui.c
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
Halcol.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halcol.tmc idxcol.tmc navcol.tmc VERSION
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
-include haldiagtbl.tmc.dep
hddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtbl.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtbl.tmc
hddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispoui.o : hddispoui.c
hddisp.o : hddisp.cc
haldiagtblnc.tmc : haldiag.tbl
-include haldiagtblnc.tmc.dep
hddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtblnc.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc rfdbits.tmc haldiagtblnc.tmc
hddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispncoui.o : hddispncoui.c
hddispnc.o : hddispnc.cc
thermtbl.tmc : therm.tbl
-include thermtbl.tmc.dep
dhtrtbl.tmc : dhtr.tbl
-include dhtrtbl.tmc.dep
thdisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc VI.tmc /usr/local/share/huarp/flttime.tmc thermtbl.tmc dhtrtbl.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc VI.tmc /usr/local/share/huarp/flttime.tmc thermtbl.tmc dhtrtbl.tmc
thdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispoui.o : thdispoui.c
thdisp.o : thdisp.cc
thermtblnc.tmc : therm.tbl
-include thermtblnc.tmc.dep
dhtrtblnc.tmc : dhtr.tbl
-include dhtrtblnc.tmc.dep
thdispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc VI.tmc /usr/local/share/huarp/flttime.tmc thermtblnc.tmc dhtrtblnc.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc VT.tmc VI.tmc /usr/local/share/huarp/flttime.tmc thermtblnc.tmc dhtrtblnc.tmc
thdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispncoui.o : thdispncoui.c
thdispnc.o : thdispnc.cc
gasdiagtbl.tmc : gasdiag.tbl
-include gasdiagtbl.tmc.dep
gddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtbl.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtbl.tmc
gddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispoui.o : gddispoui.c
gddisp.o : gddisp.cc
gasdiagtblnc.tmc : gasdiag.tbl
-include gasdiagtblnc.tmc.dep
gddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtblnc.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc gasdiagtblnc.tmc
gddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispncoui.o : gddispncoui.c
gddispnc.o : gddispnc.cc
Rovertbl.tmc : Rover.tbl
-include Rovertbl.tmc.dep
rvdisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertbl.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertbl.tmc
rvdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
rvdispoui.o : rvdispoui.c
rvdisp.o : rvdisp.cc
Rovertblnc.tmc : Rover.tbl
-include Rovertblnc.tmc.dep
rvdispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertblnc.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Rovertblnc.tmc
rvdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
rvdispncoui.o : rvdispncoui.c
rvdispnc.o : rvdispnc.cc
Hdoit.dep : H.doit
	mkdoit3 -M -o Hdoit  H.doit
-include Hdoit.dep
Halfalgoa.tmc : Half.tma Halog.tma Halsrvr
	$(SERVER) ./Halsrvr
	$(TMCALGO) -V "`./Halsrvr -R`" Half.tma Halog.tma
Halfalgo.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc idxflag.tmc VT.tmc Halfalgoa.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc dstat.tmc idxflag.tmc VT.tmc Halfalgoa.tmc
Halfalgooui.c : $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
Halfalgooui.o : Halfalgooui.c
Halfalgo.o : Halfalgo.cc
Halalgoa.tmc : Hal.tma Halsrvr
	$(SERVER) ./Halsrvr
	$(TMCALGO) -V "`./Halsrvr -R`" Hal.tma
Halalgo.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halalgoa.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc Halalgoa.tmc
Halalgooui.c : $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
Halalgooui.o : Halalgooui.c
Halalgo.o : Halalgo.cc
Calcextedf.oui : Calc.edf
	$(EDF2OUI) Calc.edf
Calcext.tmc : Calc.edf
	$(EDF2EXT) Calc.edf
Calcext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc Calcext.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc Calcext.tmc
Calcextoui.c : Calcextedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) Calcextedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
Calcextoui.o : Calcextoui.c
Calcext.o : Calcext.cc
NOTitr_4extedf.oui : NOTitr_4.edf
	$(EDF2OUI) NOTitr_4.edf
NOTitr_4ext.tmc : NOTitr_4.edf
	$(EDF2EXT) NOTitr_4.edf
NOTitr_4ext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc NOTitr_4.tmc NOTitr_4ext.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc VT.tmc NOTitr_4.tmc NOTitr_4ext.tmc
NOTitr_4extoui.c : NOTitr_4extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) NOTitr_4extedf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
NOTitr_4extoui.o : NOTitr_4extoui.c
NOTitr_4ext.o : NOTitr_4ext.cc
halengextcdf.oui : haleng.cdf
	$(EDF2OUI) haleng.cdf
halengcdf.tmc : haleng.cdf
	$(EDF2EXT) haleng.cdf
halengext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc /usr/local/share/huarp/flttime.tmc check.tmc halengcdf.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc /usr/local/share/huarp/flttime.tmc check.tmc halengcdf.tmc
halengextoui.c : halengextcdf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) halengextcdf.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
halengextoui.o : halengextoui.c
halengext.o : halengext.cc
checkext.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc /usr/local/share/huarp/flttime.tmc check.tmc VERSION
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc rfd.tmc nav.tmc T30K1MU.tmc /usr/local/share/huarp/flttime.tmc check.tmc
checkextoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
checkextoui.o : checkextoui.c
checkext.o : checkext.cc
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
clean-dist : clean
$(IGNOREFILE) : Makefile
	@for i in $(OBJECT) $(IGNORE) $(TARGET); do echo "$$i"; done >$(IGNOREFILE)
CFLAGS=-Wall -g
CXXFLAGS=-Wall -g
NOTitr_4.tmc : NOTitr_4.cyc
	cycle NOTitr_4.cyc >NOTitr_4.tmc
haleng.cdf : genui.txt
	genui -d ../eng -c genui.txt
