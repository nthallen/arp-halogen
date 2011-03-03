# Makefile Generated Thu Mar 03 09:42:23 EST 2011
MNC=Hal
HOMEDIR=/home/Hal/src/TM
SPECFILE=Hal.spec
SRC=idx.idx NOTitr_4.cyc *.edf tlookup*.dat scdc.cmd daspt.cmd
SRC+=idxdrv.cmd Hal.cmd types.tmc base.tmc mux.tmc status.tmc cts.tmc
SRC+=idx.tmc nav.tmc Halcol.tmc idxcol.tmc navcol.tmc muxctrl.c
SRC+=muxctrl.oui rfd.cc rfd.oui idxflag.tmc VT.tmc dstat.tmc
SRC+=SlowCnts.tmc haldiag.tbl therm.tbl gasdiag.tbl H.doit Hal.tma
TOOL=Hal.spec Makefile
SCRIPT=dccc.dccc idx.idx64 interact Experiment.config
OBJ=Halcmd.cc Halcmd.dat Halsrvr.o Halsrvroui.c Halsrvroui.o
OBJ+=Halcol.cc Hal.pcm tm.dac Halcoloui.c Halcoloui.o Halcol.o
OBJ+=muxctrloui.c muxctrl.o muxctrloui.o rfdoui.c rfdoui.o rfd.o
OBJ+=haldiagtbl.tmc hddisp.cc hddispoui.c hddispoui.o hddisp.o
OBJ+=haldiagtblnc.tmc hddispnc.cc hddispncoui.c hddispncoui.o
OBJ+=hddispnc.o thermtbl.tmc thdisp.cc thdispoui.c thdispoui.o
OBJ+=thdisp.o thermtblnc.tmc thdispnc.cc thdispncoui.c thdispncoui.o
OBJ+=thdispnc.o gasdiagtbl.tmc gddisp.cc gddispoui.c gddispoui.o
OBJ+=gddisp.o gasdiagtblnc.tmc gddispnc.cc gddispncoui.c
OBJ+=gddispncoui.o gddispnc.o Hdoit.dep Halalgoa.tmc Halalgo.cc
OBJ+=Halalgooui.c Halalgooui.o Halalgo.o Halclt.o Halcltoui.c
OBJ+=Halcltoui.o Halcltnc.o Halcltncoui.c Halcltncoui.o
TGT=Halsrvr Halcol muxctrl rfd hddisp hddispnc thdisp thdispnc
TGT+=gddisp gddispnc Hdoit Halalgo Halclt Halcltnc
DISTRIB=Hal.pcm tm.dac
IDISTRIB=Experiment.config VERSION Hdoit
SRCDIST=haldiag.tbl therm.tbl gasdiag.tbl Hal.tma types.tmc base.tmc
SRCDIST+=mux.tmc status.tmc cts.tmc idx.tmc nav.tmc
NONRCS=
TMCBASE=types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc
TMCBASE+=nav.tmc
CMDBASE=/usr/local/share/huarp/root.cmd
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
Halalgo : Halalgo.o Halalgooui.o
	$(LINK.normCXX) Halalgo.o Halalgooui.o -ltmpp -ltm -lnort
	$(OUIUSE) Halalgooui.c
Halclt : Halclt.o Halcltoui.o
	$(LINK.normCXX) Halclt.o Halcltoui.o -ltmph -lph -ltmpp -ltm -lnort
	$(OUIUSE) Halcltoui.c
Halcltnc : Halcltnc.o Halcltncoui.o
	$(LINK.normCXX) Halcltnc.o Halcltncoui.o -ltmnc -lncurses -ltmpp -ltm -lnort
	$(OUIUSE) Halcltncoui.c
Halcmd.cc : /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd
	$(CMDGEN) -d Halcmd.dat /usr/local/share/huarp/root.cmd /usr/local/share/huarp/getcon.cmd scdc.cmd daspt.cmd /usr/local/share/huarp/idx64.cmd idxdrv.cmd Hal.cmd
Halsrvr.o : Halcmd.cc
	$(COMPILE.srvr) Halcmd.cc
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
rfdoui.c : rfd.oui $(OUIDIR)/msg.oui
	$(OUI) rfd.oui $(OUIDIR)/msg.oui
rfdoui.o : rfdoui.c
rfd.o : rfd.cc
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
Halalgoa.tmc : Hal.tma Halsrvr
	$(SERVER) ./Halsrvr
	$(TMCALGO) -V "`./Halsrvr -R`" Hal.tma
Halalgo.cc : types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc Halalgoa.tmc
	$(TMC) types.tmc base.tmc mux.tmc status.tmc cts.tmc idx.tmc nav.tmc Halalgoa.tmc
Halalgooui.c : $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
	$(OUI) $(OUIDIR)/tma.oui $(OUIDIR)/dc.oui $(OUIDIR)/msg.oui
Halalgooui.o : Halalgooui.c
Halalgo.o : Halalgo.cc
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
# NOTitr_4.tmc : NOTitr_4.cyc
#   cycle NOTitr_4.cyc >NOTitr_4.tmc
