# Makefile Generated Tue Feb 15 13:20:49 EST 2011
MNC=Hal
HOMEDIR=/home/Hal/src/TM
SPECFILE=Hal.spec
SRC=idx.idx NOTitr_4.cyc *.edf tlookup*.dat sws_init.cmd scdc.cmd
SRC+=daspt.cmd idxdrv.cmd Hal.cmd types.tmc base.tmc mux.tmc
SRC+=status.tmc cts.tmc idx.tmc nav.tmc Halcol.tmc idxcol.tmc
SRC+=navcol.tmc muxctrl.c muxctrl.oui idxflag.tmc VT.tmc dstat.tmc
SRC+=SlowCnts.tmc haldiag.tbl therm.tbl gasdiag.tbl H.doit
TOOL=Hal.spec Makefile
SCRIPT=dccc.dccc idx.idx64 interact Experiment.config
OBJ=Halcmd.c Halcmd.dat Halsrvr.o Halsrvroui.c Halsrvroui.o
OBJ+=Halcol.cc Hal.pcm tm.dac Halcoloui.c Halcoloui.o Halcol.o
OBJ+=muxctrloui.c muxctrl.o muxctrloui.o haldiagtbl.tmc hddisp.cc
OBJ+=hddispoui.c hddispoui.o hddisp.o haldiagtblnc.tmc hddispnc.cc
OBJ+=hddispncoui.c hddispncoui.o hddispnc.o thermtbl.tmc thdisp.cc
OBJ+=thdispoui.c thdispoui.o thdisp.o thermtblnc.tmc thdispnc.cc
OBJ+=thdispncoui.c thdispncoui.o thdispnc.o gasdiagtbl.tmc gddisp.cc
OBJ+=gddispoui.c gddispoui.o gddisp.o gasdiagtblnc.tmc gddispnc.cc
OBJ+=gddispncoui.c gddispncoui.o gddispnc.o Hdoit.dep Halclt.o
OBJ+=Halcltoui.c Halcltoui.o Halcltnc.o Halcltncoui.c Halcltncoui.o
TGT=Halsrvr Halcol muxctrl hddisp hddispnc thdisp thdispnc gddisp
TGT+=gddispnc Hdoit Halclt Halcltnc
DISTRIB=Hal.pcm tm.dac
IDISTRIB=Experiment.config VERSION Hdoit
SRCDIST=haldiag.tbl therm.tbl gasdiag.tbl types.tmc base.tmc mux.tmc
SRCDIST+=status.tmc cts.tmc idx.tmc nav.tmc
NONRCS=
TMCBASE=types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
TMCBASE+=nav.tmc
CMDBASE=sws_init.cmd /usr/local/share/huarp/root.cmd
CMDBASE+=/usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd
CMDBASE+=/usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd
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
	$(LINK.priv) Halsrvr.o Halsrvroui.o -lsubbus -ltm -lnort
	$(OUIUSE) Halsrvroui.c
	$(PROMOTE) Halsrvr
Halcol : Halcol.o Halcoloui.o
	$(LINK.privCXX) Halcol.o Halcoloui.o -lsubbus -ltmpp -ltm -lnort
	$(OUIUSE) Halcoloui.c
	$(PROMOTE) Halcol
muxctrl : muxctrl.o muxctrloui.o
	$(LINK.norm) muxctrl.o muxctrloui.o -ltm -lnort
	$(OUIUSE) muxctrloui.c
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
Hdoit : H.doit
	mkdoit3 -o Hdoit  H.doit
Halclt : Halclt.o Halcltoui.o
	$(LINK.norm) Halclt.o Halcltoui.o -ltmph -lph -ltm -lnort
	$(OUIUSE) Halcltoui.c
Halcltnc : Halcltnc.o Halcltncoui.o
	$(LINK.norm) Halcltnc.o Halcltncoui.o -ltmnc -lncurses -ltm -lnort
	$(OUIUSE) Halcltncoui.c
Halcmd.c : sws_init.cmd /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd
	$(CMDGEN) -d Halcmd.dat sws_init.cmd /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd
Halsrvr.o : Halcmd.c
	$(COMPILE.srvr) Halcmd.c
Halsrvroui.c : $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/cis.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
Halsrvroui.o : Halsrvroui.c
Halcol.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc Halcol.tmc idxcol.tmc navcol.tmc
	$(TMC.col) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc Halcol.tmc idxcol.tmc navcol.tmc
Halcoloui.c : $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/collect.oui $(OUIDIR)/seteuid.oui $(OUIDIR)/subbus.oui $(OUIDIR)/msg.oui
Halcoloui.o : Halcoloui.c
Halcol.o : Halcol.cc
muxctrloui.c : muxctrl.oui $(OUIDIR)/msg.oui
	$(OUI) muxctrl.oui $(OUIDIR)/msg.oui
muxctrl.o : muxctrl.c
muxctrloui.o : muxctrloui.c
haldiagtbl.tmc : haldiag.tbl
	$(TABLE) haldiag.tbl
hddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc haldiagtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc haldiagtbl.tmc
hddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispoui.o : hddispoui.c
hddisp.o : hddisp.cc
haldiagtblnc.tmc : haldiag.tbl
	$(NCTABLE) haldiag.tbl
hddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc haldiagtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc idxflag.tmc VT.tmc dstat.tmc /usr/local/share/huarp/flttime.tmc SlowCnts.tmc haldiagtblnc.tmc
hddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
hddispncoui.o : hddispncoui.c
hddispnc.o : hddispnc.cc
thermtbl.tmc : therm.tbl
	$(TABLE) therm.tbl
thdisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc VT.tmc thermtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc VT.tmc thermtbl.tmc
thdispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispoui.o : thdispoui.c
thdisp.o : thdisp.cc
thermtblnc.tmc : therm.tbl
	$(NCTABLE) therm.tbl
thdispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc VT.tmc thermtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc VT.tmc thermtblnc.tmc
thdispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
thdispncoui.o : thdispncoui.c
thdispnc.o : thdispnc.cc
gasdiagtbl.tmc : gasdiag.tbl
	$(TABLE) gasdiag.tbl
gddisp.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc gasdiagtbl.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc gasdiagtbl.tmc
gddispoui.c : $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispoui.o : gddispoui.c
gddisp.o : gddisp.cc
gasdiagtblnc.tmc : gasdiag.tbl
	$(NCTABLE) gasdiag.tbl
gddispnc.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc gasdiagtblnc.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc dstat.tmc gasdiagtblnc.tmc
gddispncoui.c : $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/nctable.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
gddispncoui.o : gddispncoui.c
gddispnc.o : gddispnc.cc
Hdoit.dep : H.doit
	mkdoit3 -M -o Hdoit  H.doit
-include Hdoit.dep
Halclt.o : Halcmd.c
	$(COMPILE.clt) Halcmd.c
Halcltoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/msg.oui
Halcltoui.o : Halcltoui.c
Halcltnc.o : Halcmd.c
	$(COMPILE.cltnc) Halcmd.c
Halcltncoui.c : $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/kbdclt.oui $(OUIDIR)/nctable.oui $(OUIDIR)/msg.oui
Halcltncoui.o : Halcltncoui.c

tidy :
	rm -f $(OBJECT)
clean : tidy
	rm -f $(TARGET)
.cvsignore :
	@for i in Makefile '.B4*' $(OBJECT) $(TARGET); do echo "$$i"; done >.cvsignore
# NOTitr_4.tmc : NOTitr_4.cyc
#   cycle NOTitr_4.cyc >NOTitr_4.tmc
